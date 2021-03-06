//
//  CourseGList.h
//  Principia
//
//  Created by Austin Dauterman on 4/27/13.
//
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#define kFilename @"PrinDB.sqlite"


@interface CourseGList : UITableViewController{
    sqlite3    *database;
    NSMutableArray *tableViewArray;
    int classcrn;
    NSArray *headers;
    NSArray *rowcount;
    NSString *instructorname, *instemail;
    UIImage *pic;
}

- (void) initCourseSummary:(int) iCrn;
@property (nonatomic, retain) NSMutableArray *tableViewArray;
@property (nonatomic, retain) UIImage *pic;
@property (nonatomic, retain) NSString *instructorname, *instemail;
@property (nonatomic, retain) NSArray *headers;
@property (nonatomic, retain) NSArray *rowcount;
@end