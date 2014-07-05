//
//  PTRReminderListViewController.h
//  ReminderList
//
//  Created by Wu Jiashi on 15/2/14.
//
//

#import <UIKit/UIKit.h>

@interface PTRReminderListViewController : UITableViewController

@property NSMutableArray *reminderItems;
@property int selectedRow;

- (IBAction)unwindToList:(UIStoryboardSegue *)segue;

@end
