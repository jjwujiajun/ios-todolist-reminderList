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
    
    self.reminderItems = [[NSMutableArray alloc] init];
    self.selectedRow = -1;
    
    [self loadInitialData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [NSTimer scheduledTimerWithTimeInterval: 1.0
                                     target:self
                                   selector:@selector(updateDueTime)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)loadInitialData
{
    PTRReminderItem *item1 = [[PTRReminderItem alloc] init];
    PTRReminderItem *item2 = [[PTRReminderItem alloc] init];
    PTRReminderItem *item3 = [[PTRReminderItem alloc] init];

    item1.itemName = @"Buy milk";
    item2.itemName = @"Buy eggs";
    item3.itemName = @"Read a book";
    
    item1.dueDate = [NSDate dateWithTimeIntervalSinceNow: 5];
    item2.dueDate = [NSDate dateWithTimeIntervalSinceNow:6000];
    item3.dueDate = [NSDate dateWithTimeIntervalSinceNow:300000];
    
    [self.reminderItems addObject:item1];
    [self.reminderItems addObject:item2];
    [self.reminderItems addObject:item3];
}

#pragma mark segue
- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    PTRAddDateViewController *source = [segue sourceViewController];
    PTRReminderItem *item = source.reminderItem;
    
    if (item != nil) {
        [self.reminderItems addObject:item];
        // add a sorting function for reminder here later
        [self.tableView reloadData];
    }
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.reminderItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListPrototypeCell";
    PTRReminderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier
                                                                     forIndexPath: indexPath];
    
    PTRReminderItem *reminderItem = [self.reminderItems objectAtIndex: indexPath.row];
    
    cell.controlBar.hidden = self.selectedRow == indexPath.row ? NO : YES;
    cell.reminderName.text = reminderItem.itemName;
    cell.dueDate.text = [PTRDateFormatter formatDueDateFromDate:reminderItem.dueDate];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView beginUpdates];
    
    PTRReminderTableViewCell *selectedCell = (PTRReminderTableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
    
    if (self.selectedRow == -1) {
        self.selectedRow = (int)[indexPath row];
        [selectedCell showControlBar];
    } else {
        if (self.selectedRow == [indexPath row]) {
            self.selectedRow = -1;
            [selectedCell hideControlBar];
        } else {
            self.selectedRow = (int) [indexPath row];
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
    if ([indexPath row] == self.selectedRow) {
        return 85;
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

#pragma mark - Table view delegate
/*
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    PTRReminderItem *tappedItem = [self.reminderItems objectAtIndex:indexPath.row];
    tappedItem.isCompleted = !tappedItem.isCompleted;
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
*/
@end
