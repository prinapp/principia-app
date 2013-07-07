//
//  Courses.m
//  Principia
//
//  Created by Dale Matheny on 11/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Course1.h"

@implementation Course1

@synthesize tableViewArray;
@synthesize sBar, searchText;

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
    if (![[self.searchText stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
        [searchBar resignFirstResponder];
        [self performSelector:@selector(execSearch) withObject:NULL afterDelay:0.0];
    }
}

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"%@",documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:kFilename];
}

- (void)execSearch {
    if (tableViewArray == nil)
        tableViewArray = [NSMutableArray new];
    else
        [tableViewArray removeAllObjects];

    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    
    NSString *select = @"SELECT instructor, title, crn, subject, number, semester_hours, fee, attribute, open_to from courses where title like '%design%';";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2( database, [select UTF8String],-1, &statement, nil) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [self.searchText UTF8String],-1,NULL);		
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *instc = (char *)sqlite3_column_text(statement, 0);
            if (instc==nil) instc="";
            NSString *inst = [NSString stringWithUTF8String:instc];
//            int cust_id=sqlite3_column_int(statement,0);
            char *namec = (char *)sqlite3_column_text(statement, 1);
            if (namec==nil) namec="";
            NSString *name = [NSString stringWithUTF8String:namec];
            NSDictionary *row1=[[NSDictionary alloc] initWithObjectsAndKeys:inst, @"inst", name, @"title",nil];
            [tableViewArray addObject:row1];
            //[row1 release];
        }
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(database);
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *message = [NSString stringWithFormat:@"You have selected %@",[tableViewArray objectAtIndex:indexPath.row]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"This is a box!" 
                                                    message: message delegate:self cancelButtonTitle:@"Make this go away" otherButtonTitles:nil];
    [alert show];
    //[alert release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return [tableViewArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath { 
    
    NSUInteger row = [indexPath row];
    // Set the text of the cell to the row index.
    NSDictionary *rowdata = [tableViewArray objectAtIndex:row];
    NSString *aid=[rowdata objectForKey:@"inst"];
    NSString *aname=[rowdata objectForKey:@"title"];
    
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"CourseCell"];
    if (!cell) 
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CourseCell" owner:self options:nil] lastObject];
    [(UILabel *)[cell viewWithTag:100] setText:aid];
    [(UILabel *)[cell viewWithTag:101] setText:aname];
    return cell;

}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:0.212 blue:0.416 alpha:1.0]; 
    [sBar becomeFirstResponder];
    [self.tableView reloadData];

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
