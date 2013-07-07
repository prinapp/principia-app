//
//  UsefulLinks.h
//  Principia
//
//  Created by Austin Dauterman on 4/8/13.
//
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#define kFileName @"PrinDB.sqlite"

@interface UsefulLinks : UITableViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
{
    sqlite3 *database;
    NSMutableArray *tabData;       // temp names
}

@property (strong, nonatomic) NSMutableArray *tabData;
- (NSString *)dataFilePath;

@end
