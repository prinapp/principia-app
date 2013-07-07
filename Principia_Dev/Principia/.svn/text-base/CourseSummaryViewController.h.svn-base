//
//  CourseSummaryViewController.h
//  Principia
//
//  Created by Austin Dauterman on 3/20/13.
//
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#define kFilename @"PrinDB.sqlite"


@interface CourseSummaryViewController : UIViewController{
    sqlite3    *database;
    NSMutableArray *tableViewArray;
    int classcrn;
    NSString *instructorname;
}
-(NSString *) dataFilePath;
- (void) initCourseSummary:(int) iCrn;
@property (nonatomic, retain) NSMutableArray *tableViewArray;
@end
