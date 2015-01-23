//
//  AGEDCountdownerController.h
//  Countdowner
//
//  Created by Allen Xavier on 1/23/15.
//  Copyright (c) 2015 ___ALLENGARVEY___. All rights reserved.
//
/*
see license.txt for full license information

*/

#import <Foundation/Foundation.h>
#import "AGEDCountdowner.h"

@interface AGEDCountdownerController : NSObject

@property(strong, nonatomic, readonly) AGEDCountdowner * counter;

//loads a saved instance of AGEDCountdowner from file or creates a new one if none exist
//and initialize it with the delegate which contains the methods needed for the countdowner
//to update the view. Returns true if loaded from file successfully and false if loading
//from file is unsuccessful
-(BOOL)loadAndInitializeCountdownerWithDelegate:(id<AGEDCountdownerDelegate>)delegate;

//updates the countdowner with a new endDate and endMessage and saves it to a file
//returns true if the file is saved successfully and false if it is not successful
-(BOOL)updateAndSaveCountdowner:(NSDate *)endDate endMessage:(NSString *) endMessage;

//methods start and stop the countdowner respectively. Only use after calling loadAndInitializeCountdownerWithDelegate:
-(void)startCountdowner;
-(void)stopCountdowner;

@end
