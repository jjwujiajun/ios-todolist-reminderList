//
//  PTRReminderListViewController.h
//  ReminderList
//
//  Created by Wu Jiashi on 15/2/14.
//
//

#import <UIKit/UIKit.h>
#import "PTRDateFormatter.h"
#import "PTRReminderListViewController.h"
#import "PTRReminderTableViewCell.h"
#import "PTRReminderItem.h"
#import "PTRAddDateViewController.h"

@interface PTRReminderListViewController : UITableViewController

@property NSMutableArray *reminderItems;
@property int selectedRow;
@property NSIndexPath *previousPath;

- (IBAction)unwindToList:(UIStoryboardSegue *)segue;

@end
