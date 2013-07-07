//
//  WireViewer.m
//  Principia
//
//  Created by Dennis on 3/27/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "WireViewer.h"


@implementation WireViewer
@synthesize LinkAddr,webView,busy_image;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)addAddr:(NSString *)addr
{
    LinkAddr = addr;
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
-(IBAction)segmentAction:(id)sender {
	UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
	if (segmentedControl.selectedSegmentIndex==0)
		[webView goBack];
	else
		[webView goForward];
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:LinkAddr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:
                                            [NSArray arrayWithObjects:
                                             [UIImage imageNamed:@"icon_left.png"],
                                             [UIImage imageNamed:@"icon_play.png"],
                                             nil]];
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.frame = CGRectMake(0, 0, 60, kCustomButtonHeight);
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    segmentedControl.momentary = YES;
    
    UIBarButtonItem *segmentBarItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
    
    self.navigationItem.rightBarButtonItem = segmentBarItem;
    [webView loadRequest:request];
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [busy_image startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [busy_image stopAnimating];
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
