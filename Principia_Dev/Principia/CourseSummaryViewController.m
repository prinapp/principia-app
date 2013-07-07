//
//  CourseSummaryViewController.m
//  Principia
//
//  Created by Austin Dauterman on 3/20/13.
//
//

#import "CourseSummaryViewController.h"
#import "RegexParser.h"
#import "SMWebRequest.h"

@interface CourseSummaryViewController ()

@end

@implementation CourseSummaryViewController
@synthesize tableViewArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) initCourseSummary:(int) iCrn{
    classcrn = iCrn;
}

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"%@",documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:kFilename];
}

- (BOOL)execSearch {
    BOOL found=false;
    
    if (tableViewArray == nil)
        tableViewArray = [NSMutableArray new];
    else
        [tableViewArray removeAllObjects];
    
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    //add days, time, bldg, room, sh
    NSString *select = [NSString stringWithFormat:@"SELECT title, crn, courses.num, sec, instructor, subject, description, days, days_2,  time, time_2, registered, fee, prereq, bldg, bldg_2, room, room_2, open_to, attribute_1, attribute_2, attribute_3, attribute_4 from courses, course_descriptions b where courses.subject = b.subj and courses.num = b.num and crn = %d", classcrn];
    //NSString *select = [NSString stringWithFormat:@"SELECT title, crn, number, section, intructor, subject from courses where title = '%@' or crn = %@ or number = %@ or section = %@ or intructor = '%@'", self.searchText, self.searchText, self.searchText, self,searchText, self.searchText, self.searchText];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2( database, [select UTF8String],-1, &statement, nil) == SQLITE_OK) {
        // sqlite3_bind_text(statement, 1, [self.searchText UTF8String],-1,NULL);
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            char *titlec = (char *)sqlite3_column_text(statement, 0);
            if (titlec==nil) titlec="";
            NSString *title = [NSString stringWithUTF8String:titlec];
            
            int crn=sqlite3_column_int(statement,1);
            int number=sqlite3_column_int(statement,2);
            
            char *sectionc = (char *)sqlite3_column_text(statement, 3);
            if (sectionc==nil) sectionc="";
            NSString *section = [NSString stringWithUTF8String:sectionc];
            
            char *instructorc = (char *)sqlite3_column_text(statement, 4);
            if (instructorc==nil) instructorc="";
            NSString *instructor = [NSString stringWithUTF8String:instructorc];
            instructorname = instructor;
            
            char *subjectc = (char *)sqlite3_column_text(statement, 5);
            if (subjectc==nil) subjectc="";
            NSString *subject = [NSString stringWithUTF8String:subjectc];
            
            char *descripc = (char *)sqlite3_column_text(statement, 6);
            if (descripc==nil) descripc="";
            NSString *descrip = [NSString stringWithUTF8String:descripc];
            
            char *daysc = (char *)sqlite3_column_text(statement, 7);
            if (daysc==nil) daysc="";
            NSString *days = [NSString stringWithUTF8String:daysc];
            
            char *days2c = (char *)sqlite3_column_text(statement, 8);
            if (days2c==nil) days2c="";
            NSString *days2 = [NSString stringWithUTF8String:days2c];

            
            char *timec = (char *)sqlite3_column_text(statement, 9);
            if (timec==nil) timec="";
            NSString *time = [NSString stringWithUTF8String:timec];
            
            char *time2c = (char *)sqlite3_column_text(statement, 10);
            if (time2c==nil) time2c="";
            NSString *time2 = [NSString stringWithUTF8String:time2c];
            
            int registered=sqlite3_column_int(statement,11);
            //int limit=sqlite3_column_int(statement,12);
            int limit = 20;
            int fee=sqlite3_column_int(statement,12);
            
            char *prereqc = (char *)sqlite3_column_text(statement, 13);
            if (prereqc==nil) prereqc="";
            NSString *prereq = [NSString stringWithUTF8String:prereqc];
            
            char *bldgc = (char *)sqlite3_column_text(statement, 14);
            if (bldgc==nil) bldgc="";
            NSString *bldg = [NSString stringWithUTF8String:bldgc];
            
            char *bldg2c = (char *)sqlite3_column_text(statement, 15);
            if (bldg2c==nil) bldg2c="";
            NSString *bldg2 = [NSString stringWithUTF8String:bldg2c];
            
            char *roomc = (char *)sqlite3_column_text(statement, 16);
            if (roomc==nil) roomc="";
            NSString *room = [NSString stringWithUTF8String:roomc];
            
            char *room2c = (char *)sqlite3_column_text(statement, 17);
            if (room2c==nil) room2c="";
            NSString *room2 = [NSString stringWithUTF8String:room2c];
            
            char *opentoc = (char *)sqlite3_column_text(statement, 18);
            if (opentoc==nil) opentoc="";
            NSString *opento = [NSString stringWithUTF8String:opentoc];
            
            char *att1c = (char *)sqlite3_column_text(statement, 19);
            if (att1c==nil) att1c="";
            NSString *att1 = [NSString stringWithUTF8String:att1c];
            
            char *att2c = (char *)sqlite3_column_text(statement, 20);
            if (att2c==nil) att2c="";
            NSString *att2 = [NSString stringWithUTF8String:att2c];
            
            char *att3c = (char *)sqlite3_column_text(statement, 21);
            if (att3c==nil) att3c="";
            NSString *att3 = [NSString stringWithUTF8String:att3c];
            
            char *att4c = (char *)sqlite3_column_text(statement, 22);
            if (att4c==nil) att4c="";
            NSString *att4 = [NSString stringWithUTF8String:att4c];
            
            
            NSDictionary *row1=[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:crn], @"CRN", [NSNumber numberWithInt:number], @"NUMBER", section, @"SECTION", instructor, @"INSTRUCTOR", title, @"TITLE", subject, @"SUBJECT", descrip, @"DESCRIP", days, @"DAYS", days2, @"DAYS2", time, @"TIME", time2, @"TIME2", [NSNumber numberWithInt:registered], @"REGISTERED", [NSNumber numberWithInt:limit], @"LIMIT", [NSNumber numberWithInt:fee], @"FEE", prereq, @"PREREQ", bldg, @"BLDG", bldg2, @"BLDG2", room, @"ROOM", room2, @"ROOM2", opento, @"OPENTO", att1, @"ATT1", att2, @"ATT2", att3, @"ATT3", att4, @"ATT4", nil];
            [tableViewArray addObject:row1];
            found=TRUE;
            //[row1 release];
        }
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(database);
    return found;
}

- (void) populateScreen {
    NSUInteger row = 0;
    // Set the text of the cell to the row index.
    NSDictionary *rowdata = [tableViewArray objectAtIndex:row];
    int crn =[[rowdata objectForKey:@"CRN"] intValue];
    int number =[[rowdata objectForKey:@"NUMBER"] intValue];
    NSString *asection =[rowdata objectForKey:@"SECTION"];
    NSString *atitle=[rowdata objectForKey:@"TITLE"];
    NSString *ainstructor=[rowdata objectForKey:@"INSTRUCTOR"];
    NSString *asubject=[rowdata objectForKey:@"SUBJECT"];
    NSString *adescrip=[rowdata objectForKey:@"DESCRIP"];
    NSString *adays=[rowdata objectForKey:@"DAYS"];
    NSString *adays2=[rowdata objectForKey:@"DAYS2"];
    NSString *atime=[rowdata objectForKey:@"TIME"];
    NSString *atime2=[rowdata objectForKey:@"TIME2"];
    int registered =[[rowdata objectForKey:@"REGISTERED"] intValue];
    //int limit =[[rowdata objectForKey:@"LIMIT"] intValue];
    int fee =[[rowdata objectForKey:@"FEE"] intValue];
    NSString *aprereq=[rowdata objectForKey:@"PREREQ"];
    NSString *abldg=[rowdata objectForKey:@"BLDG"];
    NSString *abldg2=[rowdata objectForKey:@"BLDG2"];
    NSString *aroom=[rowdata objectForKey:@"ROOM"];
    NSString *aroom2=[rowdata objectForKey:@"ROOM2"];
    NSString *aopento=[rowdata objectForKey:@"OPENTO"];
    NSString *aatt1=[rowdata objectForKey:@"ATT1"];
    NSString *aatt2=[rowdata objectForKey:@"ATT2"];
    NSString *aatt3=[rowdata objectForKey:@"ATT3"];
    NSString *aatt4=[rowdata objectForKey:@"ATT4"];
    BOOL hasFee = FALSE;
    if (fee != 0) hasFee = TRUE;
    BOOL hasPrereq =  TRUE;
    if ([aprereq isEqual:@""]) hasPrereq = FALSE;
    
    [(UILabel *)[self.view viewWithTag:100] setText:atitle];
    [(UILabel *)[self.view viewWithTag:101] setText:ainstructor];
    [(UILabel *)[self.view viewWithTag:102] setText:[NSString stringWithFormat:@"%d", crn]];
    [(UILabel *)[self.view viewWithTag:103] setText:[NSString stringWithFormat:@"%d", number]];
    [(UILabel *)[self.view viewWithTag:104] setText:asection];
    [(UILabel *)[self.view viewWithTag:105] setText:asubject];
    [(UITextView *) [self.view viewWithTag:106] setText:adescrip];
    [(UILabel *)[self.view viewWithTag:107] setText:adays];
    [(UILabel *)[self.view viewWithTag:108] setText:adays2];
    [(UILabel *)[self.view viewWithTag:110] setText:atime];
    [(UILabel *)[self.view viewWithTag:111] setText:atime2];
    [(UILabel *)[self.view viewWithTag:112] setText:[NSString stringWithFormat:@"%d", registered]];
    //[(UILabel *)[self.view viewWithTag:113] setText:[NSString stringWithFormat:@"%d", limit]];
    if (hasFee){
        [[self.view viewWithTag:1] setHidden:NO];
        [(UILabel *)[self.view viewWithTag:114] setText:[NSString stringWithFormat:@"%d", fee]];
    } else {
        [[self.view viewWithTag:1] setHidden:YES];
        [(UILabel *)[self.view viewWithTag:114] setText:@""];
        
    }
    if (hasPrereq){
        [[self.view viewWithTag:2] setHidden:NO];
        [(UILabel *)[self.view viewWithTag:115] setText:aprereq];
    } else {
        [[self.view viewWithTag:2] setHidden:YES];
        [(UILabel *)[self.view viewWithTag:115] setText:@""];
    }
    [(UILabel *)[self.view viewWithTag:116] setText:abldg];
    [(UILabel *)[self.view viewWithTag:117] setText:abldg2];
    [(UILabel *)[self.view viewWithTag:118] setText:aroom];
    [(UILabel *)[self.view viewWithTag:119] setText:aroom2];
    [(UILabel *)[self.view viewWithTag:50] setText:aopento];
    [(UILabel *)[self.view viewWithTag:51] setText:aatt1];
    [(UILabel *)[self.view viewWithTag:52] setText:aatt2];
    [(UILabel *)[self.view viewWithTag:53] setText:aatt3];
    [(UILabel *)[self.view viewWithTag:54] setText:aatt4];

}

-(void)requestError
{
    
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
        NSString *scdpic = [rowentry objectForKey:@"secpic"];
        if ([picstr isEqualToString:nothing]){
            picstr = scdpic;
        }
        picstr = [NSString stringWithFormat:@"http://prinweb.prin.edu%@",picstr];
        NSURL *url = [NSURL URLWithString:picstr];
        NSData *imagedata = [[NSData alloc] initWithContentsOfURL:url];
        UIImage *pic = [[UIImage alloc] initWithData:imagedata];
        
        
        ((UIImageView *)[self.view viewWithTag:109]).image = pic;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:0.212 blue:0.416 alpha:1.0];
    if ([self execSearch]) {
        [self populateScreen];
        [self loadsearchrequest];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
