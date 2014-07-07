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

@end

@implementation PTRAddReminderViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.nextButton) {
        // deallocate instead?
        self.reminderItem = nil;
        return;
    }
    
    if (self.textField.text.length > 0) {
        self.reminderItem = [[PTRReminderItem alloc] init];
        self.reminderItem.itemName = self.textField.text;
        self.reminderItem.isCompleted = NO;
        self.reminderItem.isExtended = NO;
    } else {
        // Try taking this whole portion out.
        // use - (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
        self.feedback.text = @"The reminder cannot be blank";
        return;
    }
    
    PTRAddDateViewController *destinationController = segue.destinationViewController;
    destinationController.reminderItem = self.reminderItem;
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
    [self.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
