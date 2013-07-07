//
//  utils.m
//  Daily Lift
//
//  Created by Dale Matheny on 8/10/10.
//  Copyright 2011 The First Church of Christ, Scientist. All rights reserved.
//

#import "utils.h"

@implementation utils
@synthesize mediaPlayer;

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"DB Path: %@",documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:kFilename];
}

- (NSString *)dataFilePath3 {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"trace.sqlite3"];
}

- (NSString *)dataFilePath2 {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFilename];
}

-(int)checkDB {
	NSString *dbpath=[self dataFilePath];							//documents db path
	NSString *dbpath_temp=[self dataFilePath2];						//documents temp db path
    
	//COPY RESOURCE DB TO DOCUMENTS FOLDER
	NSFileManager *fileManager = [NSFileManager defaultManager];
	int ret=[fileManager fileExistsAtPath:dbpath];					//new app, no database in documents

	if (!ret) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:kFilename ofType:nil];  //resource db
        NSError *error;
        if(![fileManager copyItemAtPath:filePath toPath:dbpath_temp error:&error]) {  //copy resource to temp db
            NSLog(@"Error copying the database: %@", [error description]);
        }
    }
	return [fileManager fileExistsAtPath:dbpath];
}

-(NSMutableArray *)performQuery:(NSString *)query {
    sqlite3_stmt *statement = nil;
    const char *sql = [query UTF8String];
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"[SQLITE] Error when preparing query!");
    } else {
        NSMutableArray *result = [NSMutableArray array];
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSMutableArray *row = [NSMutableArray array];
            for (int i=0; i<sqlite3_column_count(statement); i++) {
                int colType = sqlite3_column_type(statement, i);
                id value;
                if (colType == SQLITE_TEXT) {
                    const unsigned char *col = sqlite3_column_text(statement, i);
                    value = [NSString stringWithFormat:@"%s", col];
                } else if (colType == SQLITE_INTEGER) {
                    int col = sqlite3_column_int(statement, i);
                    value = [NSNumber numberWithInt:col];
                } else if (colType == SQLITE_FLOAT) {
                    double col = sqlite3_column_double(statement, i);
                    value = [NSNumber numberWithDouble:col];
                } else if (colType == SQLITE_NULL) {
                    value = [NSNull null];
                } else {
                    NSLog(@"[SQLITE] UNKNOWN DATATYPE");
                }
                
                [row addObject:value];
            }
            [result addObject:row];
        }
        return result;
    }
    return nil;
}

/*-(int)checkDB {
	doTrace=0;

	if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }

    char *errorMsg;
    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS LIFTS (LIFT_ID INTEGER PRIMARY KEY AUTOINCREMENT, lift_seq_id integer, DATESTAMP TEXT, TITLE TEXT, Lecturer_name TEXT, lecturer_location text, Lecturer_image_url TEXT, lecturer_bio_url text, Audio_url_remote text, Audio_url_local text, blog_url text, num_comments integer, bookmark integer, comment_post_id integer);";  
    if (sqlite3_exec (database, [createSQL  UTF8String],NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert1(0, @"Error creating table: %s", errorMsg);
    }

    createSQL = @"CREATE TABLE IF NOT EXISTS COMMENTS (LIFT_ID INTEGER, seq_id integer, comment_from text, comment text);";
    if (sqlite3_exec (database, [createSQL  UTF8String],NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert1(0, @"Error creating table: %s", errorMsg);
    }

    createSQL = @"CREATE TABLE IF NOT EXISTS PARMS (parm_name text, parm_value text);";
    if (sqlite3_exec (database, [createSQL  UTF8String],NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert1(0, @"Error creating table: %s", errorMsg);
    }

	sqlite3_stmt *stmt;
	int count=0;
	NSString *query = @"SELECT count(*) from lifts";
	if (sqlite3_prepare_v2( database, [query UTF8String],-1, &stmt, nil) == SQLITE_OK) { }
	if (sqlite3_step(stmt) == SQLITE_ROW) {
		count=sqlite3_column_int(stmt, 0);
	}
	sqlite3_finalize(stmt);

	sqlite3_close(database);
	return count==0;
}
*/

-(void)playMovieAtURL:(NSURL*)theURL :(UIViewController *)viewController
{
    self.mediaPlayer=[[MPMoviePlayerController alloc] initWithContentURL:theURL];

	//for background playing
//	NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
//	int playBackground=[[defaults objectForKey:kplay_background] intValue];
//	NSLog(@"playBackground audio:%d",playBackground);
//	if (playBackground==1)
//		mediaPlayer.useApplicationAudioSession=NO;
//	else {
//		mediaPlayer.useApplicationAudioSession=YES;
//	}

    self.mediaPlayer.scalingMode = MPMovieScalingModeAspectFill;

    // Register for the playback finished notification. 
    [[NSNotificationCenter defaultCenter] addObserver:viewController 
											 selector:@selector(myMovieFinishedCallback:) 
												 name:MPMoviePlayerPlaybackDidFinishNotification 
											   object:self.mediaPlayer]; 

	// Register for the playback finished notification. 
    [[NSNotificationCenter defaultCenter] addObserver:viewController 
											 selector:@selector(myMovieFinishedLoading:) 
												 name:MPMoviePlayerLoadStateDidChangeNotification 
											   object:self.mediaPlayer]; 
		
    // Movie playback is asynchronous, so this method returns immediately. 
    [self.mediaPlayer play]; 
} 

-(void) playLocal :(NSString *)astr :(UIViewController *)viewController {
	NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *url_local =[[documentPath objectAtIndex:0] stringByAppendingPathComponent:[astr lastPathComponent]];
	NSURL *url = [NSURL fileURLWithPath:url_local];

	[self playMovieAtURL:url :viewController];
}

-(void) playResource :(NSString *)astr :(UIViewController *)viewController {
//	curr_play_type=kmusic;
	[self setStop];
 	NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],astr]];
	[self playMovieAtURL:url :viewController];
}

-(void) setAudio :(NSDictionary *)curr_lift_data :(UIViewController *)viewController {
	NSFileManager *fileManager = [NSFileManager defaultManager];

//	curr_play_type=klifts;
	curr_lift_id=[[curr_lift_data objectForKey:@"lift_id"] intValue];
	[self setStop];
	NSString *url_remote=[curr_lift_data objectForKey:@"audio_remote"];
	NSString *url_local=[curr_lift_data objectForKey:@"audio_local"];
	
	//If url_local file is NOT there then it should be so go get it!
	if ( (![url_local isEqualToString:@""]) && (![fileManager fileExistsAtPath:url_local]) ) {
		[[NSData dataWithContentsOfURL:[NSURL URLWithString:url_remote]] writeToFile:url_local atomically:TRUE];
	}

	//PLAY IT!
	if ( ([url_local isEqualToString:@""]) || (![fileManager fileExistsAtPath:url_local]) ) {
		[self playMovieAtURL:[NSURL URLWithString:url_remote] :viewController];
	}
	else 
		[self playLocal:url_local :viewController];
}

-(void)playService{
//	curr_play_type=kservices;
	[self setStop];
}

-(void)setPlay {
	[self.mediaPlayer play];
}

-(int)getPlayTime {
	return self.mediaPlayer.currentPlaybackTime;
}

-(long)getRemaining{
	return [self.mediaPlayer duration];
}

-(void)setPlayTime:(int)atime{
	self.mediaPlayer.currentPlaybackTime=atime;
}

-(int)getCurrLift {
	return curr_lift_id;
}

-(void)setStop {
	[self.mediaPlayer stop];
}

-(void)setPause {
	[self.mediaPlayer pause];
}

-(void)removeSuper {
	[[self.mediaPlayer view] removeFromSuperview];
}

-(void)setMediaView :(UIView *)ctrl_view :(int)orientation {
	[[self.mediaPlayer view] removeFromSuperview];

	if ((orientation==UIInterfaceOrientationLandscapeLeft) || (orientation==UIInterfaceOrientationLandscapeRight)) {
		[[self.mediaPlayer view] setFrame:CGRectMake(0, 1, 312, 24)];  // frame must match parent view
	}
	else {
		[[self.mediaPlayer view] setFrame:CGRectMake(0, 2, 260, 32)];  // frame must match parent view
	}

//	CGRect arect=[ctrl_view bounds];
//	NSLog(@"ctrl view bounds: %0.0f %0.0f %0.0f %0.0f",arect.origin.x,arect.origin.y,arect.size.width, arect.size.height);
//	arect=[[self.mediaPlayer view] bounds];
//	NSLog(@"media player bounds: %0.0f %0.0f %0.0f %0.0f",arect.origin.x,arect.origin.y,arect.size.width, arect.size.height);
	[ctrl_view addSubview:[self.mediaPlayer view]];

	/*MPMovieControlStyleNone,
	 MPMovieControlStyleEmbedded,
	 MPMovieControlStyleFullscreen,
	 */
}

-(int) getCurrPlayType {
	return curr_play_type;
}


-(void)deleteTrace {
	if (doTrace==1) {
		if (sqlite3_open([[self dataFilePath2] UTF8String], &tracedb) != SQLITE_OK) {
			sqlite3_close(tracedb);
			NSAssert(0, @"Failed to open database");
		}	
		char *errorMsg;
		NSString *createSQL = @"delete from TRACE;";
		if (sqlite3_exec (tracedb, [createSQL  UTF8String],NULL, NULL, &errorMsg) != SQLITE_OK) {
			NSLog(@"Error creating table: %s", errorMsg);
		}
		sqlite3_close(tracedb);
	}
}

-(void)trace :(NSString *)msg {
	if (doTrace==1) {
		if (sqlite3_open([[self dataFilePath2] UTF8String], &tracedb) != SQLITE_OK) {
			sqlite3_close(tracedb);
			NSAssert(0, @"Failed to open database");
		}
		
		char *errorMsg;
		NSString *createSQL = @"CREATE TABLE IF NOT EXISTS TRACE (DATESTAMP TEXT, trace TEXT);";
		if (sqlite3_exec (tracedb, [createSQL  UTF8String],NULL, NULL, &errorMsg) != SQLITE_OK) {
			sqlite3_close(tracedb);
			NSAssert1(0, @"Error creating table: %s", errorMsg);
		}
		
		NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
		[dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss +0000"];
		NSDate *today = [[NSDate alloc] init];
		NSString *timenow = [dateFormat stringFromDate:today];
		
		char *update="";
		sqlite3_stmt *stmt;
		if ([msg isEqualToString:@"CLEAR"]) {
			update = "DELETE FROM TRACE;";
			if (sqlite3_prepare_v2(tracedb, update, -1, &stmt, nil) == SQLITE_OK) { }
			if (sqlite3_step(stmt) != SQLITE_DONE) NSAssert(0, @"Error updating table");
			sqlite3_finalize(stmt);
		}
		else {
			update = "INSERT INTO TRACE (DATESTAMP, trace) VALUES (?, ?);";
			if (sqlite3_prepare_v2(tracedb, update, -1, &stmt, nil) == SQLITE_OK) {
				sqlite3_bind_text(stmt, 1, [[NSString stringWithFormat:@"%@", timenow] UTF8String], -1, NULL);
				sqlite3_bind_text(stmt, 2, [[NSString stringWithFormat:@"%@", msg] UTF8String], -1, NULL);
			}
			if (sqlite3_step(stmt) != SQLITE_DONE)
				NSAssert(0, @"Error updating table");
			sqlite3_finalize(stmt);
		}
		
		sqlite3_close(tracedb);
	}
}

@end
