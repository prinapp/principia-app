//
//  FirstViewController.m
//  Principia
//
//  Created by Dale Matheny on 10/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//http://snook.ca/archives/javascript/simplest-jquery-slideshow code taken to implement flashybox


#import "SixthViewController.h"
#import "AppDelegate.h"
#import "GlobalUtil.h"


@interface SixthViewController ()

@end

@implementation SixthViewController

@synthesize segcon,webpage,linklist,flashlinks,timer,flashyweb,animview,BackBt,ForwardBt;


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    
	[self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated;
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(NSString *)loadflashysite
{
    NSString *myText;
    NSMutableString *html;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"basehtml" ofType:@"txt"];  
    if (filePath) {  
        myText = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];  
        if (myText) {  
            NSLog(@"%@",myText);  
        }  
    }
    
    html = [[NSMutableString alloc] initWithString:myText];
    for (int index = 0; index<flashlinks.count; index++) {
        [html appendString:[NSString stringWithFormat:@"<img src=\"%@\">",(NSString *)[flashlinks objectAtIndex:index]]];
    }
    [html appendString:@"</div></body></html>"];
    return html;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"SoPrin!", @"SoPrin!");
        self.tabBarItem.image = [UIImage imageNamed:@"food"];
    }
    return self;
}

-(void)Flashyscroller
{
    if (slidenum == (flashlinks.count - 1)) {
        slidenum = 0;
    }
    NSURL *flashurl = [NSURL URLWithString:[flashlinks objectAtIndex:slidenum]];
    NSURLRequest *flashyrequest = [[NSURLRequest alloc] initWithURL:flashurl];
    [flashyweb loadRequest:flashyrequest];
    slidenum++;

}
-(void)FlipView
{
    if(animview == MAINV)
    {
    [UIView transitionFromView:webpage toView:flashyweb duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
    }else
    {
        [UIView transitionFromView:flashyweb toView:webpage duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
    }
}
- (void)LoadURL:(int)segment
{
    if(segment == 2)
    {
        
        [webpage loadHTMLString:[linklist objectAtIndex:segment] baseURL:nil];
        
    }
    else{
        
        if (animview == FLASHV) {
            flashyweb.hidden = YES;
            [self FlipView];
            animview = MAINV;
        }
    NSURL *url = [NSURL URLWithString:[linklist objectAtIndex:segment]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webpage loadRequest:request];
    }
}
-(IBAction)Navilink:(UISegmentedControl *)sender
{
   
    
       
    
}

-(IBAction)GoBack:(id)sender
{
    
        if([webpage canGoBack])
            [webpage goBack];
    
}
-(IBAction)GoFwd:(id)sender
{
    
    if ([webpage canGoForward]) {
        [webpage goForward];
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    slidenum = 0;
    segcon.selectedSegmentIndex = 0;
    GlobalUtil *obj =[GlobalUtil GetFlashy];
    flashlinks = obj.FlashyLinks;
    [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(Flashyscroller) userInfo:nil repeats:YES];
    linklist = [[NSMutableArray alloc] init];
    [linklist addObject:@"http://www.flickr.com/photos/principiacollege/sets/"];
    [linklist addObject:@"http://www.youtube.com/principiacollege"];
    [linklist addObject:[self loadflashysite]];
    [self LoadURL:segcon.selectedSegmentIndex];
    animview = MAINV;
    
    
  
    
    
}


-(IBAction)SegmentToggle:(UISegmentedControl *)sender
{
    NSLog(@"segment %i",[sender selectedSegmentIndex]);
    [self LoadURL:[sender selectedSegmentIndex]];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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
