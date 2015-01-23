//
//  AppDelegate.h
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

#import <Cocoa/Cocoa.h>
#import "AGEDCountdowner.h"
#import "AGEDCountdownerController.h"


@interface AppDelegate : NSObject <NSApplicationDelegate, AGEDCountdownerDelegate>

//IB view objects
@property (assign) IBOutlet NSWindow *window; //deleting this breaks the build for some reason
@property (weak) IBOutlet NSMenu *menu;
@property (weak) IBOutlet NSMenuItem *timerText;
@property (unsafe_unretained) IBOutlet NSWindow *preferencesWindow;
@property (weak) IBOutlet NSDatePicker *editDateField;
@property (unsafe_unretained) IBOutlet NSWindow *countdownWindow;
@property (weak) IBOutlet NSTextField *countdownLabel;
@property (unsafe_unretained) IBOutlet NSWindow *aboutWindow;
@property (weak) IBOutlet NSTextField *endMessageTextField;

//controller for model
@property(strong, nonatomic)AGEDCountdownerController * countdownerController;

//AGEDCountdownerDelegate Methods
-(void)updateTimeDisplays:(NSString *)timeLeft;


@end
