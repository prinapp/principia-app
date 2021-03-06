//
//  DataUtil.h
//  Principia
//
//  Created by Dennis on 2/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataUtil : NSObject

+(NSString *)ConvertDBString:(char *)input;
+(NSNumber *)ConvertDBNumber:(int)input;
+(NSDate *)dateParser:(NSString *) rawstr :(bool) istime;
+(NSString *)GetCurrDateStr;
+(NSString *)ConvertDate:(NSString *)string;
+(void)GetDataToParse:(NSString *)url :(NSString *)methodName :(id)object;
+(NSArray *)convertXMLToNodes:(NSString *)delimiter :(NSData *)XMLdata;
@end
