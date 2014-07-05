//
//  PTRReminderItem.h
//  ReminderList
//
//  Created by Wu Jiashi on 16/2/14.
//
//

#import <Foundation/Foundation.h>

@interface PTRReminderItem : NSObject

@property NSString *itemName;
@property NSDate *creationDate;
@property NSDate *dueDate;
@property BOOL isCompleted;
@property BOOL isExtended;

@end
