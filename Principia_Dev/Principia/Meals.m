//
//  Meals.m
//  Principia
//
//  Created by Dennis Adjei-Baah on 4/8/13.
//
//

#import "Meals.h"
#import "DataUtil.h"
#import "TouchXML.h"
#import "SMWebRequest.h"
#import "DatePick.h"

@interface Meals ()
@end

@implementation Meals
@synthesize listData,brk,lnch,din,dateselected,date,dAlert,dobPicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Meals", @"Meals");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

-(IBAction)selectbrk:(id)sender
{
    eventtype = 2;
    [brk setSelected:TRUE];
    [din setSelected:FALSE];
    [lnch  setSelected:FALSE];
    [self loadData];
    [self.tableView reloadData];
}

-(IBAction)selectlnch:(id)sender
{
    eventtype = 3;
    [lnch  setSelected:TRUE];
    [brk setSelected:FALSE];
    [din setSelected:FALSE];
    [self loadData];
    [self.tableView reloadData];
}

-(IBAction)selectdin:(id)sender
{
    eventtype = 4;
    [din setSelected:TRUE];
    [brk setSelected:FALSE];
    [lnch setSelected:FALSE];
    [self loadData];
    [self.tableView reloadData];
}

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSLog(@"Data File Path: %@",documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:kFileName];
    
}

-(void)ParseMealDescr:(NSData *)data
{
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    NSString *cleartable = @"delete from event_detail";
    sqlite3_stmt *clrtble;
    sqlite3_prepare_v2(database, [cleartable UTF8String], -1, &clrtble, NULL);
    int i = sqlite3_step(clrtble);
    if(i != SQLITE_DONE)
    {
        NSLog(@"%i",i);
        NSLog(@"%@",[DataUtil ConvertDBString:(char *)sqlite3_errmsg(database)]);
    }
    
    sqlite3_finalize(clrtble);
    CXMLDocument *doc = [[CXMLDocument alloc] initWithData:data options:0 error:nil];
    NSArray *nodes = [doc nodesForXPath:@"//Description" error:nil];
    NSMutableArray *recorditem = [[NSMutableArray alloc] init];
    for (CXMLElement *node in nodes) {
        for(int index = 0; index<[node childCount];index++)
        {
            NSString *test = [[node childAtIndex:index] stringValue];
            
            if ([test characterAtIndex:0] == '\n') {
                continue;
            }
            NSString *insvalue = [[node childAtIndex:index] stringValue];
            NSLog(@"%@",insvalue);
            [recorditem addObject:insvalue];
            
        }
        NSString *searchqry = [NSString stringWithFormat:@"select id from events where date='%@' and itemname='%@'",[recorditem objectAtIndex:0],[recorditem objectAtIndex:1]];
        int idval = 0;
        
        
        
        sqlite3_stmt *search;
        if (sqlite3_prepare_v2( database, [searchqry UTF8String],-1, &search, nil) == SQLITE_OK) {
            while (sqlite3_step(search) == SQLITE_ROW) {
                idval = [[DataUtil ConvertDBNumber:(int)sqlite3_column_int(search, 0)] intValue];
            }
            
        }
        NSString *insquery = [NSString stringWithFormat:@"insert into event_detail (event_id,info) values(%d,'%@')",idval,[recorditem objectAtIndex:2]];
        sqlite3_stmt *insstmt;
        sqlite3_prepare_v2(database, [insquery UTF8String], -1, &insstmt, NULL);
        int i = sqlite3_step(insstmt);
        if(i != SQLITE_DONE)
        {
            NSLog(@"%i",i);
            NSLog(@"%@",[DataUtil ConvertDBString:(char *)sqlite3_errmsg(database)]);
        }
        
        sqlite3_finalize(insstmt);
        
        [recorditem removeAllObjects];
    }
    sqlite3_close(database);
}

-(void)selectDate:(id)sender
{
    DatePick *datepick = [[DatePick alloc] init];
    datepick.mealsctl = self;
    UIViewController *dte = datepick;
    [self.navigationController pushViewController:dte animated:YES];
    
    
}

- (void)MealRequestComplete:(NSData *)data {
    [self performSelectorInBackground:@selector(ParseMealDescr:) withObject:data];
}

-(void)GetMealDescr
{
    NSURL *mealurl = [[NSURL alloc]initWithString:@"http://prinapp.geektron.me/requests/mealdescr.php"];
    SMWebRequest * mealrequest = [SMWebRequest requestWithURL:mealurl];
    [mealrequest addTarget:self action:@selector(ParseMealDescr:) forRequestEvents:SMWebRequestEventComplete];
    [mealrequest start];
}

- (BOOL)CheckCurrentMealDate
{
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
		sqlite3_close(database);
		NSAssert(0, @"Failed to open database");
	}
    
    NSString *searchdate = [NSString stringWithFormat:@"select date from events where date='%@'",dateselected];
    sqlite3_stmt *searchstatement;
    if (sqlite3_prepare_v2( database, [searchdate UTF8String],-1, &searchstatement, nil) == SQLITE_OK) {
        if (sqlite3_step(searchstatement) == SQLITE_ROW) {
            dateselected = [DataUtil ConvertDBString:(char *)sqlite3_column_text(searchstatement, 0)];
            
            
        }
        
        else{
            NSString *latestdatesearch = @"select date from events order by date desc limit 1";
            sqlite3_stmt *ltstdate;
            if (sqlite3_prepare_v2( database, [latestdatesearch UTF8String],-1, &ltstdate, nil) == SQLITE_OK) {
                while (sqlite3_step(ltstdate) == SQLITE_ROW) {
                    dateselected = [DataUtil ConvertDBString:(char *)sqlite3_column_text(ltstdate, 0)];
                }
                sqlite3_finalize(ltstdate);
            }
            
        }
        sqlite3_finalize(searchstatement);
    }
    date.text = [DataUtil ConvertDate:dateselected];
    
    sqlite3_close(database);
    return true;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self GetMealDescr];
    dateselected = [DataUtil GetCurrDateStr];

    //check current time
    NSDateFormatter* dtFormatter = [[NSDateFormatter alloc] init];
    [dtFormatter setDateFormat:@"HHmm"];
    [dtFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *now = [NSDate date];
    int currtime=[[dtFormatter stringFromDate:now] integerValue];
    
    [brk setSelected:FALSE];
    [lnch setSelected:FALSE];
    [din setSelected:FALSE];
    if (currtime<=930) {
        eventtype = 2;
        [brk setSelected:TRUE];
    }
    else if (currtime<=1330) {
        eventtype = 3;
        [lnch setSelected:TRUE];
    }
    else {
        eventtype = 4;
        [din setSelected:TRUE];
    }

    [self loadData];
    [self.tableView reloadData];
}

-(void)loadData
{
    [self CheckCurrentMealDate];
    
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
		sqlite3_close(database);
		NSAssert(0, @"Failed to open database");
	}
    
    NSString *finalqry = [NSString stringWithFormat:@"select event_detail.info, events.itemname from events inner join event_detail  on event_detail.event_id = events.id where date  ='%@' and events.eventtype = %d",dateselected,eventtype];
    sqlite3_stmt *list;
    if (sqlite3_prepare_v2( database, [finalqry UTF8String],-1, &list, nil) == SQLITE_OK) {
        [listData removeAllObjects];
        while (sqlite3_step(list) == SQLITE_ROW) {
            [listData addObject:[DataUtil ConvertDBString:(char *)sqlite3_column_text(list, 0)]];
            NSLog(@"%@",[DataUtil ConvertDBString:(char *)sqlite3_column_text(list, 0)]);
        }
    }
    sqlite3_finalize(list);
    sqlite3_close(database);

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImage *pause2 =[UIImage imageNamed:@"breakfast_select.png"];
    [brk setImage:pause2 forState:UIControlStateSelected];
    pause2 =[UIImage imageNamed:@"lunch_select.png"];
    [lnch setImage:pause2 forState:UIControlStateSelected];
    pause2 =[UIImage imageNamed:@"dinner_select.png"];
    [din setImage:pause2 forState:UIControlStateSelected];
    pause2 =[UIImage imageNamed:@"breakfast.png"];
    [brk setImage:pause2 forState:UIControlStateNormal];
    pause2 =[UIImage imageNamed:@"lunch.png"];
    [lnch setImage:pause2 forState:UIControlStateNormal];
    pause2 =[UIImage imageNamed:@"dinner.png"];
    [din setImage:pause2 forState:UIControlStateNormal];

    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:0.267 blue:0.486 alpha:1.0];
    if(listData == nil)
    {
        listData = [NSMutableArray new];
    }
    else [listData removeAllObjects];

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Pick Date"
                                                                    style:UIBarButtonItemStyleDone target:self action:@selector(selectDate:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    [self.tableView reloadData];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSLog(@"%@",[listData objectAtIndex:indexPath.row]);
    cell.textLabel.text = [listData objectAtIndex:indexPath.row];
    
    return cell;
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
