//
//  SoPrinViewSelector.h
//  Principia
//
//  Created by Dennis on 3/14/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SoPrinViewSelector : UIViewController
{
    UIButton *facebook;
    UIButton *youtube;
    UIButton *twitter;
    UIButton *flickr;
}
@property(nonatomic,retain) IBOutlet UIButton *facebook;
@property(nonatomic,retain) IBOutlet UIButton *youtube;
@property(nonatomic,retain) IBOutlet UIButton *twitter;
@property(nonatomic,retain) IBOutlet UIButton *flickr;
@end
