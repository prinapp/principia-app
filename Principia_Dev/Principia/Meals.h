//
//  Meals.h
//  Principia
//
//  Created by Dennis Adjei-Baah on 4/8/13.
//
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#define kFileName @"PrinDB.sqlite"

@interface Meals : UITableViewController <UIAlertViewDelegate>
{
    NSMutableArray *listData;
    sqlite3 *database;
    UIButton *brk;
    UIButton *lnch;
    UIButton *din;
    int eventtype;
    NSString *dateselected;
    UILabel *date;
    UIDatePicker *dobPicker;
    UIAlertView *dAlert;
}
@property(nonatomic,retain) NSMutableArray *listData;
@property(nonatomic,retain) UIAlertView *dAlert;
@property(nonatomic,retain) UIDatePicker *dobPicker;
@property(nonatomic,retain) IBOutlet UIButton *brk;
@property(nonatomic,retain) IBOutlet UIButton *lnch;
@property(nonatomic,retain) IBOutlet UIButton *din;
@property(nonatomic,retain) IBOutlet UILabel *date;
@property(nonatomic,retain) NSString *dateselected;
-(IBAction)selectbrk:(id)sender;
-(IBAction)selectlnch:(id)sender;
-(IBAction)selectdin:(id)sender;
- (NSString *)dataFilePath;
@end
