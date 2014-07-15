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

@interface PTRAddReminderViewController : UIViewController<UITextFieldDelegate>

@property PTRReminderItem *reminderItem;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *nextButton;

@end
