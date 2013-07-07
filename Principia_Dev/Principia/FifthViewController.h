//
//  FourthViewController.h
//  Principia
//
//  Created by Dale Matheny on 10/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaPlayer/MediaPlayer.h"
#import "StyledPullableView.h"
// This is defined in Math.h
#define M_PI   3.14159265358979323846264338327950288   /* pi */

// Our conversion definition
#define DEGREES_TO_RADIANS(angle) (angle / 180.0 * M_PI)

@interface FifthViewController : UIViewController <PullableViewDelegate>
{
    UIButton *aButton;
    MPMoviePlayerController *player;
    bool isPlaying, isPIR;
    UIView *newsFeed;
    bool isNewsFeedExpanded;
}
@property(nonatomic, retain) IBOutlet UIButton *aButton;
@property(strong, retain) MPMoviePlayerController *player;
@property(nonatomic,retain) IBOutlet UIView *newsFeed;
-(IBAction)PlayStream:(id)sender;
-(IBAction)flipScreen:(id)sender;
-(IBAction)PlayPIR:(id)sender;
-(IBAction)createNewsFeed:(id)sender;

@end
