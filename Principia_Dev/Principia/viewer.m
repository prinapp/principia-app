//
//  viewer.m
//  Daily Lift
//
//  Created by Dale Matheny on 8/9/10.
//  Copyright 2011 The First Church of Christ, Scientist. All rights reserved.
//

#import "viewer.h"

@implementation viewer
@synthesize webView,Url,busy_image, timer;

-(IBAction)segmentAction:(id)sender {
	UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
	if (segmentedControl.selectedSegmentIndex==0)
		[webView goBack];
	else
		[webView goForward];
	//[self dismissModalViewControllerAnimated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView { 
    [busy_image startAnimating];
	viewloaded=FALSE;
}

-(void)setViewType:(int)aviewtype {
	viewType=aviewtype;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [busy_image stopAnimating];
	[self performSelector:@selector(positionPage) withObject:NULL afterDelay:0.0];

//	[webView stringByEvaluatingJavaScriptFromString:@"<script>var txtBox=document.getElementById(\"author\"); if (txtBox!=null ) txtBox.focus();</script>"];
	viewloaded=TRUE;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
		
		// Tells the webView to load pdfUrl
		[self performSelector:@selector(processURL) withObject:NULL afterDelay:0.0];
    }
    return self;
}

-(void)positionPage {
	if (viewType==1) {
		[webView stringByEvaluatingJavaScriptFromString:@"document.body.style.zoom=5.0;"];
		[webView stringByEvaluatingJavaScriptFromString:@"window.scrollTo(800,document.body.scrollHeight-5740);"];
	}
}

-(void)processURL {
	[webView loadRequest:[NSURLRequest requestWithURL:Url]];
	webView.scalesPageToFit = YES;
}

- (void)viewDidLoad {
	// "Segmented" control to the right
	
	/*	timer=[NSTimer scheduledTimerWithTimeInterval:20.0
	 target:self
	 selector:@selector(timeout:)
	 userInfo:nil
	 repeats:NO];
	 */
}

-(IBAction)timeout:(id)sender {
	if (!viewloaded) {
		[webView stopLoading];
		UIAlertView *alert=[[UIAlertView alloc] init];
		alert=[[UIAlertView alloc] initWithTitle:@"Network Timeout" message:@"No connectivity, try again when you have a network connection." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
		[alert show];
	}
	[timer invalidate];
	timer=nil;
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{  //if OK then perform action for message type
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES; //(interfaceOrientation == UIInterfaceOrientationPortrait);
}

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


@end
