//
//  PTRReminderListViewController.m
//  ReminderList
//
//  Created by Wu Jiashi on 15/2/14.
//
//

#import "PTRReminderListViewController.h"
#import "PTRReminderTableViewCell.h"
#import "PTRReminderItem.h"
#import "PTRAddReminderViewController.h"

@interface PTRReminderListViewController ()

@end

@implementation PTRReminderListViewController

- (void)loadInitialData
{
    PTRReminderItem *item1 = [[PTRReminderItem alloc] init];
    PTRReminderItem *item2 = [[PTRReminderItem alloc] init];
    PTRReminderItem *item3 = [[PTRReminderItem alloc] init];

    item1.itemName = @"Buy milk";
    item2.itemName = @"Buy eggs";
    item3.itemName = @"Read a book";
    
    [self.reminderItems addObject:item1];
    [self.reminderItems addObject:item2];
    [self.reminderItems addObject:item3];
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    PTRAddReminderViewController *source = [segue sourceViewController];
    PTRReminderItem *item = source.reminderItem;
    
    if (item != nil) {
        [self.reminderItems addObject:item];
        // add a sorting function for reminder here later
        [self.tableView reloadData];
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.reminderItems = [[NSMutableArray alloc] init];
    _selectedRow = -1;
    
    NSLog(@"ok at reminderlistVC init");
    [self loadInitialData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.reminderItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"dd-MM-yyyy"];
    
    static NSString *CellIdentifier = @"ListPrototypeCell";
    PTRReminderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier
                                                                     forIndexPath: indexPath];
    
    PTRReminderItem *reminderItem = [self.reminderItems objectAtIndex: indexPath.row];
    
    cell.reminderName.text = reminderItem.itemName;
    cell.creationDate.text = [dateFormatter stringFromDate: reminderItem.creationDate];
    cell.accessoryType  = UITableViewCellAccessoryNone;
    
    // make visible: control bar
    if (reminderItem.isExtended) {
        [cell.controlBar setHidden: NO];
    } else {
        [cell.controlBar setHidden: YES];
    }
    
    // load checkmark
    /*if (reminderItem.isCompleted) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }*/
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTRReminderItem *tappedItem = [self.reminderItems objectAtIndex:indexPath.row];
    
    if (_selectedRow == -1) {
        _selectedRow = (int)[indexPath row];
        tappedItem.isExtended = YES;
    } else {
        _selectedRow = -1;
        tappedItem.isExtended = NO;
    }
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    [tableView beginUpdates];
    [tableView endUpdates];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    
    
    if ([indexPath row] == _selectedRow) {
        height = 85;
    }
    else {
        height = 60;
    }
    
    return height;
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
