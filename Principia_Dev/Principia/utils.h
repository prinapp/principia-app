//
//  utils.h
//  Daily Lift
//
//  Created by Dale Matheny on 8/10/10.
//  Copyright 2011 The First Church of Christ, Scientist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "sqlite3.h"
#import <MediaPlayer/MediaPlayer.h>

#define kFilename @"PrinDB.sqlite"

@interface utils : NSObject {
	sqlite3		   *database;
	sqlite3    *tracedb;
	int doTrace;
	MPMoviePlayerController* mediaPlayer;

	int curr_play_type;  //1=music, 2=lift, 3=lecture
	int curr_lift_id;
	BOOL reachable;
}

@property (nonatomic, retain) MPMoviePlayerController *mediaPlayer;
-(NSMutableArray *)performQuery:(NSString *)query;

/********************************************************************************************/
/********************************** Database and Network Functions     **********************/
/********************************************************************************************/
-(int)checkDB;
-(NSString *)dataFilePath;
-(NSString *)dataFilePath3;
-(NSString *)dataFilePath2;
-(void)trace :(NSString *)msg;
-(void)deleteTrace;
-(NSMutableArray *)performQuery:(NSString *)query;

-(void)setAudio :(NSDictionary *)curr_lift_data :(UIViewController *)viewController;
-(void)removeSuper;
-(void)setStop;
-(void)playResource :(NSString *)astr :(UIViewController *)viewController;
-(void)playLocal :(NSString *)astr :(UIViewController *)viewController;
-(void)setPlay;
-(void)setPause;
-(int)getPlayTime;
-(void)playLocal :(NSString *)astr :(UIViewController *)viewController;
-(void)playMovieAtURL:(NSURL*)theURL :(UIViewController *)viewController;
-(int)getCurrPlayType;
-(long)getRemaining;
-(void)setPlayTime:(int)atime;
-(void)playService;
-(void)setMediaView :(UIView *)ctrl_view :(int)orientation;

@end
