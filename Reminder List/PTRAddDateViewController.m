//
//  PTRAddDateViewController.m
//  ReminderList
//
//  Created by Wu Jiashi on 5/7/14.
//
//

#import "PTRAddDateViewController.h"

@interface PTRAddDateViewController ()

@property (strong, nonatomic) IBOutlet UITextField *dateField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end

@implementation PTRAddDateViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.doneButton) return;
    
    if (self.selectedDate == nil) {
        NSTimeInterval minTime = 60 * 5;
        NSDate *defaultDate = [[NSDate date] dateByAddingTimeInterval:minTime];
        self.selectedDate = defaultDate;
    }
    
    self.reminderItem.creationDate = [NSDate date];
    self.reminderItem.dueDate = self.selectedDate;
    self.reminderItem.isCompleted = NO;
    self.reminderItem.isExtended = NO;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.reminderItem = [[PTRReminderItem alloc] init];
        self.selectedDate = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.minuteInterval = 5;
    [datePicker addTarget:self
                   action:@selector(updateTextField:)
         forControlEvents:UIControlEventValueChanged];
    [self.dateField setInputView:datePicker];
    
    [self.dateField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.dateField.inputView;
    self.dateField.text = [NSString stringWithFormat:@"%@", picker.date];
    self.selectedDate = picker.date;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
