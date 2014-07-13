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
    
    // This is repeated from AddDateVC. Consider creating PTRDateField class
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.minuteInterval = 5;
    [datePicker setDate:self.reminderItem.dueDate];
    [datePicker addTarget:self action:@selector(updateDateField:)
         forControlEvents:UIControlEventValueChanged];
    [self.dateField setInputView:datePicker];
    
    self.textField.text = self.reminderItem.itemName;
    self.dateField.text = [PTRDateFormatter formatDueDateFromDate: self.reminderItem.dueDate];
}

- (void)updateDateField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.dateField.inputView;
    self.dateField.text = [PTRDateFormatter formatDueDateFromDate:picker.date];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.reminderItem.itemName = self.textField.text;
    UIDatePicker *picker = (UIDatePicker*)self.dateField.inputView;
    self.reminderItem.dueDate = picker.date;
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

@end
