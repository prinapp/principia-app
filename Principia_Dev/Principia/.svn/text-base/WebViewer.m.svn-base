//
//  WebViewer.m
//  Principia
//
//  Created by Dennis on 3/14/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "WebViewer.h"
#import "GlobalUtil.h"

@implementation WebViewer
@synthesize wbviewer,back,Forward,PageURL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {        
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    GlobalUtil *obj = [GlobalUtil GetFlashy];
    switch (self.view.tag) {
        case 200:
        {
            obj.FACEBOOKURL = wbviewer.request.URL;
            break;
        }
        case 201:
            obj.TWITTERURL = wbviewer.request.URL.absoluteURL;
            break;
        case 202:
            obj.YOUTUBEURL = wbviewer.request.URL.absoluteURL;
        default:
            break;
    }
}

-(void)LoadURL:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [wbviewer loadRequest:request];
    
}

- (void)viewDidAppear:(BOOL)animated
{
}

-(IBAction)segmentAction:(id)sender {
	UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
	if (segmentedControl.selectedSegmentIndex==0)
		[wbviewer goBack];
	else
		[wbviewer goForward];
	//[self dismissModalViewControllerAnimated:YES];
}

-(IBAction)GoBack:(id)sender
{
    if (wbviewer.canGoBack) {
        [wbviewer goBack];
    }
}

-(IBAction)GoForward:(id)sender
{
    if(wbviewer.canGoForward)
    {
        [wbviewer goForward];
    }
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    GlobalUtil *obj = [GlobalUtil GetFlashy];
    switch (self.view.tag) {
        case 200:
            [self LoadURL:obj.FACEBOOKURL];
            break;
        case 201:
            [self LoadURL:obj.TWITTERURL];
            break;
        case 202:
            [self LoadURL:obj.YOUTUBEURL];
        default:
            break;
    }
	wbviewer.scalesPageToFit = YES;
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:
                                            [NSArray arrayWithObjects:
                                             [UIImage imageNamed:@"icon_left.png"],
                                             [UIImage imageNamed:@"icon_play.png"],
                                             nil]];
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.frame = CGRectMake(0, 0, 60, 30);
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.momentary = YES;
    
    UIBarButtonItem *segmentBarItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
    
    self.navigationItem.rightBarButtonItem = segmentBarItem;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
