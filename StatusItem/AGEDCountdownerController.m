//
//  AGEDCountdownerController.m
//  Countdowner
//
//  Created by Allen Xavier on 1/23/15.
//  Copyright (c) 2015 ___ALLENGARVEY___. All rights reserved.
//
/*
see license.txt for full license information
 
 */

#import "AGEDCountdownerController.h"
#import "AGEDCountdowner.h"

@interface AGEDCountdownerController()
{
	NSTimer *_countdownTimer;
}
@end

@implementation AGEDCountdownerController

-(BOOL)loadAndInitializeCountdownerWithDelegate:(id<AGEDCountdownerDelegate>)delegate{
	//initializes counter
	_counter = [AGEDCountdowner new];
	[_counter setDelegate:delegate];
	BOOL wasFileLoaded;
	NSDictionary *prefDic = [self preferencesDictionaryFromFile];
	
	if(prefDic){
		[_counter setEndMessage:[prefDic objectForKey:[self endMessagePreferencesKey]]];
		[_counter setEndDate:[self NSDateDescriptionToDate:[prefDic objectForKey:[self endDatePreferencesKey]]]];
		wasFileLoaded = YES;
	}
	else{
		//save counter defaults to file since none exists
		[self savePreferencesDictionaryToFile:[_counter endDate] message:[_counter endMessage]];
		wasFileLoaded = NO;
	}
	return wasFileLoaded;
}

-(BOOL)updateAndSaveCountdowner:(NSDate *)endDate endMessage:(NSString *)endMessage{
	[_counter setEndDate:endDate];
	[_counter setEndMessage:endMessage];
	BOOL saveSuccessful = [self savePreferencesDictionaryToFile:[_counter endDate] message:[_counter endMessage]];
	return saveSuccessful;
}


#pragma mark - Countdowner Start/Stop methods
-(void)startCountdowner{
	[self stopCountdowner]; //to avoid multiple timers
	[_counter displayTimer:nil]; //used so that display is not blank for first second before timer kicks in
	_countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:_counter selector:@selector(displayTimer:) userInfo:nil repeats:true];
}

-(void)stopCountdowner{
	if (_countdownTimer) {
		[_countdownTimer invalidate];
	}
}

#pragma mark - Save and Get Preferences from file methods

- (NSDate*)NSDateDescriptionToDate:(NSString*)dateDescription
{
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
	return [dateFormatter dateFromString:dateDescription];
}

-(BOOL)savePreferencesDictionaryToFile:(NSDate *)date message:(NSString *)message{
	NSDictionary * prefDic = @{[self endMessagePreferencesKey] : message, [self endDatePreferencesKey] : [date description]};
	
	NSString *directory = [self getDirectory];
	NSFileManager *fm = [NSFileManager defaultManager];
	[fm changeCurrentDirectoryPath:directory];
	BOOL wasSaveSuccessful = YES;
	// Create a new directory
	NSError * dirError;
	if ([fm createDirectoryAtPath: [self preferencesDirName] withIntermediateDirectories: YES attributes: nil error: &dirError] == NO) {
		NSLog (@"Couldn't create %@ directory! %@", [self preferencesDirName], [dirError localizedDescription]);
		wasSaveSuccessful = NO;
	}
	
	bool file_write =  [prefDic writeToFile:[NSString stringWithFormat:@"%@/%@", [self preferencesDirName],[self preferencesFileName]] atomically:YES];
	if (!file_write) {
		NSLog(@"writing %@ failed", [self preferencesFileName]);
		wasSaveSuccessful = NO;
	}
	return wasSaveSuccessful;
}

-(NSDictionary *)preferencesDictionaryFromFile{
	NSString *path = [NSString stringWithFormat:@"%@/%@/%@", [self getDirectory], [self preferencesDirName], [self preferencesFileName]];
	
	NSDictionary* prefDic = [[NSDictionary alloc] initWithContentsOfFile:path];
	if (!prefDic) {
		NSLog(@"read of %@ failed", path);
	}
	return prefDic;
}


#pragma mark - File Name Constants

- (NSString*)getDirectory
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
	return paths[0];
}

-(NSString *)endMessagePreferencesKey{
	return @"endMessageKey";
}

-(NSString *)endDatePreferencesKey{
	return @"endDateKey";
}

-(NSString *)preferencesFileName{
	return @"preferences.xml";
}

-(NSString *)preferencesDirName{
	return @"countdowner";
}

@end
