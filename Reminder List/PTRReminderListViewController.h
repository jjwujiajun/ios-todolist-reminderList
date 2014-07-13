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
#import "PTREditViewController.h"

@interface PTRReminderListViewController : UITableViewController

@property NSMutableArray *reminderItems;
@property int selectedRow;
@property NSIndexPath *previousPath;
@property PTREditViewController *editController;
@property NSDate *originalDate;

- (IBAction)unwindToList:(UIStoryboardSegue *)segue;
- (IBAction)deleteButtonSelected:(id)sender;
- (IBAction)editButtonSelected:(id)sender;

@end
