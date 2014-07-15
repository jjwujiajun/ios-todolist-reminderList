//
//  PTRReminderItem.m
//  ReminderList
//
//  Created by Wu Jiashi on 16/2/14.
//
//

#import "PTRReminderItem.h"

@implementation PTRReminderItem

- (BOOL)stillOverdue
{
    // NSDate > self.recurrentDueDate
    BOOL i = [[NSDate date] compare:self.recurrenceDueDate] == NSOrderedDescending;
    
    return i;
}

- (void)findNextRecurrentDueDate
{
    switch (self.recurrencePeriod) {
        case PeriodDay: {
            NSTimeInterval time = 60 * 60 * 24 * self.recurrenceAmount;
            // May tap done before dueDate, so must do at least once
            self.recurrenceDueDate = [NSDate dateWithTimeInterval:time sinceDate:self.recurrenceDueDate];
            
            while ([self stillOverdue]) {
                self.recurrenceDueDate = [NSDate dateWithTimeInterval:time sinceDate:self.recurrenceDueDate];
            }
        }
            break;
        case PeriodWeek: {
            NSTimeInterval time = 60 * 60 * 24 * 7 * self.recurrenceAmount;
            self.recurrenceDueDate = [NSDate dateWithTimeInterval:time sinceDate:self.recurrenceDueDate];
            
            while ([self stillOverdue]) {
                self.recurrenceDueDate = [NSDate dateWithTimeInterval:time sinceDate:self.recurrenceDueDate];
            }
        }
            break;
        case PeriodMonth: {
            NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            [dateComponents setMonth:self.recurrenceAmount];
            
            self.recurrenceDueDate = [calendar dateByAddingComponents:dateComponents toDate:self.recurrenceDueDate options:0];
            
            while ([self stillOverdue]) {
                self.recurrenceDueDate = [calendar dateByAddingComponents:dateComponents toDate:self.recurrenceDueDate options:0];
            }
        }
            break;
        case PeriodYear: {
            NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            [dateComponents setYear:self.recurrenceAmount];
            
            self.recurrenceDueDate = [calendar dateByAddingComponents:dateComponents toDate:self.recurrenceDueDate options:0];
            
            while ([self stillOverdue]) {
                self.recurrenceDueDate = [calendar dateByAddingComponents:dateComponents toDate:self.recurrenceDueDate options:0];
            }
        }
            break;
            
        default:
            break;
    }
    self.dueDate = self.recurrenceDueDate;
    //[self postponeDueDateByTimeInterval:time];
    //need remove recurrence?
}

- (void)postponeDueDateByTimeInterval:(NSTimeInterval)time
{
    // check time already due before implemented shifting recurrence?
    
    // Save recurrence time before postponing current dueDate for the First Time
    if (self.recurrenceDueDate == nil && self.recurrencePeriod != PeriodNone) {
        self.recurrenceDueDate = self.dueDate;
    }
    
    // If overdue, (NSDate > self.dueDate)
    if ([[NSDate date] compare:self.dueDate] == NSOrderedDescending) {
        self.dueDate = [NSDate dateWithTimeInterval:time sinceDate:[NSDate date]];
    } else {
        self.dueDate = [NSDate dateWithTimeInterval:time sinceDate:self.dueDate];
    }
}

@end
