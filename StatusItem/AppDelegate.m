//
//  AppDelegate.m
//  StatusItem
//
//  Created by Allen Xavier on 6/8/14.
//  Copyright (c) 2014 ___ALLENGARVEY___. All rights reserved.
//

#import "AppDelegate.h"
#include "AGEDCountdowner.h"

@interface AppDelegate ()
{
	NSStatusItem* statusItem;
}
@end

@implementation AppDelegate

@synthesize window = _window; //deleting this breaks the build for some reason
@synthesize menu = _menu;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	//sets up status bar appearance
	statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
//	statusItem.button.title = @"Ω"; //can be used instead of image
	NSImage *statusbarIcon = [NSImage imageNamed:@"StatusbarIcon"];
	[statusbarIcon setTemplate:YES]; //so that dark mode will work correctly
	statusItem.button.image = statusbarIcon;
	statusItem.menu = self.menu;
	statusItem.highlightMode = YES;
	
	//initializes counter
	_counter = [AGEDCountdowner new];
	
	NSDictionary *prefDic = [self preferencesDictionaryFromFile];
	if(prefDic){
		[_counter setEndMessage:[prefDic objectForKey:[self endMessagePreferencesKey]]];
		[_counter setEndDate:[self NSDateDescriptionToDate:[prefDic objectForKey:[self endDatePreferencesKey]]]];
	}
	else{
		//save counter defaults to file
		[self savePreferencesDictionaryToFile:[_counter endDate] message:[_counter endMessage]];
	}
	
	[_counter setDelegate:self];
	[_counter displayTimer:nil]; //used so that display is not blank for first second before timer kicks in
	__unused NSTimer *countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:_counter selector:@selector(displayTimer:) userInfo:nil repeats:true];
	[_countdownWindow setBackgroundColor:[NSColor whiteColor]];
	
}

#pragma mark - AGEDCountdowner Delegate Method

-(void)updateTimeDisplays:(NSString *)timeLeft{
	[_timerText setTitle:timeLeft];
	[_countdownLabel setStringValue:timeLeft];
}

#pragma mark - Button Action Methods

- (IBAction)updateButtonAction:(id)sender {
	[[_counter timer] invalidate];
	[_counter setEndDate:_editDateField.dateValue];
	[_counter setEndMessage:_endMessageTextField.stringValue];
	__unused NSTimer *countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:_counter selector:@selector(displayTimer:) userInfo:nil repeats:true];
	
	[self savePreferencesDictionaryToFile:[_counter endDate] message:[_counter endMessage]];
	
	[_preferencesWindow setIsVisible:NO];
	
}

-(IBAction)cancelButtonAction:(id)sender
{
	[_preferencesWindow setIsVisible:NO];
}

- (IBAction)launchDetailWindow:(id)sender {
	[_countdownWindow setIsVisible:YES];
	[_countdownWindow makeMainWindow];
}
- (IBAction)launchAboutWindow:(id)sender {
	[_aboutWindow setIsVisible:YES];
	[_countdownWindow makeMainWindow];
}


- (IBAction)editEndDate:(id)sender {
	[_editDateField setDateValue:_counter.endDate];
	[_endMessageTextField setStringValue:_counter.endMessage];
	[_preferencesWindow setIsVisible:YES];
	[_preferencesWindow makeMainWindow];
	
}

- (IBAction)quit:(id)sender {
	[[NSApplication sharedApplication] terminate:nil];
	
}

#pragma mark - Save and Get Preferences from file methods

- (NSDate*)NSDateDescriptionToDate:(NSString*)dateDescription
{
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
	return [dateFormatter dateFromString:dateDescription];
}

-(void)savePreferencesDictionaryToFile:(NSDate *)date message:(NSString *)message{
	NSDictionary * prefDic = @{[self endMessagePreferencesKey] : message, [self endDatePreferencesKey] : [date description]};
	
	NSString *directory = [self getDirectory];
	NSFileManager *fm = [NSFileManager defaultManager];
	[fm changeCurrentDirectoryPath:directory];
	
	// Create a new directory
	NSError * dirError;
	if ([fm createDirectoryAtPath: [self preferencesDirName] withIntermediateDirectories: YES attributes: nil error: &dirError] == NO) {
		NSLog (@"Couldn't create %@ directory! %@", [self preferencesDirName], [dirError localizedDescription]);
	}
	
	bool file_write =  [prefDic writeToFile:[NSString stringWithFormat:@"%@/%@", [self preferencesDirName],[self preferencesFileName]] atomically:YES];
	if (!file_write) {
		NSLog(@"writing %@ failed", [self preferencesFileName]);
	}
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
