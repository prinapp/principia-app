//
//  CourseDetail.h
//  Principia
//
//  Created by Dale Matheny on 11/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "sqlite3.h"
#define kFilename @"PrinDB.sqlite"


@interface CourseSearch : UITableViewController <UITableViewDelegate, UISearchBarDelegate, UITableViewDataSource, UIActionSheetDelegate, MFMailComposeViewControllerDelegate, UIPickerViewDelegate> {
    
    NSMutableArray *tableViewArray;
    NSString *searchText;
    NSString *instructorname;
    NSString *email;
    NSString *course_days;
    NSString *course_time;
    NSString *course_title;
    NSString *course_bldg;
    NSString *course_room;
    NSString *term_1;
    NSString *term_2;
    NSMutableArray *Semesters;
    NSString *term;

    IBOutlet UISearchBar *sBar;//search bar
    sqlite3    *database;
}


@property (nonatomic, retain) IBOutlet UISearchBar *sBar;
@property (nonatomic, retain) NSString *searchText;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *instructorname;
@property (nonatomic, retain) NSMutableArray *tableViewArray;
@property (nonatomic, retain) NSString *course_days;
@property (nonatomic, retain) NSString *course_time;
@property (nonatomic, retain) NSString *course_title;
@property (nonatomic, retain) NSString *course_bldg;
@property (nonatomic, retain) NSString *course_room;
@property (nonatomic, retain) NSString *term;
@property (nonatomic, retain) NSMutableArray *Semesters;


@end
