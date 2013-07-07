//
//  RegexParser.h
//  Principia
//
//  Created by Dennis on 3/10/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegexParser : NSObject
{
    NSMutableArray *RegexPatterns;
    NSMutableArray *CleanUpStr;
}
@property (nonatomic,retain) NSMutableArray *RegexPatterns;
@property  (nonatomic,retain) NSMutableArray *CleanUpStr;
-(NSMutableArray *)Output:(NSString *)incoming;
-(void)AddPatterns:(NSArray *)patternarray;
-(void)AddDirtyParams:(NSArray *)params;
@end
