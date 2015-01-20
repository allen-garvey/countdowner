//
//  AGEDCountdowner.m
//  Countdowner
//
//  Created by Allen Xavier on 1/19/15.
//  Copyright (c) 2015 ___ALLENGARVEY___. All rights reserved.
//

#import "AGEDCountdowner.h"

@implementation AGEDCountdowner

-(instancetype)init
{
	self =[super init];
	if(self) {
		[self initDefaultEndDate];
		[self setEndMessage:[self getDefaultEndMessage]];
	}
	return self;
}

-(NSString*)timeLeft:(NSTimer*)t
{
	@autoreleasepool {
		
		t = _timer;
		
		int MINUTE = 60;
		int HOUR = MINUTE * 60;
		int DAY = HOUR * 24;
		
		NSDate *now = [[NSDate alloc] init];
		
		int intTotalSeconds = (int) [_endDate timeIntervalSinceDate:now];
		now = nil;
		
		if(intTotalSeconds <= 0){
			if (t != nil) {
				[t invalidate];
			}
			return _endMessage;
			
		}
		else{
			int daysLeft = intTotalSeconds / DAY;
			NSString *dayString = daysLeft == 1 ? @"Day" : @"Days";
			
			int hoursLeft = (intTotalSeconds % DAY) / HOUR;
			NSString *hourString = hoursLeft == 1 ? @"Hour" : @"Hours";
			
			int minutesLeft = (intTotalSeconds % HOUR) / MINUTE;
			NSString *minuteString = minutesLeft == 1 ? @"Minute" : @"Minutes";
			
			int secondsLeft  = intTotalSeconds % MINUTE;
			NSString *secondString = secondsLeft == 1 ? @"Second" : @"Seconds";
			
			
			return [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@ %@\n%@ %@", [self intFormat: daysLeft], dayString, [self intFormat: hoursLeft], hourString, [self intFormat: minutesLeft], minuteString, [self intFormat: secondsLeft], secondString];
			
		}
		
	}
}
-(void)displayTimer:(NSTimer*)t
{
	[self.timerLabel setTitle:[self timeLeft:t]];
	[self.countdownLabel setStringValue:[self timeLeft:t]];
}

-(void)displayTimer
{
	[self.timerLabel setTitle:[self timeLeft:nil]];
	[self.countdownLabel setStringValue:[self timeLeft:nil]];
}


-(NSString*)intFormat:(int)rawInt
{
	if (rawInt > 9) {
		return [NSString stringWithFormat:@"%d", rawInt];
	}
	else{
		return [NSString stringWithFormat:@"%d%d", 0, rawInt];
	}
}
-(void) initDefaultEndDate
{
	@autoreleasepool {
		NSDateComponents *dateComponent = [[NSDateComponents alloc] init];
		[dateComponent setYear:2014];
		[dateComponent setMonth:8];
		[dateComponent setDay:30];
		[dateComponent setHour:9];
		[dateComponent setMinute:0];
		[dateComponent setSecond:0];
		NSCalendar *cal1 = [NSCalendar currentCalendar];
		_endDate = [cal1 dateFromComponents:dateComponent];
		
		
	}
}
-(NSString*) getDefaultEndMessage
{
	return @"Freedom!";
}


@end
