//
//  FirstViewController.m
//  Principia
//  Directory/people
//
//  Created by Dale Matheny on 10/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//  Credit to // http://www.switchonthecode.com/tutorials/how-to-create-and-populate-a-uitableview
//      for some of the necessary tableview code

#import "FourthViewController.h"

@interface FourthViewController ()

@end

@implementation FourthViewController

@synthesize myTableView, listDataDirectory;
@synthesize filteredData;
@synthesize dirSearchBar;
@synthesize searchText;

@synthesize testData, tableData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"People", @"People");
        self.tabBarItem.image = [UIImage imageNamed:@"People"];
    }
    return self;
}

//------------------------------------------------------------------------------------

- (void) execSearch {
    
    /*
     for (UITableViewCell *cell in myTableView)
     {
     
     if([cell.textLabel.text rangeOfString:searchText].location != NSNotFound)
     [filteredData addObject:cell.textLabel.text];
     
     }
     */
    if (testData == nil)
        testData = [NSMutableArray new];
    else
        [testData removeAllObjects];
    
    for (NSInteger i = 0; i < [testData count]; i++) {
        if ([[testData objectAtIndex:i] rangeOfString:searchText].location != NSNotFound) {
            [filteredData addObject:[testData objectAtIndex:i]];
        }
    }
    
    
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
		sqlite3_close(database);
		NSAssert(0, @"Failed to open database");
	}
    
    NSString *select = @"SELECT FirstName,LastName,Address from Directory where FirstName Like '%Dale%';";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2( database, [select UTF8String],-1, &statement, nil) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [self.searchText UTF8String], -1, NULL);		
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //cust_id=sqlite3_column_int(statement,0);
            char *namec = (char *)sqlite3_column_text(statement, 0);
            if (namec==nil) namec="";
            NSString *name = [NSString stringWithUTF8String:namec];
            NSDictionary *row1=[[NSDictionary alloc] initWithObjectsAndKeys: name, @"name",nil];
            [testData addObject:row1];
            //[row1 release];
        }
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(database);
    NSLog (@"Database Loaded");
    
    [self.myTableView reloadData];
    
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text=nil;
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    self.searchText = dirSearchBar.text;
    if (![[self.searchText stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
        [searchBar resignFirstResponder];
        //[self.appDelegate showActivityViewer];
        [self performSelector:@selector(execSearch) withObject:NULL afterDelay:0.0];
    }
}


//------------------------------------------------------------------------------------

-(void)loadData {
 	//save password to database
	if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
		sqlite3_close(database);
		NSAssert(0, @"Failed to open database");
	}
    
    /*    NSString *select = @"SELECT cust_id,name from cust where cust_id>?;";
     sqlite3_stmt *statement;
     if (sqlite3_prepare_v2( database, [select UTF8String],-1, &statement, nil) == SQLITE_OK) {
     sqlite3_bind_int(statement, 1, min_id);		
     while (sqlite3_step(statement) == SQLITE_ROW) {
     cust_id=sqlite3_column_int(statement,0);
     char *namec = (char *)sqlite3_column_text(statement, 1);
     if (namec==nil) namec="";
     NSString *name = [NSString stringWithUTF8String:namec];
     NSDictionary *row1=[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:cust_id], @"id", name, @"name",nil];
     [testData addObject:row1];
     //[row1 release];
     }
     sqlite3_finalize(statement);
     }
     */
    sqlite3_close(database);
    NSLog (@"Database Loaded");
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:0.212 blue:0.416 alpha:1.0]; 
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    /*
     if (listDataDirectory == nil)
     listDataDirectory = [NSMutableArray new];
     else
     [listDataDirectory removeAllObjects];
     */
    
    if (testData == nil)
        testData = [NSMutableArray new];
    else
        [testData removeAllObjects];
    
    
    //tableData = [[NSMutableArray alloc] init];
    
    /*
     testData = [NSMutableArray arrayWithObjects:
     [NSString stringWithFormat:@"Brian"],
     [NSString stringWithFormat:@"Adam"],
     [NSString stringWithFormat:@"John"],
     [NSString stringWithFormat:@"Dennis"], nil];
     
     */
    
    //for(char c = 'A';c<='Z';c++)
    //    [testData addObject:[NSString stringWithFormat:@"%cTestString",c]];
    
    
    filteredData = [[NSMutableArray alloc] init];
    filteredData = [NSMutableArray arrayWithCapacity:[testData count]];
    //[filteredData addObjectsFromArray:testData];
    
    
    [self loadData];
    
    [self.myTableView reloadData];
    
    
}

//------------------------------------------------------------------------------------

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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
    
    
    return [testData count];
    
    
    //return [self.tableData count];
    
    
    //return [self.listDataDirectory count];
}

//------------------------------------------------------------------------------------
// cellForRowAtIndexPath
//
// provides and creates cells for the tableview

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Identifier for retrieving reusable cells.
    static NSString *cellIdentifier = @"MyCellIdentifier";
    
    NSUInteger row = [indexPath row];
    
    // Attempt to request the reusable cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // No cell available - create one.
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                      reuseIdentifier:cellIdentifier];
    }
    
    // Set the text of the cell to the row index.
    
    NSDictionary *rowdata = [testData objectAtIndex:row];
    
    
    cell.textLabel.text = [rowdata objectForKey:@"name"];
    
    /*
     if (tableView == self.searchDisplayController.searchResultsTableView) {
     cell.textLabel.text = [filteredData objectAtIndex:indexPath.row];
     } else {
     cell.textLabel.text = [testData objectAtIndex:indexPath.row];
     }
     
     //cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
     */
    
    /*
     NSUInteger row = [indexPath row];
     NSDictionary *rowdata = [listDataDirectory objectAtIndex:row];
     cell.textLabel.text = [rowdata valueForKey:@"name"];
     cell.detailTextLabel.text = [NSString stringWithFormat:@"id: %d", [[rowdata valueForKey:@"id"] intValue]];
     
     NSLog(@"Table text:%@ rows #:%d", [rowdata valueForKey:@"name"], indexPath.row);
     
     */
    
    
    return cell;
}

//------------------------------------------------------------------------------------
// didSelectRowAtIndexPath
//
// executes when user taps a cell

- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Show an alert with the index selected.
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:@"Item Selected"                         
                          message:[NSString stringWithFormat:@"Item %d", indexPath.row]                     
                          delegate:self       
                          cancelButtonTitle:@"OK"           
                          otherButtonTitles:nil];
    [alert show];
    //[alert release];
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
