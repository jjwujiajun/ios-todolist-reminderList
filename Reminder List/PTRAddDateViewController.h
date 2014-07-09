//
//  PTRAddDateViewController.h
//  ReminderList
//
//  Created by Wu Jiashi on 5/7/14.
//
//

#import <UIKit/UIKit.h>
#import "PTRReminderItem.h"
#import "PTRDateFormatter.h"

@interface PTRAddDateViewController : UIViewController

@property PTRReminderItem *reminderItem;
@property NSDate *selectedDate;

@end
