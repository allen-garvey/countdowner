//
//  AppDelegate.m
//  Countdowner
//
//  Created by Allen Garvey on 6/8/14.
//  Copyright (c) 2014 ___ALLENGARVEY___. All rights reserved.
//
/*
 The MIT License (MIT)
 
 Copyright (c) <2015> <Allen Garvey>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

#import "AppDelegate.h"
#include "AGEDCountdowner.h"
#include "AGEDCountdownerController.h"

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
	
	//initialize model controller
	_countdownerController = [AGEDCountdownerController new];
	[_countdownerController loadAndInitializeCountdownerWithDelegate:self];
	
	//start timer
	[_countdownerController startCountdowner];
}

#pragma mark - AGEDCountdowner Delegate Method

-(void)updateTimeDisplays:(NSString *)timeLeft{
	[_timerText setTitle:timeLeft];
	[_countdownLabel setStringValue:timeLeft];
	NSLog(@"timer displayed");
}

#pragma mark - Button Action Methods

- (IBAction)updateButtonAction:(id)sender {
	[_countdownerController updateAndSaveCountdowner:_editDateField.dateValue endMessage:_endMessageTextField.stringValue];
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
	[_aboutWindow makeMainWindow];
}


- (IBAction)editEndDate:(id)sender {
	AGEDCountdowner *counter = [_countdownerController counter];
	[_editDateField setDateValue:counter.endDate];
	[_endMessageTextField setStringValue:counter.endMessage];
	[_preferencesWindow setIsVisible:YES];
	[_preferencesWindow makeMainWindow];
	
}

- (IBAction)quit:(id)sender {
	[[NSApplication sharedApplication] terminate:nil];
	
}

@end
