//
//  PTRReminderListViewController.h
//  ReminderList
//
//  Created by Wu Jiashi on 15/2/14.
//
//

#import <UIKit/UIKit.h>
#import "PTRAddDateViewController.h"
#import "PTREditViewController.h"
#import "PTRReminderItemList.h"
#import "PTRReminderTableViewCell.h"
#import "PTRDateFormatter.h"

@interface PTRReminderListViewController : UITableViewController

@property PTRReminderItemList *list;
@property NSIndexPath *selectedPath;
@property NSIndexPath *previousPath;
@property PTREditViewController *editController;
@property NSDate *originalDate;

- (IBAction)unwindToList:(UIStoryboardSegue *)segue;
- (IBAction)deleteButtonSelected:(id)sender;
- (IBAction)editButtonSelected:(id)sender;
- (IBAction)doneButtonSelected:(id)sender;
- (IBAction)postponeButtonSelected:(id)sender;

@end
