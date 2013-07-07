//
//  FlickrShow.h
//  Principia
//
//  Created by Dennis on 3/17/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrShow : UIViewController
{
    NSString *linkaddr;
    UIWebView *wbviewer;
}
@property(nonatomic,retain) NSString *linkaddr;
@property(nonatomic,retain) IBOutlet UIWebView *wbviewer;
-(void)LinkaddrAs:(NSString *)add;

@end
