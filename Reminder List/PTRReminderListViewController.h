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
@property PTREditViewController *editController;
@property NSIndexPath *selectedPath;
@property NSIndexPath *previousPath;
@property NSDate *originalDate;
@property NSTimer *timer;

- (IBAction)unwindToList:(UIStoryboardSegue *)segue;
- (IBAction)doneButtonSelected:(id)sender;
- (IBAction)postponeButtonSelected:(id)sender;
- (IBAction)editButtonSelected:(id)sender;
- (IBAction)deleteButtonSelected:(id)sender;

@end
