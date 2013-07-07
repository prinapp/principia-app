//
//  SixthViewController.h
//  Principia
//
//  Created by Dale Matheny on 10/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum 
{
    MAINV,
    FLASHV
} CurView;

@interface SixthViewController : UIViewController
{
    UIButton *BackBt;
    UIButton *ForwardBt;
    UISegmentedControl *segcon;
    UIWebView *webpage;
    NSMutableArray *linklist;
    NSMutableArray *flashlinks;
    NSTimer *timer;
    int slidenum;
    UIWebView *flashyweb;
    CurView animview;
    
    
    


}
@property(nonatomic,retain)IBOutlet UISegmentedControl *segcon;
@property(nonatomic,retain) IBOutlet UIWebView *webpage;
@property(nonatomic,retain) NSMutableArray *linklist;
@property(nonatomic,retain) NSMutableArray *flashlinks;
@property(nonatomic,retain) IBOutlet UIWebView *flashyweb;
@property(nonatomic,retain) NSTimer *timer;
@property(nonatomic,retain) IBOutlet UIButton *BackBt;
@property(nonatomic,retain) IBOutlet UIButton *ForwardBt;
@property CurView animview;
-(IBAction)SegmentToggle:(UISegmentedControl *)sender;
-(IBAction)GoBack:(id)sender;
-(IBAction)GoFwd:(id)sender;



@end
