//
//  PTRReminderItem.m
//  ReminderList
//
//  Created by Wu Jiashi on 16/2/14.
//
//

#import "PTRReminderItem.h"

@implementation PTRReminderItem

- (void)findNextRecurrentDueDate
{
    // check time already due before implemented shifting recurrence?
    switch (self.recurrencePeriod) {
        case PeriodDay: {
            NSTimeInterval time = 60 * 60 * 24 * self.recurrenceAmount;
            self.dueDate = [NSDate dateWithTimeInterval:time sinceDate:self.recurrenceDueDate];
            self.recurrenceDueDate = self.dueDate;
        }
            break;
        case PeriodWeek: {
            NSTimeInterval time = 60 * 60 * 24 * 7 * self.recurrenceAmount;
            self.dueDate = [NSDate dateWithTimeInterval:time sinceDate:self.recurrenceDueDate];
            self.recurrenceDueDate = self.dueDate;
        }
            break;
        case PeriodMonth: {
            NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            [dateComponents setMonth:self.recurrenceAmount];
            self.dueDate = [calendar dateByAddingComponents:dateComponents toDate:self.recurrenceDueDate options:0];
            self.recurrenceDueDate = self.dueDate;
        }
            break;
        case PeriodYear: {
            NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            [dateComponents setYear:self.recurrenceAmount];
            self.dueDate = [calendar dateByAddingComponents:dateComponents toDate:self.recurrenceDueDate options:0];
            self.recurrenceDueDate = self.dueDate;
        }
            break;
        default:
            break;
    }
    //[self postponeDueDateByTimeInterval:time];
    //need remove recurrence?
}

- (void)postponeDueDateByTimeInterval:(NSTimeInterval)time
{
    // Save recurrence time before postponing current dueDate
    if (self.recurrencePeriod != PeriodNone && self.recurrenceDueDate == nil) {
        self.recurrenceDueDate = self.dueDate;
    }
    
    // If overdue,
    if ([[NSDate date] compare:self.dueDate] == NSOrderedDescending) {
        self.dueDate = [NSDate dateWithTimeInterval:time sinceDate:[NSDate date]];
    } else {
        self.dueDate = [NSDate dateWithTimeInterval:time sinceDate:self.dueDate];
    }
}

@end
