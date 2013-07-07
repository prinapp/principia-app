//
//  FirstViewController.m
//  Principia
//  Places
//
//  Created by Dale Matheny on 10/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "FirstViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@implementation FirstViewController {
    GMSMapView *mapView_;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Campus Map", @"Campus Map");
        self.tabBarItem.image = [UIImage imageNamed:@"places"];
    }
    return self;
}

// You don't need to modify the default initWithNibName:bundle: method.

- (void)loadView {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:38.949
                                                            longitude:-90.349
                                                                 zoom:17];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
/*    GMSMarkerOptions *options = [[GMSMarkerOptions alloc] init];
    options.position = CLLocationCoordinate2DMake(38.9555, -90.3475);
    options.title = @"Principia";
    options.snippet = @"Gatehouse";
    [mapView_ addMarkerWithOptions:options]; */
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadView];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:0.212 blue:0.416 alpha:1.0]; 
	// Do any additional setup after loading the view, typically from a nib.

         
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
