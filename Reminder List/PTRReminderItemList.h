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

- (void)sortReminders;
- (BOOL)addReminder:(PTRReminderItem *)item;
- (BOOL)removeReminderAtIndexPath:(NSIndexPath *)path;
- (BOOL)didArchiveReminderAtIndexPath:(NSIndexPath *)path;

@end
