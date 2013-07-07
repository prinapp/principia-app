//
//  WebViewer.h
//  Principia
//
//  Created by Dennis on 3/14/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewer : UIViewController
{
    UIWebView *wbviewer;
    UIBarItem *back;
    UIBarItem *Forward;
    NSURL *PageURL;
}
@property(nonatomic,retain) NSURL *PageURL;
@property(nonatomic,retain) IBOutlet UIWebView *wbviewer;
@property(nonatomic,retain) IBOutlet UIBarItem *back;
@property(nonatomic,retain) IBOutlet UIBarItem *Forward;
-(IBAction)GoBack:(id)sender;
-(IBAction)GoForward:(id)sender;
@end
