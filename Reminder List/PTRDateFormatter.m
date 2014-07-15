//
//  PTRDateFormatter.m
//  Reminder List
//
//  Created by Wu Jiashi on 9/7/14.
//  Copyright (c) 2014 Pewteroid Rockcliffe. All rights reserved.
//

#import "PTRDateFormatter.h"

@implementation PTRDateFormatter

+ (NSString *)formatHours:(int)hours{
    NSString *h = hours > 1 ? @"hours" : @"hour";
    return [NSString stringWithFormat:@"%d %@ ", hours, h];
}

+ (NSString *)formatMinutes:(int)minutes{
    NSString *m = minutes > 1 ? @"minutes" : @"minute";
    return [NSString stringWithFormat:@"%d %@ ", minutes, m];
}

+ (NSString *)formatDueDateFromDate:(NSDate *)dueDate
{
    NSTimeInterval periodTillDue = [dueDate timeIntervalSinceDate:[NSDate date]];
    NSMutableString *dueDateText = [[NSMutableString alloc]init];
    
    if (periodTillDue < 0) {
        dueDateText = [NSMutableString stringWithString:@"Overdued "];
    }
    
    if (abs(periodTillDue) < 60 * 60 * 5) {
        if (periodTillDue < 0) {
            periodTillDue *= -1;
            if (periodTillDue < 60) {
                return @"Now";
            }
        } else {
            // Make countdown timing nicer, especially in last 1 minute
            periodTillDue += 60;
        }
        
        int hours = periodTillDue / 60.0 / 60;
        int minutes = (periodTillDue - hours * 60 * 60)/60;
        
        if (hours > 0) {
            [dueDateText appendString:[self formatHours:hours]];
        }
        if (minutes > 0) {
            [dueDateText appendString:[self formatMinutes:minutes]];
        }
    } else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        if (periodTillDue < 60 * 60 * 24 * 7){
            [dateFormatter setDateFormat: @"HH:mm  —  EEEE"];
        }
        else {
            [dateFormatter setDateFormat:@"HH:mm  —  dd MMMM"];
        }
        [dueDateText appendString:[dateFormatter stringFromDate: dueDate]];
    }
    return dueDateText;
}

+ (NSString *)formatRelativeTimeFromDate:(NSDate *)dueDate
{
    return nil;
}

@end
