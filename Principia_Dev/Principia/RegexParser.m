//
//  RegexParser.m
//  Principia
//
//  Created by Dennis on 3/10/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "RegexParser.h"

@implementation RegexParser

@synthesize RegexPatterns,CleanUpStr;

-(void)AddPatterns:(NSArray *)patternarray
{
    RegexPatterns = [[NSMutableArray alloc] init];
    for(NSString *str in patternarray)
    {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:str options:NSRegularExpressionCaseInsensitive error:nil];
        [RegexPatterns addObject:regex];
    }
    
}
-(void)AddDirtyParams:(NSArray *)params
{
    CleanUpStr = [[NSMutableArray alloc] initWithArray:params];
}

-(NSString *)CleanUp:(NSString *)dirtystr
{
    
    for(NSString *param in CleanUpStr)
    {
        if([dirtystr rangeOfString:param].location != NSNotFound)
        {
            return [dirtystr stringByReplacingOccurrencesOfString:param withString:@""];
        }
    }
    return dirtystr;
}

-(NSMutableArray *)Output:(NSString *)incoming
{
    
    if(RegexPatterns != nil)
    {
        
        NSMutableArray *values = [[NSMutableArray alloc] init];
    
        for(NSRegularExpression *regex in RegexPatterns)
        {
            NSTextCheckingResult *match = [regex firstMatchInString:incoming options:0 range:NSMakeRange(0, [incoming length])];
            NSString *teststr;
            if(match)
            {
                NSRange matchRange = [match range];
                teststr = [incoming substringWithRange:matchRange];
                teststr = [self CleanUp:teststr];
                NSLog(@"%@", teststr);
            }
            if(teststr == nil)
            {
                [values addObject:@"N/A"];
            }
            else
            {
                [values addObject:teststr];
            }
        }
        return values; 
    }
    return NULL;
}



@end
