//
//  Events.h
//  Principia
//
//  Created by Dennis on 3/12/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#define kFileName @"PrinDB.sqlite"

@interface Events : UIViewController <UIActionSheetDelegate, UIAlertViewDelegate, UIWebViewDelegate>
{
    NSMutableArray *EventsList;
    NSMutableArray *ViewList;
    UIActionSheet *FilterMenu;
    UILabel *Date;
    UIDatePicker *datepick;
    NSString *SocialReq;
    sqlite3 *database;
    UIWebView *webView;
    UIBarItem *back;
    UIBarItem *reload;
    IBOutlet UIActivityIndicatorView *busy_image;
}

@property (nonatomic, retain) UIActivityIndicatorView *busy_image;
@property(nonatomic,retain) NSString *SocialReq;
@property(nonatomic,retain) IBOutlet UILabel *Date;
@property(nonatomic,retain) IBOutlet UIDatePicker *datepick;
@property (nonatomic,retain) NSMutableArray *EventsList;
@property(nonatomic, retain) NSMutableArray *ViewList;
@property(nonatomic,retain) IBOutlet UIWebView *webView;
@property(nonatomic,retain) UIActionSheet *FilterMenu;
@property(nonatomic,retain) IBOutlet UIBarItem *back;
@property(nonatomic,retain) IBOutlet UIBarItem *reload;
-(IBAction)back:(id)sender;
-(IBAction)reload:(id)sender;
-(IBAction)ShowFilter:(id)sender;
-(IBAction)showMeals:(id)sender;

@end
