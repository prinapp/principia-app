//
//  CourseDetail.m
//  Principia
//
//  Created by Dale Matheny on 11/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CourseSearch.h"
#import "CourseSummaryViewController.h"
#import "CourseGList.h"
#import "RegexParser.h"
#import "SMWebRequest.h"
#import <EventKit/EventKit.h>
#import "GlobalUtil.h"
#import "TouchXML.h"
#import "DataUtil.h"

@implementation CourseSearch

@synthesize tableViewArray;
@synthesize sBar, searchText, email, instructorname;
@synthesize course_days, course_time, course_bldg, course_room, course_title,term, Semesters;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Courses", @"Courses");
        self.tabBarItem.image = [UIImage imageNamed:@"academics.png"];
    }
    return self;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text=nil;
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.searchText=searchBar.text;
    if([self.searchText length] >= 3){
    if (![[self.searchText stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
        [searchBar resignFirstResponder];
        [self performSelector:@selector(execSearch) withObject:NULL afterDelay:0.0];
    }
    }
}


- (void)execSearch {
    if (tableViewArray == nil)
        tableViewArray = [NSMutableArray new];
    else
    {
        [tableViewArray removeAllObjects];
    }
    
    [self getSearchInfo];
           
    
    
    
    [self.tableView reloadData];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    //get the name of the current pressed button
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    email = @"";

    if ([buttonTitle isEqualToString:@"Email Professor"]){
        [self loadsearchrequest];
    }
   else if ([buttonTitle isEqualToString:@"Add to Calendar"]){
        [self add_cal];
    }
    else if ([buttonTitle isEqualToString:@"Cancel"]){
        NSLog(@"Cancel pressed --> Cancel ActionSheet");
    }
    else
    {
        term = buttonTitle;
        UIAlertView* semalert = [[UIAlertView alloc]initWithTitle:@"Selection Notice" message:[@"You have selected " stringByAppendingString:term] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [semalert show];
    }

}

-(void)add_cal {
    //course_days = MTWRF   course_time= 0800 - 0950 am
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    /* Step 2: Find the first local calendar that is modifiable */
    EKCalendar *targetCalendar = [eventStore defaultCalendarForNewEvents];
    
/*    for (EKCalendar *thisCalendar in eventStore.calendars){
        if (thisCalendar.type == EKCalendarTypeLocal &&
            [thisCalendar allowsContentModifications]){
            targetCalendar = thisCalendar;
        }
    }
  */

    /* The target calendar wasn't found? */
    if (targetCalendar == nil){
        NSLog(@"The target calendar is nil.");
        return;
    }
    
    /* Step 3: Create an event */
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    
    /* Step 4: Create an event that happens today and happens
     every month for a year from now */
    
    //NSDate *eventStartDate = [NSDate date];
    NSDateFormatter* dtFormatter = [[NSDateFormatter alloc] init];
    [dtFormatter setDateFormat:@"d LLLL yyyy hhmm a"];
    NSDateFormatter* dtFormatter2 = [[NSDateFormatter alloc] init];
    [dtFormatter2 setDateFormat:@"d LLLL yyyy"];
    [dtFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dtFormatter2 setTimeZone:[NSTimeZone localTimeZone]];

    /************ FIX THIS DATE FROM DATABASE FOR SEMESTER START **************/
    NSString *calstart=@"1 September 2013";
    NSString *adate=[NSString stringWithFormat:@"%@ %@ %@",calstart,[course_time substringWithRange:NSMakeRange(0, 4)],[course_time substringWithRange:NSMakeRange(12, 2)]];
    NSDate *eventStartDate = [dtFormatter dateFromString:adate];
    NSString *adate2=[NSString stringWithFormat:@"%@ %@ %@",calstart,[course_time substringWithRange:NSMakeRange(7, 4)],[course_time substringWithRange:NSMakeRange(12, 2)]];
    NSDate *eventEndDate = [dtFormatter dateFromString:adate2];
    NSLog(@"stdate: %@ endddate:%@ Begtime: %@ Endtime: %@",adate, adate2,[course_time substringWithRange:NSMakeRange(0, 4)],[course_time substringWithRange:NSMakeRange(7, 4)]);

    /* Step 5: The event's end date is one hour from the moment it is created */
    //NSTimeInterval NSOneHour = 1 * 60;
    //NSDate *eventEndDate = [eventStartDate dateByAddingTimeInterval:NSOneHour];
    ////end date

    /* Assign the required properties, especially
     the target calendar */
    event.calendar = targetCalendar;
    event.title = course_title;
    event.location=[NSString stringWithFormat:@"%@ %@",course_bldg,course_room];
    event.startDate = eventStartDate;
    event.endDate = eventEndDate;

    NSLog(@"days: %@ time:%@  start:%@ end:%@",course_days,course_time,[dtFormatter stringFromDate:eventStartDate],[dtFormatter stringFromDate:eventEndDate]);

    /* Step 6: Create an Event end date from this date */
    NSTimeInterval NSFifteenWeeks = 7*15 * 24 * 60 * 60;
    NSDate *oneYearFromNow = [eventStartDate dateByAddingTimeInterval:NSFifteenWeeks];
    EKRecurrenceEnd *recurringEnd = [EKRecurrenceEnd recurrenceEndWithEndDate:oneYearFromNow];

    /* Step 7: And the recurring rule. This event happens every */
 	NSMutableArray *days_week1 = [[NSMutableArray alloc] init];
    if ([course_days isEqualToString:@"TBA"]) {
            return;
        }
    else {
        for (int i=0; i < [course_days length]; i++) {
            NSString *ichar  = [NSString stringWithFormat:@"%c", [course_days characterAtIndex:i]];
            if (![ichar isEqualToString:@" "])
                [days_week1 addObject:[EKRecurrenceDayOfWeek dayOfWeek:i+2]];
        }
    }
    //[anArray addObject:[EKRecurrenceDayOfWeek dayOfWeek:3]];
    //NSArray *days_week=[NSArray arrayWithObjects:[EKRecurrenceDayOfWeek dayOfWeek:3],[EKRecurrenceDayOfWeek dayOfWeek:5], nil];

    EKRecurrenceRule *recurringRule =[[EKRecurrenceRule alloc] initRecurrenceWithFrequency:EKRecurrenceFrequencyWeekly interval:1 daysOfTheWeek:days_week1 daysOfTheMonth:nil monthsOfTheYear:nil weeksOfTheYear:nil daysOfTheYear:nil setPositions:nil end:recurringEnd];
    event.recurrenceRules = [[NSArray alloc] initWithObjects:recurringRule, nil]    ;
    
    NSError *saveError = nil;
    
    /* Step 9: Save the event */
    if ([eventStore saveEvent:event
                         span:EKSpanFutureEvents
                        error:&saveError]){
        NSLog(@"Successfully created the recurring event.");
    } else {
        NSLog(@"Failed to create the recurring event %@", saveError);
    }
    
}

//-(void)mailComposeController:(MFMailComposeViewController*)controller
//          didFinishWithResult:(MFMailComposeResult)result
//                        error:(NSError*)error;
//{
//    if (result == MFMailComposeResultSent) {
//    }
//
//    [self dismissModalViewControllerAnimated:YES];
//}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if (result == MFMailComposeResultSent) {
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    // Set the text of the cell to the row index.
    NSDictionary *rowdata = [tableViewArray objectAtIndex:row];
    NSString *actionSheetTitle=[rowdata objectForKey:@"TITLE"];
    instructorname=[rowdata objectForKey:@"INSTRUCTOR"];
    course_days=[rowdata objectForKey:@"Days"];
    course_time=[rowdata objectForKey:@"Time"];
    course_title=[rowdata objectForKey:@"TITLE"];
    course_bldg=[rowdata objectForKey:@"bldg"];
    course_room=[rowdata objectForKey:@"room"];
    
    //NSString *actionSheetTitle =[NSString stringWithFormat:@"%@",[tableViewArray objectAtIndex:indexPath.row]];
    //NSString *actionSheetTitle = @"Action Sheet Title";
    NSString *button1 = @"Email Professor";
    NSString *button2 = @"Add to Calendar";
    NSString *cancelTitle = @"Cancel";
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:actionSheetTitle
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:button1, button2, nil];
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return [tableViewArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath { 
    
    /*what we really need
     CRN, Course number, Section, Title,Instructor, Subject
     */
    NSUInteger row = [indexPath row];
    // Set the text of the cell to the row index.
    NSDictionary *rowdata = [tableViewArray objectAtIndex:row];
    //    int crn =[[rowdata objectForKey:@"CRN"] intValue];
    int number =[[rowdata objectForKey:@"NUMBER"] intValue];
    NSString *asection =[rowdata objectForKey:@"SECTION"];
    NSString *atitle=[rowdata objectForKey:@"TITLE"];
    NSString *ainstructor=[rowdata objectForKey:@"INSTRUCT1"];
    NSString *asubject=[rowdata objectForKey:@"SUBJECT"];
    
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"CourseCell"];
    if (!cell) 
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CourseCell" owner:self options:nil] lastObject];
    
    [(UILabel *)[cell viewWithTag:100] setText:atitle];
    [(UILabel *)[cell viewWithTag:101] setText:ainstructor];
    //[(UILabel *)[cell viewWithTag:102] setText:[NSString stringWithFormat:@"%d", crn]];
    [(UILabel *)[cell viewWithTag:103] setText:[NSString stringWithFormat:@"%d", number]];
    [(UILabel *)[cell viewWithTag:104] setText:asection];
    [(UILabel *)[cell viewWithTag:105] setText:asubject];
    
    // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;

}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    // Set the text of the cell to the row index.
    NSDictionary *rowdata = [tableViewArray objectAtIndex:row];
    int crn =[[rowdata objectForKey:@"CRN"] intValue];
    
    
    CourseGList* CourseView= [[NSClassFromString(@"CourseGList") alloc] initWithNibName:@"CourseGList" bundle:nil];
    [CourseView initCourseSummary:crn];
    [self.navigationController pushViewController:CourseView animated:YES];
    
}

-(void)requestError
{
    GlobalUtil *obj = [GlobalUtil GetFlashy];
    if(![obj RtnConTest])
    {
        [GlobalUtil showNoNetScreen];
    }
}

-(void)ParseFlashy:(NSData *)data
{
    
    NSMutableDictionary *rowentry;
    RegexParser *parse = [[RegexParser alloc] init];
    
    NSArray *testarr = [[NSArray alloc] initWithObjects:@"mailto:.+'", nil];
    
    NSArray *DirtyParams = [[NSArray alloc] initWithObjects:@"mailto:", nil];
    
    NSArray *keys = [[NSArray alloc] initWithObjects:@"email", nil];
    [parse AddPatterns:testarr];
    [parse AddDirtyParams:DirtyParams];
    
    NSString *HTML = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSArray *Sepstr = [HTML componentsSeparatedByString:@"<!-- Info for "];
    email = @"";
    for (int index = 1; index<[Sepstr count];index++)
    {
        NSString *StrAnlz = [Sepstr objectAtIndex:index];
        rowentry = [[NSMutableDictionary alloc] initWithObjects:[parse Output:StrAnlz] forKeys:keys];
        email = [rowentry objectForKey:@"email"];
        email = [email stringByReplacingOccurrencesOfString:@"'" withString:@""];
        
        if ([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
            controller.mailComposeDelegate = self;
            NSArray *toRecipients = [NSArray arrayWithObject:email];
            [controller setToRecipients:toRecipients];
            
            [controller setSubject:[NSString stringWithFormat:@""]];
            //            NSString *amsg=[NSString stringWithFormat:@"Here's a powerful idea.  Take a listen!\n\n%@",url];
            // [controller setMessageBody:amsg isHTML:NO];
            [self presentViewController:controller animated:YES completion:nil];
        }

    }
}

-(void)loadsearchrequest
{
    NSString *search = [instructorname stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    search = [search stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSURL *searchreq = [[NSURL alloc] initWithString:[NSString stringWithFormat:
                                                      @"http://prinweb.prin.edu/hagus/index.php3?eDir_search=%@&campus_search=elsah&gobutton=++++Search++++",search]];
    SMWebRequest * request = [SMWebRequest requestWithURL:searchreq];
    
    [request addTarget:self action:@selector(ParseFlashy:) forRequestEvents:SMWebRequestEventComplete];
    [request addTarget:self action:@selector(requestError) forRequestEvents:SMWebRequestEventError];
    [request start];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)ParseTerm:(NSData *)data
{
    Semesters = [[NSMutableArray alloc]init];
    CXMLDocument *searchdoc = [[CXMLDocument alloc] initWithData:data options:0 error:nil];
    NSArray *nodes = [searchdoc nodesForXPath:@"//Term" error:nil];
    
    for (CXMLElement* node in nodes) {
        NSString *newTerm = [[node childAtIndex:1] stringValue];
        NSArray *words = [newTerm componentsSeparatedByString:@" "];
        newTerm = [NSString stringWithFormat:@"%@_%@",[words objectAtIndex:0], [words objectAtIndex:1]];
        [Semesters addObject:newTerm];
    }
    
    
}

-(void)parseSearchInfo:(NSData *)data
{    
    CXMLDocument *searchdoc = [[CXMLDocument alloc] initWithData:data options:0 error:nil];
    NSArray *courses = [searchdoc nodesForXPath:@"//Course" error:nil];
    for(CXMLElement *course in courses)
    {
        NSMutableDictionary *courseEntry = [[NSMutableDictionary alloc] init];
        [courseEntry setValue:[[course childAtIndex:3] stringValue] forKey:@"CRN"];
        [courseEntry setValue:[[course childAtIndex:5] stringValue] forKey:@"SUBJECT"];
        [courseEntry setValue:[[course childAtIndex:7] stringValue] forKey:@"NUMBER"];
        [courseEntry setValue:[[course childAtIndex:9] stringValue] forKey:@"TITLE"];
        [courseEntry setValue:[[course childAtIndex:11] stringValue] forKey:@"INSTRUCT1"];
        
        if ([[[course childAtIndex:13] stringValue] length] > 2) {
            [courseEntry setValue:[[course childAtIndex:1] stringValue] forKey:@"INSTRUCT2"];
        }
        else{
            [courseEntry setValue:nil forKey:@"INSTRUCT2"];
        }
        [tableViewArray addObject:courseEntry];
    }
[self.tableView reloadData];

}

-(void)getSearchInfo
{
    NSString *requestString = [NSString stringWithFormat:@"http://prinapp.geektron.me/requests/coursesearch.php?search=%@&term=%@",searchText, [Semesters objectAtIndex:0]];
    
    [DataUtil GetDataToParse:requestString :@"parseSearchInfo:" :self];
}

-(void)getTerm
{   
    //calling method to get xml data from web.
    [DataUtil GetDataToParse:@"http://prinapp.geektron.me/requests/getTerms.php" :@"ParseTerm:" :self];
}

-(void)selectTerm
{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Select Semester"
                                  delegate:self
                                  cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    
    for(NSString* terms in Semesters)
    {
        [actionSheet addButtonWithTitle:terms];
    }
    
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    [actionSheet showFromTabBar:self.tabBarController.tabBar];

}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:0.212 blue:0.416 alpha:1.0];
    [sBar becomeFirstResponder];
    [self.tableView reloadData];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Select Semester"
                                                                    style:UIBarButtonItemStylePlain target:self action:@selector(selectTerm)];
    self.navigationItem.rightBarButtonItem = rightButton;

    EKEventStore *eventStore = [[EKEventStore alloc] init];
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        /* iOS Settings > Privacy > Calendars > MY APP > ENABLE | DISABLE */
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
         {
             if ( granted )
             {
                 NSLog(@"User has granted permission!");
             }
             else
             {
                 NSLog(@"User has not granted permission!");
             }
         }];
    }
    //	NSArray *array = [[NSArray alloc] initWithObjects:@"Apple",@"Microsoft",@"Samsung",@"Motorola", @"Principia" ,nil];
    //	self.tableViewArray = array;
    //	[array release];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self getTerm];
}


- (void)dealloc {
    //    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
