//
//  PTRAddDateViewController.m
//  ReminderList
//
//  Created by Wu Jiashi on 5/7/14.
//
//

#import "PTRAddDateViewController.h"

@implementation PTRAddDateViewController

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
    self.minimumTime = 60 * 5;
    self.defaultDate = [NSDate dateWithTimeIntervalSinceNow: self.minimumTime];
    
    self.dateField.text = [PTRDateFormatter formatDueDateFromDate:self.defaultDate];
    self.selectedDate = self.defaultDate;
    
    [self initDatePicker];
    [self.dateField becomeFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.doneButton) return;
    
    self.reminderItem.creationDate = [NSDate date];
    self.reminderItem.dueDate = self.selectedDate;
    self.reminderItem.isCompleted = NO;
    self.reminderItem.isExtended = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark dateField

- (void)initDatePicker
{
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setMinuteInterval:5];
    [datePicker setMinimumDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateDateField:) forControlEvents:UIControlEventValueChanged];
    [self.dateField setInputView:datePicker];
}

- (void)updateDateField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.dateField.inputView;
    self.dateField.text = [PTRDateFormatter formatDueDateFromDate:picker.date];
    self.selectedDate = picker.date;
}

@end
