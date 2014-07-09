//
//  PTRReminderTableViewCell.m
//  ReminderList
//
//  Created by Wu Jiashi on 5/7/14.
//
//

#import "PTRReminderTableViewCell.h"

@implementation PTRReminderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark display methods

- (void)showControlBar
{
    /*[UIView beginAnimations:@"Fade In" context:nil];
    [UIView setAnimationDelay:10];
    [UIView setAnimationDuration:10];
    */
    
    [self.controlBar setHidden:NO];
    
    //[UIView commitAnimations];
}

- (void)hideControlBar
{
    [self.controlBar setHidden:YES];
}

@end
