//
//  AppDelegate.h
//  Principia
//
//  Created by Dale Matheny on 10/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "utils.h"
#define kFilename @"PrinDB.sqlite"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
{
    UINavigationController *navController;      // Main Navigation controller
    sqlite3*database;                           // Main Database
    sqlite3*database2;                          // Backup Database just in case the main one is not there
    NSMutableArray *Flashylinks;                // List to store links for the flas
    utils *autil;                               // Utility for app
    NSMutableArray *tabData;                    // temp names
}

@property (nonatomic, retain) utils	*autil;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) UITabBarController *tabBarController;
-(NSString *) dataFilePath;                     //Method to open the database.
@end
