//
//  PrinWireNewsList.h
//  Principia
//
//  Created by Dennis on 3/24/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrinWireNewsList : UITableViewController
{
    NSMutableArray *List;           //Hold the list of entries for the uitableview
}
@property(nonatomic,retain)NSMutableArray *List;
@end
