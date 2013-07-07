//
//  DataUtil.m
//  Principia
//
//  Created by Dennis on 2/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "DataUtil.h"
#import "SMWebRequest.h"
#import "TouchXML.h"

@implementation DataUtil

#pragma mark ---Database Logic---
+(NSString *)ConvertDBString:(char *)input
{
    char *wrkstr = input;
    if(wrkstr == nil)
    {
        wrkstr = "";
    }
    NSString *rtnstr = [[NSString alloc] initWithUTF8String:wrkstr] ;
    return rtnstr;
    
}
+(NSNumber *)ConvertDBNumber:(int)input;
{
    int incming = input;
    NSNumber *rtnint = [[NSNumber alloc] initWithInt:incming];
    return rtnint;
}

#pragma mark ---Date Logic---
+(NSDate *)dateParser:(NSMutableString *)rawstr :(bool)istime
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    if(istime)
    {
        [dateFormat setDateFormat:@"HH:mm:ss"];
        
    }else[dateFormat setDateFormat:@"yyyy-M-d"];
    
    NSDate *date = [dateFormat dateFromString:rawstr];
    
    return date;
}

+(NSString *)GetCurrDateStr{
NSDate *currdate = [NSDate date];
NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
[dateFormat setDateFormat:@"yyyy-MM-dd"];
 NSString *dateString = [dateFormat stringFromDate:currdate];
    return dateString;
}

+(NSString *)ConvertDate:(NSString *)date
{
    NSDate *wrkdate = [self dateParser:date :NO];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEEE, d MMMM yyyy"];
    [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString *rtnstr = [dateFormat stringFromDate:wrkdate];
    return rtnstr;
}
/**
 * Method name: GetDataToParse
 * Description: Gets data from a specific url and then calls a user defined method that parses
                the data into what ever format your choosing.
 * Parameters:  url - URL to get data
                methodName - method to parse data
 */

+(void)GetDataToParse:(NSString *)url               //The Url to get the data from
                     :(NSString *)methodName        //The name of the method that is going to parse the data
                     :(id)obj
{
    SMWebRequest *termRequest = [SMWebRequest requestWithURL:[NSURL URLWithString:url]];
    [termRequest addTarget:obj action:NSSelectorFromString(methodName) forRequestEvents:SMWebRequestEventComplete];
    [termRequest addTarget:obj action:NSSelectorFromString(@"requestError:") forRequestEvents:SMWebRequestEventError];
    [termRequest start];
}

+(NSArray *)convertXMLToNodes:(NSString *)delimiter :(NSData *)XMLdata
{
    CXMLDocument *XMLpage = [[CXMLDocument alloc] initWithData:XMLdata options:0 error:nil];
    NSArray *nodes = [XMLpage nodesForXPath:delimiter error:nil];
    return nodes;
}
@end
