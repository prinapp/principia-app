//
//  DatePick.h
//  Principia
//
//  Created by Dennis Adjei-Baah on 4/15/13.
//
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "Meals.h"
#define kFileName @"PrinDB.sqlite"

@interface DatePick : UITableViewController <UITableViewDataSource, UITableViewDelegate>

{
    NSString *dateselected;
    NSMutableArray *datelist;
    sqlite3 *database;
    Meals *mealsctl;
}
@property(nonatomic,retain) NSString *dateselected;
@property(nonatomic,retain) NSMutableArray *datelist;
@property(nonatomic,retain) Meals *mealsctl;
-(NSString *)rtnDate;
-(NSString *)dataFilePath;
@end
