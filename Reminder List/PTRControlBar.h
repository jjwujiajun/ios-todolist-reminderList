//
//  PTRControlBar.h
//  ReminderList
//
//  Created by Wu Jiashi on 5/7/14.
//
//

#import <UIKit/UIKit.h>

@interface PTRControlBar : UIView

@property UITableViewController *delegateController;
@property (strong, nonatomic) IBOutlet UIButton *editButton;

- (IBAction)editButtonSelected:(id)sender;

@end
