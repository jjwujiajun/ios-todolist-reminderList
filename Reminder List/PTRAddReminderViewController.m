//
//  PTRAddReminderViewController.m
//  ReminderList
//
//  Created by Wu Jiashi on 15/2/14.
//
//

#import "PTRAddReminderViewController.h"

@interface PTRAddReminderViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end

@implementation PTRAddReminderViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.doneButton) return;
    
    if (self.textField.text.length > 0) {
        self.reminderItem = [[PTRReminderItem alloc] init];
        self.reminderItem.itemName = self.textField.text;
        self.reminderItem.creationDate = [NSDate date];
        self.reminderItem.isCompleted = NO;
        self.reminderItem.isExtended = NO;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
