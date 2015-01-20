//
//  AGEDCountdowner.h
//  Countdowner
//
//  Created by Allen Xavier on 1/19/15.
//  Copyright (c) 2015 ___ALLENGARVEY___. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol AGEDCountdownerDelegate

-(void)updateTimeDisplays:(NSString *)timeLeft;

@end

@interface AGEDCountdowner : NSObject

-(void) displayTimer: (NSTimer *)t;

@property (strong, nonatomic) NSDate *endDate;
@property (weak, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSString *endMessage;
@property (strong, nonatomic) id<AGEDCountdownerDelegate> delegate;

@end




