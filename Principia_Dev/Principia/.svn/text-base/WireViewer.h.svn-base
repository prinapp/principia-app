//
//  WireViewer.h
//  Principia
//
//  Created by Dennis on 3/27/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCustomButtonHeight		30.0

@interface WireViewer : UIViewController <UIWebViewDelegate>
{
    NSString *LinkAddr;
    UIWebView *webView;
    IBOutlet UIActivityIndicatorView *busy_image;
}
@property (nonatomic, retain) UIActivityIndicatorView *busy_image;
@property(nonatomic,retain) NSString *LinkAddr;
@property(nonatomic,retain) IBOutlet UIWebView *webView;
-(void)addAddr:(NSString *)addr;
@end
