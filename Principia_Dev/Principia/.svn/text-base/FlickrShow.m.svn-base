//
//  FlickrShow.m
//  Principia
//
//  Created by Dennis on 3/17/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "FlickrShow.h"

@implementation FlickrShow
@synthesize linkaddr,wbviewer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)LinkaddrAs:(NSString *)addr
{
    linkaddr = addr;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.flickr.com/photos/principiacollege/sets/%@/show",linkaddr]]; 
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [wbviewer loadRequest:request];
    
    // Do any additional setup after loading the view from its nib.
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
