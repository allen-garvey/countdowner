//
//  AGEDCountdowner.m
//  Countdowner
//
//  Created by Allen Garvey on 1/19/15.
//  Copyright (c) 2015 ___ALLENGARVEY___. All rights reserved.
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
			if (_timer) {
				[_timer invalidate];
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
			
			
			return [NSString stringWithFormat:@"%02d %@\n%02d %@\n%02d %@\n%02d %@",  daysLeft, dayString, hoursLeft, hourString, minutesLeft, minuteString, secondsLeft, secondString];
		}		
	}
}
-(void)displayTimer:(NSTimer*)t
{
	[_delegate updateTimeDisplays:[self timeLeft:t]];
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
