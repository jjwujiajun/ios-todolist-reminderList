//
//  PTRReminderItem.m
//  ReminderList
//
//  Created by Wu Jiashi on 16/2/14.
//
//

#import "PTRReminderItem.h"

@implementation PTRReminderItem

- (void)findNextDueDate
{
    //NSCalendar *calendar = [NSCalendar currentCalendar];
    //NSDateComponents *date = [calendar components:(NSHourCalendarUnit| NSMinuteCalendarUnit)
                                         //fromDate:self.dueDate];
    NSTimeInterval time;
    
    // check time already due before implemented shifting recurrence?
    switch (self.recurrencePeriod) {
        case PeriodDay:
            time = self.recurrenceAmount * 60 * 60 * 24;
            break;
        case PeriodWeek:
            time = self.recurrenceAmount * 60 * 60 * 24 * 7;
            break;
        case PeriodMonth: {
            // depends on month!
            //int hour = [date hour];
            //int minute = [date minute];
            time = self.recurrenceAmount * 60 * 60 * 24 ;
        }
            break;
        case PeriodYear: {
            // depends on year!
            time = self.recurrenceAmount * 60 * 60 * 24;
        }
            break;
        default:
            
            break;
    }
    [self postponeDueDateByTimeInterval:time];
    //need remove recurrence?
}

- (void)postponeDueDateByTimeInterval:(NSTimeInterval)time
{
    self.dueDate = [NSDate dateWithTimeInterval:time sinceDate:self.dueDate];
}

@end
