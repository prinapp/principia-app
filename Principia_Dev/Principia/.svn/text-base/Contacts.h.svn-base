//
//  Contacts.h
//  Principia
//
//  Created by Dale Matheny on 11/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#define kFileName @"PrinDB.sqlite"

@interface Contacts : UITableViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UIAlertViewDelegate>
{
    sqlite3 *database;
    NSString *aphone;
    NSMutableArray *tabData;       // temp names
}

@property (strong, nonatomic) NSMutableArray *tabData;
@property (strong, nonatomic) NSString *aphone;
- (NSString *)dataFilePath;

@end
