//
//  Contacts.m
//  Principia
//
//  Created by Dale Matheny on 11/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Contacts.h"
#import "AppDelegate.h"

@interface Contacts ()

@end

@implementation Contacts
@synthesize tabData,aphone;

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSLog(@"Data File Path: %@",documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:kFileName];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Assistance", @"Assistance");
        //self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:0.212 blue:0.416 alpha:1.0]; 
    if (tabData == nil)
        tabData = [NSMutableArray new];
    else
        [tabData removeAllObjects];
    
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
		sqlite3_close(database);
		NSAssert(0, @"Failed to open database");
	}

    NSString *select = @"SELECT FirstName,LastName,Address,Phone from Directory where type=911;";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2( database, [select UTF8String],-1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //cust_id=sqlite3_column_int(statement,0);
            char *namec = (char *)sqlite3_column_text(statement, 0);
            if (namec==nil) namec="";
            NSString *name = [NSString stringWithUTF8String:namec];
            char *phc = (char *)sqlite3_column_text(statement, 2);
            if (phc==nil) phc="";
            NSString *ph = [NSString stringWithUTF8String:phc];

            NSDictionary *row1=[[NSDictionary alloc] initWithObjectsAndKeys: name, @"name",ph,@"phone",nil];
            [tabData addObject:row1];
            //[row1 release];
        }
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(database);
    NSLog (@"Database Loaded");
    
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    return [tabData count];
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
    NSString *aphone2=[rowdata objectForKey:@"phone"];
    NSString *aname=[rowdata objectForKey:@"name"];
    
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    if (!cell) 
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ContactCell" owner:self options:nil] lastObject];
    [(UILabel *)[cell viewWithTag:100] setText:aname];
    [(UILabel *)[cell viewWithTag:101] setText:aphone2];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
//------------------------------------------------------------------------------------
// didSelectRowAtIndexPath
//
// executes when user taps a cell
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        NSString *cleanedString = [[aphone componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
        NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", cleanedString]];
        [[UIApplication sharedApplication] openURL:telURL];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    NSDictionary *rowdata = [tabData objectAtIndex:row];
    
    aphone=[rowdata objectForKey:@"phone"];

    NSString *cleanedString = [[aphone componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", cleanedString]];
    [[UIApplication sharedApplication] openURL:telURL];

/*    NSString *message = [NSString stringWithFormat:@"Call %@?",aname];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Assistance" 
                                                    message: message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes, Please",nil];
    [alert show];
 */
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


@end
