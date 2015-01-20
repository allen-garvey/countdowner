//
//  AppDelegate.h
//  StatusItem
//
//  Created by Allen Xavier on 6/8/14.
//  Copyright (c) 2014 ___ALLENGARVEY___. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AGEDCountdowner.h"


@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSMenu *menu;

- (IBAction)quit:(id)sender;

@property (weak) IBOutlet NSMenuItem *timerText;

@property (unsafe_unretained) IBOutlet NSWindow *preferencesWindow;
@property (strong) AGEDCountdowner *counter;
@property (weak) IBOutlet NSDatePicker *editDateField;

@property (unsafe_unretained) IBOutlet NSWindow *countdownWindow;
@property (weak) IBOutlet NSTextField *countdownLabel;
@property (unsafe_unretained) IBOutlet NSWindow *aboutWindow;

@property (weak) IBOutlet NSTextField *endMessageTextField;


@end
