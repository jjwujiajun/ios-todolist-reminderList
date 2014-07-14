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
    
    // Note to self: please do binary search insert "sort" next time. Find a way.
    [self.reminderItems sortUsingComparator:^NSComparisonResult(PTRReminderItem *obj1, PTRReminderItem *obj2) {
        NSDate *date1 = obj1.dueDate;
        NSDate *date2 = obj2.dueDate;
        return [date1 compare:date2];
    }];
}

- (BOOL)addReminder:(PTRReminderItem *)item atRow:(int)row
{
    if (item != nil) {
        [self.reminderItems insertObject:item atIndex:row];
        return YES;
    }
    return NO;
}

- (void)removeReminderAtIndexPath:(NSIndexPath *)path
{
    [self.reminderItems removeObjectAtIndex:path.row];
}

- (PTRReminderItem *)getReminderItemByIndexPath:(NSIndexPath *)path
{
    return [self.reminderItems objectAtIndex:path.row];
}

- (int)getInsertionRowOfReminderItem:(PTRReminderItem *)item
{
    int i = [self.reminderItems indexOfObject:item
                               inSortedRange:NSMakeRange(0, self.reminderItems.count)
                                     options:NSBinarySearchingInsertionIndex
                             usingComparator:^NSComparisonResult(PTRReminderItem *obj1, PTRReminderItem *obj2) {
                                 return [obj1 compare:obj2];
                             }];
    NSLog(@"func i: %d", i);
    return i;
}

- (void)archiveReminderItem:(PTRReminderItem *)item
{
    [self.archivedItems addObject:item];
}

@end
