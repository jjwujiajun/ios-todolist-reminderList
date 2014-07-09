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
    }
    
    PTRAddDateViewController *destinationController = segue.destinationViewController;
    destinationController.reminderItem = self.reminderItem;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger length = self.textField.text.length - range.length + string.length;
    if (length > 0) {
        self.nextButton.enabled = YES;
    } else {
        self.nextButton.enabled = NO;
    }
    return YES;
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
    self.nextButton.enabled = NO;
    self.textField.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
