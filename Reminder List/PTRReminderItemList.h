//
//  PTRReminderItemList.h
//  Reminder List
//
//  Created by Wu Jiashi on 13/7/14.
//  Copyright (c) 2014 Pewteroid Rockcliffe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTRReminderItem.h"

@interface PTRReminderItemList : NSObject

@property NSMutableArray *reminderItems;
@property NSMutableArray *archivedItems;

- (BOOL)addReminder:(PTRReminderItem *)item atRow:(int)row;
- (void)removeReminderAtIndexPath:(NSIndexPath *)path;
- (void)archiveReminderItem:(PTRReminderItem *)item;
- (int)getInsertionRowOfReminderItem:(PTRReminderItem *)item;
- (PTRReminderItem *)getReminderItemByIndexPath:(NSIndexPath *)path;

@end
