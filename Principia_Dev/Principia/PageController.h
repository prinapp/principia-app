//
//  ViewControllerForDuplicateEndCaps.h
//  InfiniteScrollView
//
//  Created by Jacob Haskins on 10/31/10.
//  Copyright 2010 Accella. All rights reserved.
//  Accella.net
//
//  More tips and tricks: iOSDeveloperTips.com
//

#import <UIKit/UIKit.h>



@interface PageController : UIViewController <UIScrollViewDelegate> {
    
    
    int width;
    int height;
	IBOutlet UIScrollView *scrollView;
    NSMutableArray *ImgArray;
    NSInvocation *SendmstoTimer;
    NSTimer *Animtime;
    int islandscapemsg;
    int isinstructmsg;
    bool isplaying;
    NSUserDefaults *defaults;
    NSMutableArray *Flashylinks;
}
@property (nonatomic,retain) NSInvocation *SendmstoTimer;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic,retain) NSMutableArray *ImgArray;
@property (nonatomic,retain) NSTimer *Animtime;
@property(nonatomic,retain) NSUserDefaults *defaults;
@property (strong, nonatomic) NSMutableArray *Flashylinks;
- (void)addImageWithName:(int)imageString atPosition:(int)position;
-(IBAction)PlayPauseDetect:(UITapGestureRecognizer *)sender;
-(IBAction)ShowNavBar:(UITapGestureRecognizer *)sender;

@end
