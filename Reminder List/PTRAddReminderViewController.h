//
//  PTRAddReminderViewController.h
//  ReminderList
//
//  Created by Wu Jiashi on 15/2/14.
//
//

#import <UIKit/UIKit.h>
#import "PTRReminderItem.h"
#import "PTRAddDateViewController.h"

@interface PTRAddReminderViewController : UIViewController

@property PTRReminderItem *reminderItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *nextButton;
@property (strong, nonatomic) IBOutlet UILabel *feedback;

@end
