//
//  FirstViewController.m
//  Principia
//  Chapel/PIR
//
//  Created by Dale Matheny on 10/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FifthViewController.h"
#import "ModalViewController.h"

@interface FifthViewController ()
@end

@implementation FifthViewController
@synthesize aButton, player, newsFeed;

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    
	//[self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    
	//[self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Principia", @"Principia");
        self.tabBarItem.image = [UIImage imageNamed:@"bullhorn"];
    }
    return self;
}

- (void)rotateImage:(UIImageView *)image duration:(NSTimeInterval)duration
              curve:(int)curve degrees:(CGFloat)degrees
{
    
    // Setup the animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:curve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // The transform matrix
    CGAffineTransform transform =
    CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(degrees));
    image.transform = transform;
    
    // Commit the changes
    [UIView commitAnimations];
}

- (void)viewDidLoad
{
   /* UIImageView *imageToMove =
    [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"prinseal.png"]];
    imageToMove.frame = CGRectMake(10, 10, 100, 50);
    [self.view addSubview:imageToMove];
    [self rotateImage:imageToMove duration:3.0
                curve:UIViewAnimationCurveEaseInOut degrees:360];
    */
    
    [super viewDidLoad];
    isNewsFeedExpanded = NO;
    UIImage *pause2 =[UIImage imageNamed:@"PIR_Select.png"];
    [aButton setImage:pause2 forState:UIControlStateSelected];
    pause2 =[UIImage imageNamed:@"pir.png"];
    [aButton setImage:pause2 forState:UIControlStateNormal];

    
//    UIImage *pause1 = [[UIImage alloc] initWithContentsOfFile:@"pir.png"];
  //  [aButton setImage:pause1 forState:UIControlStateNormal];

    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:0.212 blue:0.416 alpha:1.0];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return (UIInterfaceOrientationMaskPortrait);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
    /*
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }*/
}

-(IBAction)flipScreen:(id)sender {
    ModalViewController *infoview = [[ModalViewController alloc] initWithNibName:@"ModalViewController" bundle:nil];
    infoview.navigationItem.title=@"Information";
    infoview.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //UIModalTransitionStyleCrossDissolve
    [self.navigationController pushViewController:infoview animated:YES];
//    [self presentModalViewController:infoview animated:YES];
}

-(IBAction)PlayPIR:(id)sender {
    if(player != nil)
    {
        if(isPIR)
        {
            [player pause];
            [aButton setSelected:FALSE];
        }
        
        else {
            player=nil;
            player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:@"http://prinedu.ic.llnwd.net/stream/prinedu_stream.pls"]];
//            player.useApplicationAudioSession=NO;
            [aButton setSelected:TRUE];
            [player play];
        }
        isPIR = !isPIR;
    }
    else {
        player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:@"http://prinedu.ic.llnwd.net/stream/prinedu_stream.pls"]];
//        player.useApplicationAudioSession=NO;
        player.view.hidden = YES;
        [self.view addSubview:player.view];
        [aButton setSelected:TRUE];
        [player play];
        isPIR = true;
    }
    isPlaying=false;
}

-(IBAction)PlayStream:(id)sender
{
    [aButton setSelected:FALSE];

    if(player != nil)
    {

        if(isPlaying)
        {
            [player pause];
        }
        
        else {
            player=nil;
            NSBundle *bundle = [NSBundle mainBundle];
            NSString *moviePath = [bundle pathForResource:@"chimes1" ofType:@"wav"];
            NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
            player = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
//            player.useApplicationAudioSession=NO;

            [player play];
        }
        isPlaying = !isPlaying;
    }
    
    if(player == nil){
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *moviePath = [bundle pathForResource:@"chimes1" ofType:@"wav"];
        NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
        player = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
//        player.useApplicationAudioSession=NO;

        //player.movieSourceType = MPMovieSourceTypeStreaming;
        player.view.hidden = YES;
        [self.view addSubview:player.view];
        [player play];
        isPlaying = true;
    }
    isPIR=false;
}

-(IBAction)toggleNewsFeed:(id)sender
{
    if (isNewsFeedExpanded) {
        CGRect tempFrame=newsFeed.frame;
        tempFrame.size.height=320;
        [UIView beginAnimations:@"" context:nil];
        [UIView setAnimationDuration:0.4];
        newsFeed.frame=tempFrame;
        [UIView commitAnimations];
    }
    else{
        CGRect tempFrame=newsFeed.frame;
        tempFrame.size.height=22;
        [UIView beginAnimations:@"" context:nil];
        [UIView setAnimationDuration:0.4];
        newsFeed.frame=tempFrame;
        [UIView commitAnimations];
    }
    isNewsFeedExpanded = !isNewsFeedExpanded;
    
}

@end
