//
//  Flashy.m
//  Principia
//
//  Created by Dennis on 3/2/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "GlobalUtil.h"
#import "Reachability.h"

@implementation GlobalUtil
@synthesize FlashyLinks,TWITTERURL,FACEBOOKURL,YOUTUBEURL,FlickrList,WireList;
static GlobalUtil *instance = nil;
-(void)LoadURLs
{
    
            FACEBOOKURL = [NSURL URLWithString:@"https://www.facebook.com/Principia.College"];
         
            TWITTERURL = [NSURL URLWithString:@"https://twitter.com/princollege"];
        
            YOUTUBEURL = [NSURL URLWithString:@"http://www.youtube.com/principiacollege"];
        
}
+(GlobalUtil *)GetFlashy
{
    @synchronized(self)    
    {    
        if(instance==nil)    
        {    
            
            instance= [GlobalUtil new];
            
            
            
            [instance LoadURLs];
        }    
    }
    
    return instance;
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Server could not be reached");
    isELSConnect = false;
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSData *getData = [NSData dataWithData: connection.currentRequest.HTTPBody];
    NSString *string = [[NSString alloc] initWithData:getData encoding:NSUTF8StringEncoding];
    NSLog(@"Test:%@",string);
    isELSConnect = true;
}

-(void)StartTestForELS
{
    NSURL *url = [NSURL URLWithString:@"http://elsah.prin.edu"];
    NSURLRequest *request =[[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
    
    NSURLConnection *connect = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [connect start];
}

-(BOOL)RtnConTest
{
    
    return isELSConnect;
}

-(void)InitializeConnection
{
    struct sockaddr_in callAddress;
    callAddress.sin_len = sizeof(callAddress);
    callAddress.sin_family = AF_INET;
    callAddress.sin_port = htons(24);
    callAddress.sin_addr.s_addr = inet_addr("10.130.1.50");
    
    Reachability * reach = [Reachability reachabilityWithAddress:&callAddress];
    
    
    
    
    
    reach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            isELSConnect = TRUE;
            
        });
        
    };
    
    reach.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            isELSConnect = FALSE;
        });
    };
    
    [reach startNotifier];
    
    if ([reach isReachableViaWiFi]) {
        isELSConnect = TRUE;
    }
    else isELSConnect = FALSE;
    
}

+ (void)showNoNetScreen
{
    UIAlertView *connectionalert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"Unable to connect to PrinWeb. Please connect to Principia's WIFI network" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [connectionalert show];
    
}

@end
