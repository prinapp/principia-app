//
//  Course1.h
//  Principia
//
//  Created by Dale Matheny on 11/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "sqlite3.h"
#define kFilename @"PrinDB.sqlite"

@interface EventDetail : UITableViewController <UITableViewDelegate, UISearchBarDelegate,UITableViewDataSource> {
    
    NSMutableArray *tableViewArray;
    NSString *searchText;
    IBOutlet UISearchBar *sBar;//search bar
    sqlite3    *database;
    int event_ID, event_type;
}

-(NSString *) dataFilePath;
@property (nonatomic, retain) IBOutlet UISearchBar *sBar;
@property (nonatomic, retain) NSString *searchText;
@property (nonatomic, retain) NSMutableArray *tableViewArray;

-(void) init :(int) eventID :(int) eventType;

@end
