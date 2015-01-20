//
//  AGEDCountdowner.h
//  Countdowner
//
//  Created by Allen Xavier on 1/19/15.
//  Copyright (c) 2015 ___ALLENGARVEY___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGEDCountdowner : NSObject

-(void) displayTimer: (NSTimer *)t;
-(void)displayTimer;
-(NSString*) timeLeft:(NSTimer *)t;

@property (weak, nonatomic) IBOutlet NSMenuItem *timerLabel;
@property (strong, nonatomic) NSDate *endDate;
@property (weak, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet NSTextField *countdownLabel;
@property (strong, nonatomic) NSString *endMessage;

@end
