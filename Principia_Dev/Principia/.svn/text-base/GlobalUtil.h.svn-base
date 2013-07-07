//
//  Flashy.h
//  Principia
//
//  Created by Dennis on 3/2/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalUtil : NSObject <NSURLConnectionDelegate>
{
    NSMutableArray *FlashyLinks;
    NSURL *FACEBOOKURL;
    NSURL *TWITTERURL;
    NSURL *YOUTUBEURL;
    NSMutableArray *FlickrList;
    NSMutableArray *WireList;
    bool isELSConnect;
}
@property(nonatomic,retain)NSMutableArray *FlashyLinks;
@property(nonatomic,retain)NSURL *FACEBOOKURL;
@property(nonatomic,retain)NSURL *TWITTERURL;
@property(nonatomic,retain)NSURL *YOUTUBEURL;
@property(nonatomic,retain)NSMutableArray *FlickrList;
@property(nonatomic,retain)NSMutableArray *WireList;
+(GlobalUtil *)GetFlashy;
-(void)StartTestForELS;
-(BOOL)RtnConTest;
-(void)InitializeConnection;
+(void)showNoNetScreen;
@end
