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

@property (strong, nonatomic) IBOutlet UITextField *dateField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property PTRReminderItem *reminderItem;
@property NSTimeInterval minimumTime;
@property NSDate *defaultDate;
@property NSDate *selectedDate;

@end
