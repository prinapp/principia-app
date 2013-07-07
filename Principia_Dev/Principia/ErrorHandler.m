//
//  ErrorHandler.m
//  Principia
//
//  Created by Dennis Adjei-Baah on 6/29/13.
//
//

#import "ErrorHandler.h"

@implementation ErrorHandler
+(NSString *)printError:(NSError *)errorobj
{
    return [NSString stringWithFormat:@"%@",[errorobj localizedDescription]];
}

@end
