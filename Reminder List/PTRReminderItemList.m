//
//  PTRReminderItemList.m
//  Reminder List
//
//  Created by Wu Jiashi on 13/7/14.
//  Copyright (c) 2014 Pewteroid Rockcliffe. All rights reserved.
//

#import "PTRReminderItemList.h"

@implementation PTRReminderItemList

- (id)init
{
    self.reminderItems = [[NSMutableArray alloc] init];
    self.archivedItems = [[NSMutableArray alloc] init];
    return [super init];
    
}

- (void)sortReminders
{
    [self.reminderItems sortUsingComparator:^NSComparisonResult(PTRReminderItem *obj1, PTRReminderItem *obj2) {
        NSDate *date1 = obj1.dueDate;
        NSDate *date2 = obj2.dueDate;
        return [date1 compare:date2];
    }];
}

- (BOOL)addReminder:(PTRReminderItem *)item
{
    if (item != nil) {
        [self.reminderItems addObject:item];
        [self sortReminders];
        return YES;
    }
    return NO;
}

- (BOOL)removeReminderAtIndexPath:(NSIndexPath *)path
{
    @try {
        [self.reminderItems removeObjectAtIndex:path.row];
        return YES;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception logged: %@", exception);
        return NO;
    }
}

- (BOOL)archiveReminderAtIndexPath:(NSIndexPath *)path
{
    PTRReminderItem *item = [self.reminderItems objectAtIndex:path.row];
    if ([self removeReminderAtIndexPath:path]) {
        // *** may be the reason why archive cannot get reminderItem. Pointer pointed reminder is deleted!*** check!
        [self.archivedItems addObject:item];
        return YES;
    }
    return NO;
}

@end
