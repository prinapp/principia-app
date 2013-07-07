//
//  FourthViewController.h
//  Principia
//
//  Created by Dale Matheny on 10/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

#define kFileName @"PrinDB.sqlite"

@interface FourthViewController : UITableViewController < UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UISearchBarDelegate, UISearchDisplayDelegate> {
    
    sqlite3 *database;
    
    UITableView *myTableView;
    
    NSMutableArray *listDataDirectory;  // array for directory data
    
    NSMutableArray *dataSource; // stores all data
    
    NSString *searchText;
    
    IBOutlet UISearchBar *dirSearchBar;
    
    NSMutableArray *testData;       // temp names
    NSMutableArray *tableData;      // stores data displayed in table
    NSMutableArray *filteredData;   // data matching search string
    
    //UISearchBar *sBar; // search bar
    //UISearchBar *dirSearchBar;
    
    
}

- (NSString *) dataFilePath;

@property (strong, nonatomic) NSMutableArray *filteredData;
@property (strong, nonatomic) IBOutlet UISearchBar *dirSearchBar;

@property (nonatomic, retain) NSString *searchText;
@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) NSMutableArray *listDataDirectory;

@property (strong, nonatomic) NSMutableArray *testData;
@property (strong, nonatomic) NSMutableArray *tableData;

- (NSString *)dataFilePath;

@end
