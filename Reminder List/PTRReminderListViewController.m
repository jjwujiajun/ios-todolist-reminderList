//
//  PTRReminderListViewController.m
//  ReminderList
//
//  Created by Wu Jiashi on 15/2/14.
//
//

#import "PTRReminderListViewController.h"

@implementation PTRReminderListViewController

#pragma mark init
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.list = [[PTRReminderItemList alloc] init];
    self.selectedPath = nil;
    [self loadInitialData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.editController.dateDidChange) {
        //[self.list sortReminders];
        [self.tableView beginUpdates];
        
        [self deleteCellAtIndexPath:self.selectedPath];
        int row = [self.list getInsertionRowOfReminderItem:self.editController.reminderItem];
        NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
        [self insertReminderCell:self.editController.reminderItem atIndexPath:path];
        self.selectedPath = nil;
        
        [self.tableView endUpdates];
    } else if (self.selectedPath != nil) {
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:self.selectedPath] withRowAnimation:NO];
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval: 5
                                     target:self
                                   selector:@selector(updateDueTime)
                                   userInfo:nil
                                    repeats:YES];
    NSLog(@"%@", [self.timer description]);
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (self.timer) {
        [self.timer invalidate];
    }
}

- (void)loadInitialData
{
    PTRReminderItem *item1 = [[PTRReminderItem alloc] init];
    PTRReminderItem *item2 = [[PTRReminderItem alloc] init];
    PTRReminderItem *item3 = [[PTRReminderItem alloc] init];

    item1.itemName = @"Buy milk";
    item2.itemName = @"Buy eggs";
    item3.itemName = @"Read a book";
    
    item1.dueDate = [NSDate dateWithTimeIntervalSinceNow: -500000];
    item2.dueDate = [NSDate dateWithTimeIntervalSinceNow: 5];
    item3.dueDate = [NSDate dateWithTimeIntervalSinceNow: 300000];
    
    item1.recurrencePeriod = PeriodDay;
    item1.recurrenceAmount = 1;
    item1.recurrenceDueDate = item1.dueDate;
    
    [self.list.reminderItems addObject:item1];
    [self.list.reminderItems addObject:item2];
    [self.list.reminderItems addObject:item3];
}


- (void) updateDueTime
{
    [self.tableView reloadData];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual: @"editSegue"] ) {
        PTRReminderItem *reminderItem = [self.list.reminderItems objectAtIndex:self.selectedPath.row];
        self.editController = segue.destinationViewController;
        self.editController.reminderItem = reminderItem;
        
        self.originalDate = [NSDate dateWithTimeInterval:0 sinceDate:self.editController.reminderItem.dueDate];
    } else {
        int row = self.selectedPath.row;
        self.selectedPath = nil;
        NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:NO];
    }
    
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    PTRAddDateViewController *source = [segue sourceViewController];
    PTRReminderItem *item = source.reminderItem;
    
    int row = [self.list getInsertionRowOfReminderItem:item];
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
    
    [self insertReminderCell:item atIndexPath:path];
}

#pragma mark Buttons

- (IBAction)doneButtonSelected:(id)sender
{
    NSIndexPath *path = [self cellIndexPathByIdentifyingSender:sender];
    PTRReminderItem *item = [self.list getReminderItemByIndexPath:path];
    
    if([[self.list.reminderItems objectAtIndex:path.row] recurrencePeriod] == PeriodNone) {
        [self.list archiveReminderItem:item];
        [self deleteCellAtIndexPath:path];
    } else {
        // Object must be deleted first. Else binary searching will find it, and produce error.
        [self deleteCellAtIndexPath:path];
        
        [item findNextRecurrentDueDate];
        int row = [self.list getInsertionRowOfReminderItem:item];
        NSIndexPath *newPath = [NSIndexPath indexPathForRow:row inSection:0];
        [self insertReminderCell:item atIndexPath:newPath];
    }
}

- (IBAction)postponeButtonSelected:(id)sender
{
    NSTimeInterval time = 60 * 5;
    PTRReminderItem *item = [self.list getReminderItemByIndexPath:self.selectedPath];
    
    [self deleteCellAtIndexPath:self.selectedPath];
    [item postponeDueDateByTimeInterval:time];
    int row = [self.list getInsertionRowOfReminderItem:item];
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
    [self insertReminderCell:item atIndexPath:path];
}

- (IBAction)editButtonSelected:(id)sender
{
    [self performSegueWithIdentifier:@"editSegue" sender:sender];
}

- (IBAction)deleteButtonSelected:(id)sender
{
    [self deleteCellAtIndexPath:self.selectedPath];
    self.selectedPath = nil;
}

#pragma mark model manipulation

- (NSIndexPath *)cellIndexPathByIdentifyingSender:(id)sender
{
    UIView *view = sender;
    while (view != nil && ![view isKindOfClass:[PTRReminderTableViewCell class]]) {
        view = [view superview];
    }
    PTRReminderTableViewCell *cell = (PTRReminderTableViewCell *)view;
    return [self.tableView indexPathForCell:cell];
}

- (void)deleteCellAtIndexPath:(NSIndexPath *)path
{
    [self.tableView beginUpdates];
    [self.list removeReminderAtIndexPath:path];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:path]
                          withRowAnimation:UITableViewRowAnimationRight];
    self.selectedPath = nil;
    [self.tableView endUpdates];
}

- (void)insertReminderCell:(PTRReminderItem *)item atIndexPath:(NSIndexPath *)path
{
    if ([self.list addReminder:item atRow:path.row]) {
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:path]
                              withRowAnimation:UITableViewRowAnimationBottom];
        self.selectedPath = nil;
        [self.tableView endUpdates];
    }
}

#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.list.reminderItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    PTRReminderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier
                                                                     forIndexPath: indexPath];
    
    PTRReminderItem *reminderItem = [self.list.reminderItems objectAtIndex: indexPath.row];
    
    cell.reminderName.text = reminderItem.itemName;
    cell.dueDate.text = [PTRDateFormatter formatDueDateFromDate:reminderItem.dueDate];
    cell.doneButton.tag = indexPath.row;
    
    if (self.selectedPath == nil) {
        cell.controlBar.hidden = YES;
    } else {
        cell.controlBar.hidden = self.selectedPath.row == indexPath.row ? NO : YES;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView beginUpdates];
    
    PTRReminderTableViewCell *selectedCell = (PTRReminderTableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
    
    if (self.selectedPath == nil) {
        self.selectedPath = indexPath;
        [selectedCell showControlBar];
    } else {
        if (self.selectedPath.row == indexPath.row) {
            self.selectedPath = nil;
            [selectedCell hideControlBar];
        } else {
            self.selectedPath = indexPath;
            PTRReminderTableViewCell *previousCell = (PTRReminderTableViewCell*)[tableView cellForRowAtIndexPath:self.previousPath];
            
            [previousCell hideControlBar];
            [selectedCell showControlBar];
        }
    }
    self.previousPath = indexPath;
    
    [tableView endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedPath != nil && indexPath.row == self.selectedPath.row) {
        return 100;
    }
    else {
        return 60;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
