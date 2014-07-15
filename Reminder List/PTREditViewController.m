//
//  PTREditViewController.m
//  Reminder List
//
//  Created by Wu Jiashi on 9/7/14.
//  Copyright (c) 2014 Pewteroid Rockcliffe. All rights reserved.
//

#import "PTREditViewController.h"

@implementation PTREditViewController

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
    
    // if using UITextView, then have to set this, else words will go hidden beyond border
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initDatePicker];
    
    [self initRecurrenceLabelForResponding];
    [self initRecurrencePicker];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.dateDidChange = NO;
    [super viewDidAppear:animated];
    [self.textField becomeFirstResponder];
    self.textField.text = self.reminderItem.itemName;
    self.dateField.text = [PTRDateFormatter formatDueDateFromDate: self.reminderItem.dueDate];
    [self refreshRecurrenceLabelDisplay];
    self.picker.hidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.picker.hidden = YES;
    
    self.reminderItem.itemName = self.textField.text;
    UIDatePicker *picker = (UIDatePicker*)self.dateField.inputView;
    if (self.dateDidChange) {
        self.reminderItem.dueDate = picker.date;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}

#pragma mark date picker
- (void)initDatePicker
{
    // This is repeated from AddDateVC. Consider creating PTRDateField class
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setMinuteInterval:5];
    [datePicker setMinimumDate:[NSDate date]];
    [datePicker setDate:self.reminderItem.dueDate];
    [datePicker addTarget:self action:@selector(updateDateField:)
         forControlEvents:UIControlEventValueChanged];
    [self.dateField setInputView:datePicker];
}

- (void)updateDateField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.dateField.inputView;
    self.dateField.text = [PTRDateFormatter formatDueDateFromDate:picker.date];
    self.dateDidChange = YES;
}

#pragma mark recurrence selection
- (void)initRecurrenceLabelForResponding
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recurrenceLabelSelected)];
    self.recurrenceLabel.userInteractionEnabled = YES;
    [self.recurrenceLabel addGestureRecognizer:tap];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //ensure cannot do 30 months
    //change pluralising in method below
    
    self.reminderItem.recurrencePeriod = [self.picker selectedRowInComponent:1];
    
    if (self.reminderItem.recurrencePeriod == PeriodNone) {
        self.reminderItem.recurrenceAmount = 0;
        // rollback to 0?
    } else {
        self.reminderItem.recurrenceAmount = [self.picker selectedRowInComponent:0];
    }
    
    [self refreshRecurrenceLabelDisplay];
    
}

- (void)refreshRecurrenceLabelDisplay
{
    if (self.reminderItem.recurrenceAmount == 0) {
        self.recurrenceLabel.text = @"Not repeated";
        return;
    }
    
    NSMutableString *recurrenceLabel = [NSMutableString stringWithFormat:@"Repeats "];
    
    if (self.reminderItem.recurrenceAmount != 1) {
        [recurrenceLabel appendString:[NSString stringWithFormat:@"every %d ", self.reminderItem.recurrenceAmount]];
    }
    
    switch (self.reminderItem.recurrencePeriod) {
        case PeriodDay:
            [recurrenceLabel appendString:@"da"];
            break;
        case PeriodWeek:
            [recurrenceLabel appendString:@"week"];
            break;
        case PeriodMonth:
            [recurrenceLabel appendString:@"month"];
            break;
        case PeriodYear:
            [recurrenceLabel appendString:@"year"];
            break;
        default: {
            self.recurrenceLabel.text = @"Not repeated";
            return;
        }
    }
    
    if (self.reminderItem.recurrenceAmount == 1) {
        if (self.reminderItem.recurrencePeriod == PeriodDay) {
            [recurrenceLabel appendString:@"ily"];
        } else {
            [recurrenceLabel appendString:@"ly"];
        }
    } else {
        if (self.reminderItem.recurrencePeriod == PeriodDay) {
            [recurrenceLabel appendString:@"ys"];
        } else {
            [recurrenceLabel appendString:@"s"];
        }
    }
    
    self.recurrenceLabel.text = recurrenceLabel;
    self.reminderItem.recurrenceDueDate = self.reminderItem.dueDate;
}

#pragma mark recurrence picker setup

- (void)initRecurrencePicker
{
    CGRect pickerFrame = CGRectMake(self.view.frame.origin.x,
                                     self.view.frame.origin.y + 265,
                                     self.view.frame.size.width,
                                     216);
    
    self.picker = [UIPickerView new];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    self.picker.showsSelectionIndicator = YES;
    [self.picker setBackgroundColor:[UIColor lightTextColor]];
    [self.picker setFrame: pickerFrame];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:self.picker];
}

- (void)recurrenceLabelSelected
{
    if (self.textField.isFirstResponder) {
        [self.textField resignFirstResponder];
    }
    if (self.dateField.isFirstResponder) {
        [self.dateField resignFirstResponder];
    }
    [self.picker selectRow:self.reminderItem.recurrenceAmount inComponent:0 animated:YES];
    [self.picker selectRow:self.reminderItem.recurrencePeriod inComponent:1 animated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return 31;
    } else {
        return 5;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        if (row == 0) {
            return @"";
        }
        return [NSString stringWithFormat:@"%d", row];
    } else {
        NSMutableString *title = [[NSMutableString alloc] init];
        switch (row) {
            case 1:
                title = [NSMutableString stringWithString:@"day"];
                break;
            case 2:
                title = [NSMutableString stringWithString:@"week"];
                break;
            case 3:
                title = [NSMutableString stringWithString:@"month"];
                break;
            case 4:
                title = [NSMutableString stringWithString:@"year"];
                break;
            default:
                title = [NSMutableString stringWithString:@"None"];
                break;
        }
        // If period amount > 1 then plural append title
        return title;
    }
}

@end
