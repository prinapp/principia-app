//
//  ViewControllerForDuplicateEndCaps.m
//  InfiniteScrollView
//
//  Created by Jacob Haskins on 10/31/10.
//  Copyright 2010 Accella. All rights reserved.
//  Accella.net
//
//  More tips and tricks: iOSDeveloperTips.com
//

#import "PageController.h"
#import "GlobalUtil.h"
#import "SMWebRequest.h"


@implementation PageController

@synthesize scrollView,ImgArray,SendmstoTimer,Animtime,defaults,Flashylinks;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"FlashyBox", @"FlashyBox");
        self.tabBarItem.image = [UIImage imageNamed:@"places"];
    }
    return self;
}
-(void)PlayPause
{
    if(isplaying)
    {
        [Animtime invalidate];
        Animtime = nil;
        isplaying = !isplaying;
    }
    else
    {
        Animtime = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(ScrollingTimer) userInfo:nil repeats:YES];
        isplaying = !isplaying;
    }
    
}
-(void)ScrollingTimer
{
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        if(isinstructmsg == 0)
        {
            UIAlertView *instruct = [[UIAlertView alloc] initWithTitle:@"FlashyBox Instructions" message:@"Double Tap to stop and start slideshow. Swipe left or right to scroll through images" delegate:self cancelButtonTitle:@"Got It!" otherButtonTitles: nil];
            [instruct show];
            isinstructmsg = 1;
            
        }
        CGFloat contentOffset = scrollView.contentOffset.x;
        int nextPage = (int)(contentOffset/scrollView.frame.size.width) + 1 ;
        
        if (scrollView.contentOffset.x == 0) {         
            // user is scrolling to the left from image 1 to image 4         
            // reposition offset to show image 4 that is on the right in the scroll view         
            [scrollView scrollRectToVisible:CGRectMake(ImgArray.count*width,0,width,height) animated:NO];     
        }    
        else if (scrollView.contentOffset.x == (ImgArray.count+1)*width) {         
            // user is scrolling to the right from image 4 to image 1        
            // reposition offset to show image 1 that is on the left in the scroll view         
            [scrollView scrollRectToVisible:CGRectMake(width,0,width,height) animated:NO];         
        } 
        
        [scrollView scrollRectToVisible:CGRectMake(nextPage*scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
        
        
    }
    
    

}

-(void)HideNavBar
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidAppear:(BOOL)animated
{
    
     
    if (islandscapemsg == 0) {
        UIAlertView *landscpmsg = [[UIAlertView alloc] initWithTitle:@"User Experience" message:@"Turn the phone sideways for optimum flashybox experience!" delegate:self cancelButtonTitle:@"Got It!" otherButtonTitles: nil];
        [landscpmsg show];
        islandscapemsg = 1;
    }
    [self PlayPause];
    [self HideNavBar];
    
    
}
-(IBAction)ShowNavBar:(UITapGestureRecognizer *)sender
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(HideNavBar) userInfo:nil repeats:NO];
}
-(IBAction)PlayPauseDetect:(UITapGestureRecognizer *)sender
{
    [self PlayPause];
}
- (void)viewDidLoad {
    defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"insmsg"] != nil) {
        isinstructmsg = [defaults integerForKey:@"insmsg"];
         } else {
             isinstructmsg = 0;
         }
    if ([defaults objectForKey:@"lndscpmsg"] != nil) {
        islandscapemsg = [defaults integerForKey:@"lndscpmsg"];
    } else {
        islandscapemsg = 0;
    }
    
    isplaying = NO;
    
    if([UIScreen mainScreen].bounds.size.height == 568.0)
    {
        width = 568.0;
    }
    else
    {
    width = 480;
    }
    height = 251;
    [super viewDidLoad];
    if(ImgArray == nil)
    {
        ImgArray = [NSMutableArray new];
    }
    else
    {
        [ImgArray removeAllObjects];
    }
    GlobalUtil *obj = [GlobalUtil GetFlashy];
    NSMutableArray *wrkarr = obj.FlashyLinks;
    if(wrkarr.count > 0)
    {
      
    
    
    for (NSString *i in wrkarr) {
        NSURL *url = [NSURL URLWithString:i];
        NSData *imagedata = [[NSData alloc] initWithContentsOfURL:url];
        UIImage *pic = [[UIImage alloc] initWithData:imagedata];
        [ImgArray addObject:pic];
    }
    
	
	// add the last image (image4) into the first position
	[self addImageWithName:(ImgArray.count-1) atPosition:0];
	
	// add all of the images to the scroll view
	for (int i = 0; i < ImgArray.count; i++) {
		[self addImageWithName:i atPosition:i+1];
	}
	
	// add the first image (image1) into the last position
	[self addImageWithName:0 atPosition:(ImgArray.count+1)];
	
	scrollView.contentSize = CGSizeMake((ImgArray.count+2)*width, height);    
	[scrollView scrollRectToVisible:CGRectMake(width,0,width,height) animated:NO];
    }
}

- (void)addImageWithName:(int)imgnum atPosition:(int)position {
	// add image to scroll view
	UIImageView *imageView = [[UIImageView alloc] initWithImage:[ImgArray objectAtIndex:imgnum]];
    
	imageView.frame = CGRectMake(position*width, 0, width, height);
	[scrollView addSubview:imageView];

    
	
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender {    
	NSLog(@"%f",scrollView.contentOffset.x);
    
    if (scrollView.contentOffset.x == 0) {         
        // user is scrolling to the left from image 1 to image 4         
        // reposition offset to show image 4 that is on the right in the scroll view         
        [scrollView scrollRectToVisible:CGRectMake(ImgArray.count*width,0,width,height) animated:NO];     
    }    
    else if (scrollView.contentOffset.x == (ImgArray.count+1)*width) {         
        // user is scrolling to the right from image 4 to image 1        
        // reposition offset to show image 1 that is on the left in the scroll view         
        [scrollView scrollRectToVisible:CGRectMake(width,0,width,height) animated:NO];         
    } 
	// The key is repositioning without animation      
	
}


/**************************************************************************/
#pragma mark FlashyBox RSS parsing

-(void)requestError
{
    [GlobalUtil showNoNetScreen];
}
-(void)ParseFlashy:(NSData *)data
{
    GlobalUtil *obj= [GlobalUtil GetFlashy];
    Flashylinks = [[NSMutableArray alloc] init];
    
    NSString *astring = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *linklist = [astring componentsSeparatedByString:@"img src=\""];
    for(int index = 1;index<[linklist count];index++)
    {
        
        NSArray *aurl = [[linklist objectAtIndex:index] componentsSeparatedByString:@"\""];
        [Flashylinks addObject:[NSString stringWithString:[aurl objectAtIndex:0]]];
    }
    
    
    obj.FlashyLinks = Flashylinks;
    
    
}

-(void)loadflashyrequest
{
    NSURL *scurl = [[NSURL alloc] initWithString:
                    @"http://prinweb.prin.edu/slider/rss/"];
    SMWebRequest * request = [SMWebRequest requestWithURL:scurl];
    [request addTarget:self action:@selector(ParseFlashy:) forRequestEvents:SMWebRequestEventComplete];
    [request addTarget:self action:@selector(requestError) forRequestEvents:SMWebRequestEventError];
    [request start];
}

/**************************************************************************/
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
   
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    GlobalUtil *obj = [GlobalUtil GetFlashy];
    if(![obj RtnConTest])
    {
        [GlobalUtil showNoNetScreen];
    }
    [self loadflashyrequest];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    isplaying = NO;
    [defaults setInteger:isinstructmsg forKey:@"insmsg"];
    [defaults setInteger:islandscapemsg forKey:@"lndscpmsg"];
    [Animtime invalidate];
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}
@end
