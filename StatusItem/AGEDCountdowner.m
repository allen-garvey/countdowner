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
		[self setEndDate:[self defaultEndDate]];
		[self setEndMessage:[self defaultEndMessage]];
	}
	return self;
}

-(NSString*)timeLeft:(NSTimer*)t
{
	@autoreleasepool {
		
		_timer = t;
		
		int MINUTE = 60;
		int HOUR = MINUTE * 60;
		int DAY = HOUR * 24;
		
		NSDate *now = [[NSDate alloc] init];
		
		int intTotalSeconds = (int) [_endDate timeIntervalSinceDate:now];
		now = nil;
		
		if(intTotalSeconds <= 0){
			[_timer invalidate];
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
			
			
			return [NSString stringWithFormat:@"%02d %@\n%02d %@\n%02d %@\n%02d %@",  daysLeft, dayString, hoursLeft, hourString, minutesLeft, minuteString, secondsLeft, secondString];
		}		
	}
}
-(void)displayTimer:(NSTimer*)t
{
	[_delegate updateTimeDisplays:[self timeLeft:t]];
	NSLog(@"Timer updated");
}

-(NSDate *) defaultEndDate
{
	return [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitYear value:1 toDate:[NSDate date] options:0];
	
}
-(NSString*) defaultEndMessage
{
	return @"One Year Finished!";
}


@end
