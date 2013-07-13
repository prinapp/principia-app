//
//  Events.m
//  Principia
//
//  Created by Dennis on 3/12/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Events.h"
#import "SMWebRequest.h"
#import "TouchXML.h"
#import "DataUtil.h"
#import "Meals.h"

@implementation Events

@synthesize EventsList,ViewList,FilterMenu,Date,datepick;
@synthesize SocialReq,webView,back,reload, busy_image;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Events", @"Events");
        self.tabBarItem.image = [UIImage imageNamed:@"events"];
    }
    return self;
}

#pragma mark -
#pragma mark Google Calendar API

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [busy_image startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [busy_image stopAnimating];
}

#pragma mark - User Interactions
-(IBAction)back:(id)sender
{
    if(webView.canGoBack)
        [webView goBack];
}

-(IBAction)reload:(id)sender
{
    [webView reload];
}

-(IBAction)ShowFilter:(id)sender
{
    [FilterMenu showFromTabBar:self.tabBarController.tabBar];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSURL *url;
    switch (buttonIndex) {
		case 0:
			url = [[NSURL alloc] initWithString:@"https://www.google.com/calendar/embed?title=Principia+Calendar&showCalendars=0&showTabs=0&showPrint=0&mode=agenda&height=700&wkst=1&bgcolor=%23FFFFFF&src=um6hc1bmkugq2d2v4dcbp31d8o@group.calendar.google.com&color=%23528800&ctz=America/Chicago"];
			break;
		case 1:
        {
			url = [[NSURL alloc] initWithString:@"https://www.google.com/calendar/embed?title=Principia+Calendar&showCalendars=0&showTabs=0&showPrint=0&mode=agenda&height=700&wkst=1&bgcolor=%23FFFFFF&src=in7c6001nutaocbf5cualpqa3k@group.calendar.google.com&color=%23B1440E&src=n6ppjvn6igqtec621r9rt0s8go@group.calendar.google.com&color=%23B1365F&src=1mbqj0g8ui5idqlrq53qr0bido@group.calendar.google.com&color=%2328754E&src=u3p3m60u9141dcsma1j10pa5p8@group.calendar.google.com&color=%231B887A&ctz=America/Chicago"];
            break;
        }
		case 2:
			url = [[NSURL alloc] initWithString:@"https://www.google.com/calendar/embed?title=Principia+Calendar&showCalendars=0&showTabs=0&showPrint=0&mode=agenda&height=700&wkst=1&bgcolor=%23FFFFFF&src=bm2l8vb0603ft7t0f4k655jvao@group.calendar.google.com&color=%235229A3&ctz=America/Chicago"];
			break;
        case 3:
            url = [[NSURL alloc] initWithString:@"https://www.google.com/calendar/embed?title&showCalendars=0&showTabs=0&showPrint=0&mode=agenda&height=300&wkst=1&bgcolor=%23FFFFFF&src=in7c6001nutaocbf5cualpqa3k@group.calendar.google.com&color=%23B1440E&src=n6ppjvn6igqtec621r9rt0s8go@group.calendar.google.com&color=%23B1365F&src=1mbqj0g8ui5idqlrq53qr0bido@group.calendar.google.com&color=%2328754E&src=bm2l8vb0603ft7t0f4k655jvao@group.calendar.google.com&color=%235229A3&src=u3p3m60u9141dcsma1j10pa5p8@group.calendar.google.com&color=%231B887A&src=um6hc1bmkugq2d2v4dcbp31d8o@group.calendar.google.com&color=%23528800&ctz=America/Chicago"];

		
	}
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [webView loadRequest:request];
}

-(void)ProcessFeed
{
        NSLog(@"Feed Sucessful");
}


-(void)LoadCalendarTest
{
    
}

-(IBAction)showMeals:(id)sender
{
    Meals *Meal= [[NSClassFromString(@"Meals") alloc] initWithNibName:@"Meals" bundle:nil];
    [self.navigationController pushViewController:Meal animated:YES];

}
#pragma mark - View lifecycle

- (void)LoadMainCalendar
{
    NSURL *calendarurl = [[NSURL alloc] initWithString:@"https://www.google.com/calendar/embed?title&showCalendars=0&showTabs=0&showPrint=0&mode=agenda&height=300&wkst=1&bgcolor=%23FFFFFF&src=in7c6001nutaocbf5cualpqa3k@group.calendar.google.com&color=%23B1440E&src=n6ppjvn6igqtec621r9rt0s8go@group.calendar.google.com&color=%23B1365F&src=1mbqj0g8ui5idqlrq53qr0bido@group.calendar.google.com&color=%2328754E&src=bm2l8vb0603ft7t0f4k655jvao@group.calendar.google.com&color=%235229A3&src=u3p3m60u9141dcsma1j10pa5p8@group.calendar.google.com&color=%231B887A&src=um6hc1bmkugq2d2v4dcbp31d8o@group.calendar.google.com&color=%23528800&ctz=America/Chicago"];
    NSURLRequest *requestpage = [[NSURLRequest alloc] initWithURL:calendarurl];
    [webView loadRequest:requestpage];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self LoadMainCalendar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:0.212 blue:0.416 alpha:1.0];
    
    [self LoadCalendarTest];
    FilterMenu = [[UIActionSheet alloc] initWithTitle:@"Choose a type of Event" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                  @"Social",
                  @"Campus",
                  @"Athletics",
                  @"All Events",
                  nil];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return (UIInterfaceOrientationMaskAll);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

@end
