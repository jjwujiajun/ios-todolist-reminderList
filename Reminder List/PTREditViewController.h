//
//  PTREditViewController.h
//  Reminder List
//
//  Created by Wu Jiashi on 9/7/14.
//  Copyright (c) 2014 Pewteroid Rockcliffe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTRReminderItem.h"
#import "PTRDateFormatter.h"

@interface PTREditViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextField *dateField;
@property NSDate *selectedDate;
@property PTRReminderItem *reminderItem;

@end
