//
//  Directory.h
//  Principia
//
//  Created by Shirley Paulson on 11/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "sqlite3.h"
#define kFileName @"PrinDB.sqlite"

@interface Directory : UITableViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
{
    sqlite3 *database;
    NSMutableArray *tabData;       // temp names
    NSString *selectedEmail;
    NSString *searchText;
    IBOutlet UISearchBar *dirSearchBar;
    NSMutableArray *ImageArray;
}

@property (strong, nonatomic) NSMutableArray *tabData;
@property (strong, nonatomic) IBOutlet UISearchBar *dirSearchBar;
@property (nonatomic, retain) NSString *selectedEmail;
@property (nonatomic, retain) NSString *searchText;
@property (nonatomic, retain) UIImage *notavail;
@property(nonatomic, retain) NSMutableArray *ImageArray;
- (NSString *)dataFilePath;

@end
