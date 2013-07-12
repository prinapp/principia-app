//
//  CourseGList.m
//  Principia
//
//  Created by Austin Dauterman on 4/27/13.
//
//

#import "CourseGList.h"
#import "RegexParser.h"
#import "SMWebRequest.h"
#import "DataUtil.h"
#import "TouchXML.h"
#import "ErrorHandler.h"

@interface CourseGList ()

@end

@implementation CourseGList
@synthesize tableViewArray, headers, instructorname, instemail, pic, rowcount;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) initCourseSummary:(int) iCrn{
    classcrn = iCrn;
}


- (BOOL)execSearch {
    BOOL found=false;
    
    if (tableViewArray == nil)
        tableViewArray = [NSMutableArray new];
    else
        [tableViewArray removeAllObjects];
    
    
    
    
    
    return found;
}

-(void)requestError:(NSError *)theError
{
 if([self isViewLoaded])
 {
     UIAlertView *errorMessage = [[UIAlertView alloc]initWithTitle:@"Application Error" message:[ErrorHandler printError:theError] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
     [errorMessage show];
 }
}

-(void)parseCourseDetail:(NSData *)data
{
    CXMLDocument *searchdoc = [[CXMLDocument alloc] initWithData:data options:0 error:nil];
    NSArray *details = [searchdoc nodesForXPath:@"//Course" error:nil];
    
    for(CXMLElement *detail in details)
    {
        NSMutableDictionary *detailEntry = [[NSMutableDictionary alloc]init];
        [detailEntry setValue:[NSNumber numberWithInt:classcrn] forKey:@"CRN"];
        [detailEntry setValue:[[detail childAtIndex:3] stringValue] forKey:@"NUMBER"];
        [detailEntry setValue:[[detail childAtIndex:5] stringValue] forKey:@"TITLE"];
        [detailEntry setValue:[[detail childAtIndex:7] stringValue] forKey:@"SUBJECT"];
        [detailEntry setValue:[[detail childAtIndex:9] stringValue] forKey:@"DAYS"];
        [detailEntry setValue:[[detail childAtIndex:11] stringValue] forKey:@"DAYS2"];
        [detailEntry setValue:[[detail childAtIndex:13] stringValue]forKey:@"TIME"];
        [detailEntry setValue:[[detail childAtIndex:15] stringValue]forKey:@"TIME2"];
        [detailEntry setValue:[[detail childAtIndex:17] stringValue] forKey:@"REGISTERED"];
        [detailEntry setValue:[[detail childAtIndex:19] stringValue] forKey:@"LIMIT"];
        [detailEntry setValue:[[detail childAtIndex:21] stringValue]forKey:@"PREREQ"];
        [detailEntry setValue:[[detail childAtIndex:23] stringValue] forKey:@"BLDG"];
        [detailEntry setValue:[[detail childAtIndex:25] stringValue] forKey:@"BLDG2"];
        [detailEntry setValue:[[detail childAtIndex:27] stringValue] forKey:@"OPENTO"];
        [detailEntry setValue:[[detail childAtIndex:29] stringValue]forKey:@"ATT1"];
        [detailEntry setValue:[[detail childAtIndex:31] stringValue]forKey:@"ATT2"];
        [detailEntry setValue:[[detail childAtIndex:33] stringValue]forKey:@"ATT3"];
        [detailEntry setValue:[[detail childAtIndex:35] stringValue]forKey:@"ATT4"];
        [detailEntry setValue:[[detail childAtIndex:37] stringValue]forKey:@"INSTRUCTOR"];
        [detailEntry setValue:[[detail childAtIndex:39] stringValue]forKey:@"ROOM"];
        [detailEntry setValue:[[detail childAtIndex:41] stringValue]forKey:@"ROOM2"];
        
        [tableViewArray addObject:detailEntry];
        instructorname = [detailEntry objectForKey:@"INSTRUCTOR"];
    }
    [self loadsearchrequest];
    
    NSString *days2 = [[tableViewArray objectAtIndex:0] objectForKey:@"DAYS2"];
    int i;
    if ([days2 isEqual: @""]) i = 2;
    else i = 4;
    
    headers = [[NSArray alloc] initWithObjects:
               @"Title",@"Instructor", @"Day, Time & Location", @"Description", @"Other Info", @"Attributes", nil];
    rowcount = [[NSArray alloc] initWithObjects:
                [NSNumber numberWithInt:2],
                [NSNumber numberWithInt:1],
                [NSNumber numberWithInt:i],
                [NSNumber numberWithInt:1],
                [NSNumber numberWithInt:3],
                [NSNumber numberWithInt:1],
                nil];
    [self.tableView reloadData];

}

-(void)getCourseDetail
{
    NSString *request = [NSString stringWithFormat:@"http://prinapp.geektron.me/requests/courseDetail.php?crn=%d", classcrn];
    [DataUtil GetDataToParse:request :@"parseCourseDetail:" :self];
}

-(void)ParseFlashy:(NSData *)data
{
    
    NSMutableDictionary *rowentry;
    RegexParser *parse = [[RegexParser alloc] init];
    
    NSArray *testarr = [[NSArray alloc] initWithObjects:
                        @"mailto:.+'",
                        @"/phone/new_faces_pictures/Andover_Extract_Files/\\d+\\.jpg",
                        @"/phone/new_faces_pictures/\\d+\\.jpg",
                        nil];
    
    NSArray *DirtyParams = [[NSArray alloc] initWithObjects:
                            @"mailto:",
                            nil];
    
    NSArray *keys = [[NSArray alloc] initWithObjects:
                     @"email",
                     @"pic",
                     @"secpic",
                     nil];
    [parse AddPatterns:testarr];
    [parse AddDirtyParams:DirtyParams];
    
    NSString *HTML = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSArray *Sepstr = [HTML componentsSeparatedByString:@"<!-- Info for "];
    
    for (int index = 1; index<[Sepstr count];index++)
    {
        NSString *nothing = @"N/A";
        NSString *StrAnlz = [Sepstr objectAtIndex:index];
        rowentry = [[NSMutableDictionary alloc] initWithObjects:[parse Output:StrAnlz] forKeys:keys];
        NSString *picstr = [rowentry objectForKey:@"pic"];
        instemail = [rowentry objectForKey:@"email"];
        NSString *scdpic = [rowentry objectForKey:@"secpic"];
        if ([picstr isEqualToString:nothing]){
            picstr = scdpic;
        }
        picstr = [NSString stringWithFormat:@"http://prinweb.prin.edu%@",picstr];
        NSURL *url = [NSURL URLWithString:picstr];
        NSData *imagedata = [[NSData alloc] initWithContentsOfURL:url];
        pic = [[UIImage alloc] initWithData:imagedata];
    }
    [self.tableView reloadData];
}

-(void)loadsearchrequest
{
    NSString *search = [instructorname stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    search = [search stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSURL *searchreq = [[NSURL alloc] initWithString:[NSString stringWithFormat:
                                                      @"http://prinweb.prin.edu/hagus/index.php3?eDir_search=%@&campus_search=elsah&gobutton=++++Search++++",search]];
    SMWebRequest * request = [SMWebRequest requestWithURL:searchreq];
    
    [request addTarget:self action:@selector(ParseFlashy:) forRequestEvents:SMWebRequestEventComplete];
    [request addTarget:self action:@selector(requestError:) forRequestEvents:SMWebRequestEventError];
    [request start];
}

- (void)viewDidLoad
{
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:0.212 blue:0.416 alpha:1.0];
    [super viewDidLoad];
    if (tableViewArray == nil)
        tableViewArray = [NSMutableArray new];
    else
        [tableViewArray removeAllObjects];
    [self getCourseDetail];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [rowcount count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[rowcount objectAtIndex:section] integerValue];
}

-(int)getTextHeight:(NSString *)astr {
    int width=250;
    if ((self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft) || (self.interfaceOrientation==UIInterfaceOrientationLandscapeRight))
        width=415;
    CGSize constraint = CGSizeMake(width, 20000.0f);
    CGSize size = [astr sizeWithFont:[UIFont fontWithName:@"Helvetica" size:(CGFloat)17] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    return size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section]==1) {
        return 100;
    }
    else if ([indexPath section]==3) {
        NSDictionary *rowdata = [tableViewArray objectAtIndex:0];
        int height=[self getTextHeight :[rowdata objectForKey:@"DESCRIP"]];
        return height;
    }
    else
        return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = 0;
    // Set the text of the cell to the row index.
    NSDictionary *rowdata = [tableViewArray objectAtIndex:row];

    UITableViewCell *cell;
    if (indexPath.section==1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"csumpic"];
        if (!cell)
            cell = [[[NSBundle mainBundle] loadNibNamed:@"csumpic" owner:self options:nil] lastObject];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
    }
    
    switch (indexPath.section){
        case 0:{
            if (indexPath.row == 0) {
                cell.textLabel.text = [rowdata objectForKey:@"TITLE"];
            }
            
            if (indexPath.row == 1) {
                NSString *subject = [rowdata objectForKey:@"SUBJECT"];
                int coursenumber = [[rowdata objectForKey:@"NUMBER"] intValue];
                NSString *section = [rowdata objectForKey:@"SECTION"];
                NSString *number = [NSString stringWithFormat:@"%d", coursenumber];
                NSArray *tempArray = [NSArray arrayWithObjects:subject, number, section, nil];
                NSString *temp = @"";
                temp = [temp stringByAppendingString:[tempArray componentsJoinedByString:@" "]];
                cell.textLabel.text = temp;
            }
        }
            break;
        case 1:
            if (indexPath.row == 0){
                NSString *instructor = [rowdata objectForKey:@"INSTRUCTOR"];
                [(UILabel *)[cell viewWithTag:100] setText:instructor];
                [((UIImageView *)[cell viewWithTag:101]) setImage:pic];
                [(UILabel *)[cell viewWithTag:102] setText:instemail];
            }
            break;
        case 2:
            if (indexPath.row == 0){
                NSString *days = [rowdata objectForKey:@"DAYS"];
                NSString *time = [rowdata objectForKey:@"TIME"];
                NSArray *tempArray = [NSArray arrayWithObjects:days, time, nil];
                NSString *temp = @"";
                temp = [temp stringByAppendingString:[tempArray componentsJoinedByString:@" "]];
                cell.textLabel.text = temp;
            }
            if (indexPath.row == 1){
                NSString *bldg = [rowdata objectForKey:@"BLDG"];
                NSString *room = [rowdata objectForKey:@"ROOM"];
                NSArray *tempArray = [NSArray arrayWithObjects:bldg, room, nil];
                NSString *temp = @"";
                temp = [temp stringByAppendingString:[tempArray componentsJoinedByString:@" "]];
                cell.textLabel.text = temp;
            }
            if (indexPath.row == 2){
                NSString *days2 = [rowdata objectForKey:@"DAYS2"];
                NSString *time2 = [rowdata objectForKey:@"TIME2"];
                NSArray *tempArray = [NSArray arrayWithObjects:days2, time2, nil];
                NSString *temp = @"";
                temp = [temp stringByAppendingString:[tempArray componentsJoinedByString:@" "]];
                cell.textLabel.text = temp;
            }
            if (indexPath.row == 3){
                NSString *bldg2 = [rowdata objectForKey:@"BLDG2"];
                NSString *room2 = [rowdata objectForKey:@"ROOM2"];
                NSArray *tempArray = [NSArray arrayWithObjects:bldg2, room2, nil];
                NSString *temp = @"";
                temp = [temp stringByAppendingString:[tempArray componentsJoinedByString:@" "]];
                cell.textLabel.text = temp;
            }
            break;
        case 3:
            if (indexPath.row == 0){
                NSString *descrip = [rowdata objectForKey:@"DESCRIP"];
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.text = descrip;
            }
            break;
        case 4:
            if (indexPath.row == 0){
                int fee = [[rowdata objectForKey:@"FEE"] intValue];
                BOOL hasFee = FALSE;
                if (fee != 0) hasFee = TRUE;
                if (fee){
                    cell.textLabel.text = [NSString stringWithFormat:@"Fee: %d", fee];
                } else {
                    cell.textLabel.text = @"No Fee";
                }
            }
            if (indexPath.row == 1){
                NSString *prereq = [rowdata objectForKey:@"PREREQ"];
                BOOL hasPrereq =  TRUE;
                if ([prereq isEqual:@""]) hasPrereq = FALSE;
                if (hasPrereq){
                    cell.textLabel.text = @"Prerequisite: Y";
                } else {
                    cell.textLabel.text = @"Prerequisite: N";
                }
            }
            if (indexPath.row == 2){
                NSString *opento = [rowdata objectForKey:@"OPENTO"];
                NSString *opener = @"Open to: ";
                NSString *temp = [opener stringByAppendingString:opento];
                cell.textLabel.text = temp;
            }
            break;
        case 5:
            if (indexPath.row == 0){
                NSString *att1 = [rowdata objectForKey:@"ATT1"];
                NSString *att2 = [rowdata objectForKey:@"ATT2"];
                NSString *att3 = [rowdata objectForKey:@"ATT3"];
                NSString *att4 = [rowdata objectForKey:@"ATT4"];
                NSArray *tempArray = [NSArray arrayWithObjects:att1, att2, att3, att4, nil];
                NSString *temp = @"";
                temp = [temp stringByAppendingString:[tempArray componentsJoinedByString:@" "]];
                cell.textLabel.text = temp;
            }
            break;
        default:
            break;
            }

        return cell;
    }

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [headers objectAtIndex:section];
    }



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
