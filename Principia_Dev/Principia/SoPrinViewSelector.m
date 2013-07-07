//
//  SoPrinViewSelector.m
//  Principia
//
//  Created by Dennis on 3/14/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "SoPrinViewSelector.h"
#import "GlobalUtil.h"

@implementation SoPrinViewSelector
@synthesize facebook,flickr,youtube,twitter;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"SoPrin!", @"SoPrin!");
        self.tabBarItem.image = [UIImage imageNamed:@"message"];    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)Initialize
{
    //self.tabBarItem.image = [UIImage imageNamed:@"message"];

    [facebook setImage:[UIImage imageNamed:@"facebook"] forState:UIControlStateNormal];
    [flickr setImage:[UIImage imageNamed:@"flickr"] forState:UIControlStateNormal];
    [youtube setImage:[UIImage imageNamed:@"youtube-icon-PNG"] forState:UIControlStateNormal];
    [twitter setImage:[UIImage imageNamed:@"icon-twitter"] forState:UIControlStateNormal];
    
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:0.212 blue:0.416 alpha:1.0];
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
    self.title = NSLocalizedString(@"SoPrin!", @"SoPrin!");
    self.tabBarItem.image = [UIImage imageNamed:@"message"];    
    [super viewDidLoad];
    [self Initialize];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
