//
//  PTRReminderTableViewCell.h
//  ReminderList
//
//  Created by Wu Jiashi on 5/7/14.
//
//

#import <UIKit/UIKit.h>
#import "PTRControlBar.h"

@interface PTRReminderTableViewCell : UITableViewCell

@property (strong, nonatomic)IBOutlet UILabel *reminderName;
@property (strong, nonatomic) IBOutlet UILabel *dueDate;
@property (strong, nonatomic) IBOutlet PTRControlBar *controlBar;

-(void)showControlBar;
-(void)hideControlBar;

@end
