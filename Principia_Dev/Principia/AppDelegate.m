//
//  AppDelegate.m
//  Principia
//
//  Created by Dale Matheny on 10/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.   
//

#import "AppDelegate.h"

#import "FirstViewController.h"
#import "Events.h"
#import "Contacts.h"
#import "FourthViewController.h"
#import "FifthViewController.h"
#import "SixthViewController.h"
#import "SoPrinViewSelector.h"
#import "PageController.h"
#import "Directory.h"
#import "CourseSearch.h"
#import "Meals.h"
#import "UsefulLinks.h"
#import "viewer.h"
#import "Reachability.h"
#import "SMWebRequest.h"
#import "DataUtil.h"
#import "SMWebRequest.h"
#import "TouchXML.h"
#import "GlobalUtil.h"
#import "utils.h"
#import <GoogleMaps/GoogleMaps.h>
#import "ErrorHandler.h"

@implementation UITabBarController(AutorotationFromSelectedView)
- (BOOL)shouldAutorotate {
    if (self.selectedViewController) {
        return [self.selectedViewController shouldAutorotate];
    } else {
        return YES;
    }
}

- (NSUInteger)supportedInterfaceOrientations {
    if (self.selectedViewController) {
        return [self.selectedViewController supportedInterfaceOrientations];
    } else {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
}
@end

@implementation UINavigationController(AutorotationFromVisibleView)
- (BOOL)shouldAutorotate {
    if (self.visibleViewController) {
        return [self.visibleViewController shouldAutorotate];
    } else {
        return YES;
    }
}

- (NSUInteger)supportedInterfaceOrientations {
    if (self.visibleViewController) {
        return [self.visibleViewController supportedInterfaceOrientations];
    } else {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
}
@end

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize navController;
@synthesize autil;


#pragma mark Database Handling
-(NSString *) dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFilename];
    
}
/*********************************************************************************/
/*
Method: downloadXML
        Sets up a URL and a request to be passed into the SMWebRequest object for asynchronous
        HTTP requests. There are two methods that are called if with two different event.
        If the request was successful (the xml could be downloaded) the request object must call
        RequestComplete.
        If the request had an error than we must handle it with our requestError method.
*/
- (void)downloadXML {
    [DataUtil GetDataToParse:@"http://prinapp.geektron.me/requests/getmeal.php" :@"parseXML:" :self]; //access the link.
}

/*
 Method: ParseXML
         This method first reads in the nodes, check for any whitespace occurence, this is the first
         loop within the main loop. Then it creates the insert statement and copies all the values to the
         statement and then the database.
 */
-(void)parseXML:(NSData *)data
{
        //opens the sqlite database.
        if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
            sqlite3_close(database);
            NSAssert(0, @"Failed to open database");
    }
    
    //turns the document to a TouchXML object.
    CXMLDocument *doc = [[CXMLDocument alloc] initWithData:data options:0 error:nil];
    NSArray *nodes = [doc nodesForXPath:@"//Meal" error:nil];               //break xml document into Meal objects
    sqlite3_stmt *insstmt;                                                  //insert statement object in sqlite.
    const char *utfquery;                                                   //formatting for statement evaluations in sqlite
    
    //We break the nodes up into Meals and extract information from each object regarding meals and write them to a database.
    for(CXMLElement *node in nodes)
    {
        NSMutableArray *recorditem = [[NSMutableArray alloc] init];
        
        for(int index = 0; index<[node childCount];index++)
        {
            //Skip over empty tags in the xml object.
            NSString *test = [[node childAtIndex:index] stringValue];
            if ([test characterAtIndex:0] == '\n') {
                continue;
            }
            NSString *insvalue = [[node childAtIndex:index] stringValue];
            [recorditem addObject:insvalue];
        }
        NSString *insertSQL = @"insert into events (date,starttime,endtime,itemname,eventtype,location) values (?,?,?,?,?, \"Concourse\")";
        
        utfquery = [insertSQL UTF8String];                              //Strings that are to be used in a sqlite statement must be converted to a UTF8 string.
        sqlite3_prepare_v2(database, utfquery, -1, &insstmt, NULL);     //Prepare the sqlite3 object by adding the utf8 string into object.
        
        //if the tag is breakfast, bind the breakfast times and the word breakfast to the insert statement.
        if ([[recorditem objectAtIndex:1] rangeOfString:@"BRK"].location != NSNotFound){
            
            sqlite3_bind_text(insstmt, 1, [(NSString *)[recorditem objectAtIndex:0] UTF8String], -1, SQLITE_STATIC);
            sqlite3_bind_text(insstmt, 2, [@"07:30" UTF8String], -1, SQLITE_STATIC);
            sqlite3_bind_text(insstmt, 3, [@"09:30" UTF8String], -1, SQLITE_STATIC);
            sqlite3_bind_text(insstmt, 4, [@"Breakfast" UTF8String], -1, SQLITE_STATIC);
            sqlite3_bind_int(insstmt, 5, 2);
        }
        //if the tag is dinner, bind the dinner times and the word dinner to the insert statement.
        else if([[recorditem objectAtIndex:1] rangeOfString:@"DIN"].location != NSNotFound)
        {
            sqlite3_bind_text(insstmt, 1, [(NSString *)[recorditem objectAtIndex:0] UTF8String], -1, SQLITE_STATIC);
            sqlite3_bind_text(insstmt, 2, [@"17:30" UTF8String], -1, SQLITE_STATIC);
            sqlite3_bind_text(insstmt, 3, [@"19:30" UTF8String], -1, SQLITE_STATIC);
            sqlite3_bind_text(insstmt, 4, [@"Dinner" UTF8String], -1, SQLITE_STATIC);
            sqlite3_bind_int(insstmt, 5, 4);
        }
        //if the tag is lunch, bind the lunch times and the word lunch to the insert statement.
        else if([[recorditem objectAtIndex:1] rangeOfString:@"LUN"].location != NSNotFound)
        {
            sqlite3_bind_text(insstmt, 1, [(NSString *)[recorditem objectAtIndex:0] UTF8String], -1, SQLITE_STATIC);
            sqlite3_bind_text(insstmt, 2, [@"11:30" UTF8String], -1, SQLITE_STATIC);
            sqlite3_bind_text(insstmt, 3, [@"13:30" UTF8String], -1, SQLITE_STATIC);
            sqlite3_bind_text(insstmt, 4, [@"Lunch" UTF8String], -1, SQLITE_STATIC);
            sqlite3_bind_int(insstmt, 5, 3);
        }
        int i = sqlite3_step(insstmt);  //execute the sqlite3 statement.
        //if the statement succeeds, do not enter this if statement if it doesn't enter and display the error.
        if(i != SQLITE_DONE)
        {
            NSLog(@"%i",i);
            NSLog(@"%@",[DataUtil ConvertDBString:(char *)sqlite3_errmsg(database)]);
        } 
        
    }
    sqlite3_finalize(insstmt);          //finish using the sqlite3 statement.
    sqlite3_close(database);            //clsoe the database/
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;         //Turn of the network indicator to show that we are done processing all network jobs.
    
}
/*****************************************************************************************/
- (void)requestError:(NSError *)theError {
    [ErrorHandler printError:theError];
}
/***********************************************************************************************************/
/*
 Method: parseContacts
         Gets a list of all the contacts from the prin411 feed and adds them to the database.
*/
-(void)parseContacts:(NSData *)data
{
    //open the database and check to see if it exists.
    if (sqlite3_open([[self dataFilePath] UTF8String], &database2) != SQLITE_OK) {
        sqlite3_close(database2);
        NSAssert(0, @"Failed to open database2");
    }
    
    //Delete all current records from the database 
    sqlite3_stmt *insstmt;
    NSString *purge=@"DELETE FROM directory;";
    sqlite3_prepare_v2(database2, [purge UTF8String], -1, &insstmt, NULL);
    int i = sqlite3_step(insstmt);
    if(i != SQLITE_DONE)
    {
        NSLog(@"%i",i);
        NSLog(@"%@",[DataUtil ConvertDBString:(char *)sqlite3_errmsg(database2)]);
    }
    sqlite3_finalize(insstmt);
    sqlite3_close(database2);

    //Prepare parsing of xml.
    CXMLDocument *doc = [[CXMLDocument alloc] initWithData:data options:0 error:nil];
    NSString *astr = [[NSString alloc] initWithData:data encoding:NSWindowsCP1252StringEncoding];
    NSLog(@"Data:%@",astr);
    
    if (sqlite3_open([[self dataFilePath] UTF8String], &database2) != SQLITE_OK) {
        sqlite3_close(database2);
        NSAssert(0, @"Failed to open database2");
    }
    
    NSArray *nodes = [doc nodesForXPath:@"//Item" error:nil];
    NSString *aname=@"";
    NSString *atype=@"";
    NSString *acontact=@"";
    
    for (CXMLElement *node in nodes) {
        aname=[[node childAtIndex:1] stringValue];
        atype=[[node childAtIndex:5] stringValue];
        acontact=[[node childAtIndex:3] stringValue];
        
        NSString *aqry=[NSString stringWithFormat:@"insert into directory (FirstName, Address, Type) values ('%@','%@',%d)",aname,acontact,[atype integerValue]];
        if (sqlite3_prepare_v2(database2, [aqry UTF8String], -1, &insstmt, nil)==SQLITE_OK)
        {
        }
        int i = sqlite3_step(insstmt);
        if(i != SQLITE_DONE)
        {
            NSLog(@"%i",i);
            NSLog(@"%@",[DataUtil ConvertDBString:(char *)sqlite3_errmsg(database2)]);
        }
        sqlite3_finalize(insstmt);
        
    }
    sqlite3_close(database2);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;         //Turn of the network indicator to show that we are done processing all network jobs.
}

-(void)GetContacts
{
    [DataUtil GetDataToParse:@"http://prinapp.geektron.me/requests/getcontacts411.php" :@"parseContacts:" :self];
}
/***********************************************************************************************************/
#pragma mark start of display code

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    autil = [[utils alloc] init];
    [autil checkDB];
    GlobalUtil *obj = [GlobalUtil GetFlashy];
    [obj InitializeConnection];
    UIViewController *viewController1, *viewController2,*viewController3, *viewController4,*viewController5, *viewController7, *soprininitial, *prinwireinitial, *meals,*usefullnk,*flashy;
    UIStoryboard *soprin = [UIStoryboard storyboardWithName:@"SoPrin" bundle:nil];
    UIStoryboard *prinwire = [UIStoryboard storyboardWithName:@"Prinwire" bundle:nil];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewController3 = [[FirstViewController alloc] initWithNibName:@"FirstViewController_iPhone" bundle:nil];
        viewController2 = [[Events alloc] initWithNibName:@"Events" bundle:nil];
        viewController5 = [[Contacts alloc] initWithNibName:@"Contacts" bundle:nil];
        viewController4 = [[Directory alloc] initWithNibName:@"Directory" bundle:nil];
        viewController1 = [[FifthViewController alloc] initWithNibName:@"FifthViewController_iPhone" bundle:nil];
        viewController7 = [[CourseSearch alloc] initWithNibName:@"CourseDetail" bundle:nil];
        soprininitial = [soprin instantiateInitialViewController];
        prinwireinitial = [prinwire instantiateInitialViewController];
        usefullnk = [[UsefulLinks alloc] initWithNibName:@"UsefulLinks" bundle:nil];
        meals = [[Meals alloc] initWithNibName:@"Meals" bundle:nil];
        flashy = [[PageController alloc]init];
        
    }
    
    else {  // for iPad
        viewController3 = [[FirstViewController alloc] initWithNibName:@"FirstViewController_iPad" bundle:nil];
        viewController2 = [[Events alloc] initWithNibName:@"SecondViewController_iPad" bundle:nil];
        viewController5 = [[Contacts alloc] initWithNibName:@"Contacts" bundle:nil];
        viewController4 = [[Directory alloc] initWithNibName:@"Directory" bundle:nil];
        viewController1 = [[FifthViewController alloc] initWithNibName:@"FifthViewController_iPad" bundle:nil];
        viewController7 = [[CourseSearch alloc] initWithNibName:@"CourseDetail" bundle:nil];
    }
    self.tabBarController = [[UITabBarController alloc] init];
    CGRect frame = CGRectMake(0, 0, 480, 49);
    UIView *v = [[UIView alloc] initWithFrame:frame];
    ;
    UIColor *c = [[UIColor alloc] initWithRed:0.0 green:0.212 blue:0.416 alpha:1.0];
    v.backgroundColor = c;
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:0.0 green:0.212 blue:0.416 alpha:1.0];
    
    
    NSMutableArray *localViewControllersArray = [[NSMutableArray alloc] initWithCapacity:10];
    
    UINavigationController *theNavigationController;
	theNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController1];
	[localViewControllersArray addObject:theNavigationController];
    
	theNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController2];
	[localViewControllersArray addObject:theNavigationController];
    
    theNavigationController = [[UINavigationController alloc] initWithRootViewController:flashy];
    [localViewControllersArray addObject:theNavigationController];
    flashy.tabBarItem.image = [UIImage imageNamed:@"64-zap"];

	theNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController4];
	[localViewControllersArray addObject:theNavigationController];
    
    theNavigationController = [[UINavigationController alloc] initWithRootViewController:meals];
    [localViewControllersArray addObject:theNavigationController];
    meals.tabBarItem.image = [UIImage imageNamed:@"food"];

	theNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController7];
	[localViewControllersArray addObject:theNavigationController];
    
    theNavigationController = [[UINavigationController alloc] initWithRootViewController:soprininitial];
    [localViewControllersArray addObject:theNavigationController];
    soprininitial.tabBarItem.image = [UIImage imageNamed:@"message"];
    
    theNavigationController = [[UINavigationController alloc] initWithRootViewController:prinwireinitial];
    [localViewControllersArray addObject:theNavigationController];
    prinwireinitial.tabBarItem.image = [UIImage imageNamed:@"166-newspaper"];

	theNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController3];
	[localViewControllersArray addObject:theNavigationController];
    
	theNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController5];
	[localViewControllersArray addObject:theNavigationController];
    viewController5.tabBarItem.image = [UIImage imageNamed:@"75-phone"];
    
    theNavigationController = [[UINavigationController alloc] initWithRootViewController:usefullnk];
	[localViewControllersArray addObject:theNavigationController];
    usefullnk.tabBarItem.image = [UIImage imageNamed:@"link"];

    self.tabBarController.viewControllers=localViewControllersArray;
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self downloadXML];
    [self GetContacts];
    self.window.rootViewController = self.tabBarController;
    [GMSServices provideAPIKey:@"AIzaSyDQLSN1pZ0u6z6AfsFLZwtGEnV1FRtX6BQ"];
    
    [self.window makeKeyAndVisible];
  
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
