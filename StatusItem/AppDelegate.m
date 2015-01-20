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

@synthesize window = _window;
@synthesize menu = _menu;


- (IBAction)updateButtonAction:(id)sender {
	[_counter setEndDate:_editDateField.dateValue];
	[_counter.timer invalidate];
	
	__unused NSTimer *countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:_counter selector:@selector(displayTimer:) userInfo:nil repeats:true];

	[self saveNSStringtoFile:[_counter.endDate description] type:@"endDate"];
	
	[_counter setEndMessage:_endMessageTextField.stringValue];
	[self saveNSStringtoFile:_endMessageTextField.stringValue type:@"endMessage"];
	[_preferencesWindow setIsVisible:NO];
	
}

-(IBAction)cancelButtonAction:(id)sender
{
	[_preferencesWindow setIsVisible:NO];
}

- (IBAction)launchDetailWindow:(id)sender {
	[_countdownWindow setIsVisible:true];
}
- (IBAction)launchAboutWindow:(id)sender {
	[_aboutWindow setIsVisible:true];
}


- (IBAction)editEndDate:(id)sender {

	[_preferencesWindow setIsVisible:true];
	[_editDateField setDateValue:_counter.endDate];
	[_endMessageTextField setStringValue:_counter.endMessage];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{	
	statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	statusItem.button.title = @"Ω";
	statusItem.menu = self.menu;
	statusItem.highlightMode = YES;
	
	_counter = [AGEDCountdowner new];
	
	NSString *savedDate = [self StringFromFile:@"endDate"];
	if (savedDate != nil) {
		[_counter setEndDate:[self NSDateDescriptionToDate:savedDate]];
	}
	
	NSString *savedEndMessage = [self StringFromFile:@"endMessage"];
	if (savedEndMessage != nil) {
		[_counter setEndMessage:savedEndMessage];
	}
	
	[_counter setTimerLabel:self.timerText];
	[_counter setCountdownLabel:self.countdownLabel];
	[_counter displayTimer];
	__unused NSTimer *countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:_counter selector:@selector(displayTimer:) userInfo:nil repeats:true];
	[_countdownWindow setBackgroundColor:[NSColor whiteColor]];
	
}

- (IBAction)quit:(id)sender {
	[[NSApplication sharedApplication] terminate:nil];
	
}

- (NSDate*)NSDateDescriptionToDate:(NSString*)dateDescription
{
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
	return [dateFormatter dateFromString:dateDescription];
}

- (void)saveNSStringtoFile:(NSString*)str type:(NSString*)type
{
	NSString *directory = [self getDirectory];
	NSFileManager *fm = [NSFileManager defaultManager];
	[fm changeCurrentDirectoryPath:directory];
	
	// Create a new directory
	if ([fm createDirectoryAtPath: @"countdowner" withIntermediateDirectories: YES attributes: nil error: NULL] == NO) {
		NSLog (@"Couldn't create directory!");
	}
	
	NSString * path;
	if ([type isEqualToString:@"endDate"]) {
		path = [self getEndDatePath];
	}
	else{
		path = [self getEndMessagePath];
	}
	
	NSError *error;
	
	bool file_write =  [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
	if (!file_write) {
		NSLog(@"writing %@ failed: %@", path, [error localizedDescription]);
	}
}

- (NSString*)StringFromFile:(NSString*)type
{
	NSString * path;
	if ([type isEqualToString:@"endDate"]) {
		path = [self getEndDatePath];
	}
	else{
		path = [self getEndMessagePath];
	}
	
	NSError *error;
	NSString *str = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
	if (!str) {
		NSLog(@"read of %@ failed: %@", path, [error localizedDescription]);
	}
	return str;

}

- (NSString*)getEndDatePath
{
	return [NSString stringWithFormat:@"%@/countdowner/countdowner.txt", [self getDirectory]];
}

- (NSString*)getEndMessagePath
{
	return [NSString stringWithFormat:@"%@/countdowner/message.txt", [self getDirectory]];
}

- (NSString*)getDirectory
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
	
	return paths[0];
	
	
}

@end
