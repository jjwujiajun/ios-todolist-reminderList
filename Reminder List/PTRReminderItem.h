//
//  PTRReminderItem.h
//  ReminderList
//
//  Created by Wu Jiashi on 16/2/14.
//
//

#import <Foundation/Foundation.h>

@interface PTRReminderItem : NSObject

typedef enum {
    PeriodNone,
    PeriodDay,
    PeriodWeek,
    PeriodMonth,
    PeriodYear,
} RecurrencePeriod;

@property NSString *itemName;
@property NSDate *creationDate;
@property NSDate *dueDate;
@property NSDate *recurrenceDueDate;
@property BOOL isCompleted;
@property BOOL isExtended;
@property RecurrencePeriod recurrencePeriod;
@property int recurrenceAmount;

- (void)findNextRecurrentDueDate;
- (void)postponeDueDateByTimeInterval:(NSTimeInterval)time;
- (NSComparisonResult)compare:(PTRReminderItem *)item;

@end
