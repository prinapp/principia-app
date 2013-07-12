 //
//  Directory.m
//  Principia
//
//  Created by Shirley Paulson on 11/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Directory.h"
#import "SMWebRequest.h"
#import "RegexParser.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GlobalUtil.h"
//#import "NoConnect.h"


@implementation Directory

@synthesize dirSearchBar;
@synthesize searchText;
@synthesize tabData;
@synthesize notavail,ImageArray;
@synthesize selectedEmail;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"eDirectory", @"eDirectory");
        self.tabBarItem.image = [UIImage imageNamed:@"people"];
    }
    return self;
}

//------------------------------------------------------------------------------------
#pragma mark HTTP Search Request

-(void)requestError
{
    GlobalUtil *obj= [GlobalUtil GetFlashy];
    if(![obj RtnConTest])
    {
        [GlobalUtil showNoNetScreen];
    }
}

-(void)ParseFlashy:(NSData *)data
{
    
    NSMutableDictionary *rowentry;
    RegexParser *parse = [[RegexParser alloc] init];
    
    NSArray *testarr = [[NSArray alloc] initWithObjects:
                       @".+: -",
                       @"red>\\d+",
                       @"freshman|sophomore|junior|senior|Non-Degree",
                       @"residence:</td><td>\\s+\\w+-?\\w+",
                       @"Mailbox # :</td><td>\\d+",
                       @"mailto:.+'",
                       @"/phone/new_faces_pictures/Andover_Extract_Files/\\d+\\.jpg",
                       @"/phone/new_faces_pictures/\\d+\\.jpg",
                        
                       nil];
    
    NSArray *DirtyParams = [[NSArray alloc] initWithObjects:
                            @": -",
                            @"red>",
                            @"Residence:</td><td>           ",
                            @"Mailbox # :</td><td>",
                            @"mailto:",
                            nil];
                            
    NSArray *keys = [[NSArray alloc] initWithObjects:
                     @"name",
                     @"ext",
                     @"class",
                     @"residence",
                     @"mailbox",
                     @"email",
                     @"pic",
                     @"scdpic",
                     nil];
    [parse AddPatterns:testarr];
    [parse AddDirtyParams:DirtyParams];
    
    NSString *HTML = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSArray *Sepstr = [HTML componentsSeparatedByString:@"<!-- Info for "];
    
    for (int index = 1; index<[Sepstr count];index++) 
    {
        NSString *StrAnlz = [Sepstr objectAtIndex:index];
        rowentry = [[NSMutableDictionary alloc] initWithObjects:[parse Output:StrAnlz] forKeys:keys];
        selectedEmail = [rowentry objectForKey:@"email"];
        selectedEmail = [selectedEmail stringByReplacingOccurrencesOfString:@"'" withString:@""];
      
        [tabData addObject:rowentry];
    }
   if(tabData.count == 0)
   {
       UIAlertView *NonFound = [[UIAlertView alloc] initWithTitle:@"No Results Found" message:[NSString stringWithFormat:@"Cannot find %@ in eDirectory", searchText] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
       [NonFound show];
   }
    [self.tableView reloadData];
}

-(void)loadsearchrequest
{
    NSString *search = [self.searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    search = [search stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSURL *searchreq = [[NSURL alloc] initWithString:[NSString stringWithFormat:
                                                      @"http://prinweb.prin.edu/hagus/index.php3?eDir_search=%@&campus_search=elsah&gobutton=++++Search++++",search]];
    SMWebRequest * request = [SMWebRequest requestWithURL:searchreq];
    
    [request addTarget:self action:@selector(ParseFlashy:) forRequestEvents:SMWebRequestEventComplete];
    [request addTarget:self action:@selector(requestError) forRequestEvents:SMWebRequestEventError];
    [request start];    
    
}

- (void) execSearch {
    [self loadsearchrequest];
    if (tabData == nil)
        tabData = [NSMutableArray new];
    else
        [tabData removeAllObjects];
    
    
    [self.tableView reloadData];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    //get the name of the current pressed button
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([buttonTitle isEqualToString:@"Email This Person"]){
        
        
        if ([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
            controller.mailComposeDelegate = self;
            NSArray *toRecipients = [NSArray arrayWithObject:selectedEmail];
            [controller setToRecipients:toRecipients];
        
            [controller setSubject:[NSString stringWithFormat:@""]];

            [self presentViewController:controller animated:YES completion:nil];
        }
    }
    if ([buttonTitle isEqualToString:@"Cancel"]){
        NSLog(@"Cancel pressed --> Cancel ActionSheet");
    }
    
}



- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text=nil;
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.searchText = dirSearchBar.text;
    NSLog(@"Search string: %@",self.searchText);
    if (![[self.searchText stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
        [searchBar resignFirstResponder];
        //[self.appDelegate showActivityViewer];
        [self performSelector:@selector(execSearch) withObject:NULL afterDelay:0.0];
        
        
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    if (tabData == nil)
        tabData = [NSMutableArray new];
    else
        [tabData removeAllObjects];
    
    [dirSearchBar becomeFirstResponder];
    ImageArray = [NSMutableArray new];
    [self.tableView reloadData];
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"none_available" ofType:@"gif"];

    notavail = [[UIImage alloc] initWithContentsOfFile:filepath];  
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:0.212 blue:0.416 alpha:1.0];    
}

//------------------------------------------------------------------------------------

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
- (void)showNoNetScreen
{
    UIAlertView *connectionalert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"Unable to search for names. Please connect to Principia's WIFI network" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [connectionalert show];

}

- (void)viewWillAppear:(BOOL)animated
{
    GlobalUtil *obj = [GlobalUtil GetFlashy];
    if (![obj RtnConTest]) {
        [GlobalUtil showNoNetScreen];
    }
}

//------------------------------------------------------------------------------------


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

//------------------------------------------------------------------------------------
// numberOfRowsInSection
//
// returns the number of rows in the table

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    return [tabData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 128;
}

//------------------------------------------------------------------------------------
// cellForRowAtIndexPath
//
// provides and creates cells for the tableview

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = [indexPath row];
    // Set the text of the cell to the row index.
    NSDictionary *rowdata = [tabData objectAtIndex:row];
    NSString *name=[rowdata objectForKey:@"name"];
    NSString *ext=[rowdata objectForKey:@"ext"];
    NSString *class=[rowdata objectForKey:@"class"];
    NSString *residence=[rowdata objectForKey:@"residence"];
    NSString *mail=[rowdata objectForKey:@"mailbox"];
    NSString *picstr=[rowdata objectForKey:@"pic"];
    NSString *scdpic = [rowdata objectForKey:@"scdpic"];
    NSString *email = [rowdata objectForKey:@"email"];
    NSString *nothing = @"N/A";
    
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"DirectCell"];
    if (!cell) 
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DirectCell" owner:self options:nil] lastObject];
    
    [(UILabel *)[cell viewWithTag:100] setText:name];
    [(UILabel *)[cell viewWithTag:101] setText:ext];
    if(![class isEqualToString:nothing]){
        [[cell viewWithTag:102] setHidden:NO];
    [(UILabel *)[cell viewWithTag:102] setText:class];
    }
    if(![residence isEqualToString:nothing])
    {
    [[cell viewWithTag:103] setHidden:NO];
    [(UILabel *)[cell viewWithTag:103] setText:residence];
    }
    if(![mail isEqualToString:nothing])
    {
    [[cell viewWithTag:104] setHidden:NO];
    mail = [mail stringByReplacingOccurrencesOfString:@"'" withString:@""];
    [(UILabel *)[cell viewWithTag:104] setText:[NSString stringWithFormat:@"Mailbox: %@",mail]];
    }
    email = [email stringByReplacingOccurrencesOfString:@"'" withString:@""];
    if(![email isEqualToString:nothing])
    {
        [[cell viewWithTag:106] setHidden:NO];
        [(UILabel *)[cell viewWithTag:106] setText:email];
    }
    
    
    if ([picstr isEqualToString:nothing]) {
        picstr = scdpic;
    }
    
    picstr = [NSString stringWithFormat:@"http://prinweb.prin.edu%@",picstr];
    NSURL *url = [NSURL URLWithString:picstr];/*
    NSData *imagedata = [[NSData alloc] initWithContentsOfURL:url];
    UIImage *pic = [[UIImage alloc] initWithData:imagedata];*/
     
    [((UIImageView *)[cell viewWithTag:105]) setImageWithURL:url placeholderImage:[UIImage imageNamed:@"none_available.gif"]];
    
    return cell;
}

//------------------------------------------------------------------------------------
// didSelectRowAtIndexPath
//
// executes when user taps a cell

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    selectedEmail = [(UILabel *)[cell viewWithTag:106] text];
    NSInteger row = [indexPath row];
    NSDictionary *rowdata = [tabData objectAtIndex:row];
    NSString *actionSheetTitle=[rowdata objectForKey:@"name"];
    NSString *button1 = @"Email This Person";
    NSString *cancelTitle = @"Cancel";
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:actionSheetTitle
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:button1, nil];
    [actionSheet showFromTabBar:self.tabBarController.tabBar];

    }

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if (result == MFMailComposeResultSent) {
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


//------------------------------------------------------------------------------------
// numberOfSectionsInTableView
//
// specifies how many sections there are in the table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


//------------------------------------------------------------------------------------

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSLog(@"Data File Path: %@",documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:kFileName];
    
}


@end
