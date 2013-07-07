//
//  viewer.h
//  Daily Lift
//
//  Created by Dale Matheny on 8/9/10.
//  Copyright 2011 The First Church of Christ, Scientist. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCustomButtonHeight		30.0

@interface viewer : UIViewController <UIWebViewDelegate> {
	UIWebView	*webView;
	NSURL	*Url;	
	int viewloaded;
	int viewType;
	NSTimer *timer;
	IBOutlet UIActivityIndicatorView *busy_image; 
}

@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) UIActivityIndicatorView *busy_image;
@property (nonatomic, retain) IBOutlet UIWebView	*webView;
@property (nonatomic, retain) NSURL		*Url;
-(void)setViewType:(int)aviewtype;
-(void)processURL;
-(void)positionPage;

@end
