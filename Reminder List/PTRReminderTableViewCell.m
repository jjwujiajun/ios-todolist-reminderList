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

- (NSString*)formatHours:(int)hours{
    NSString *h = hours > 1 ? @"hours" : @"hour";
    return [NSString stringWithFormat:@"%d %@ ", hours, h];
}

- (NSString*)formatMinutes:(int)minutes{
    NSString *m = minutes > 1 ? @"minutes" : @"minute";
    return [NSString stringWithFormat:@"%d %@ ", minutes, m];
}

- (void)formatDueTimeFromDate:(NSDate *)dueDate
{
    NSTimeInterval periodTillDue = [dueDate timeIntervalSinceDate:[NSDate date]];
    NSMutableString *dueDateText = [[NSMutableString alloc]init];
    
    if (periodTillDue < 0) {
        dueDateText = [NSMutableString stringWithString:@"Overdued "];
    }
    
    if (abs(periodTillDue) < 60 * 60 * 5) {
        if (periodTillDue < 0) {
            periodTillDue *= -1;
            if (periodTillDue < 60) {
                self.dueDate.text = @"Now";
                return;
            }
        } else {
            // Make countdown timing nicer, especially in last 1 minute
            periodTillDue += 60;
        }
        
        int hours = periodTillDue / 60.0 / 60;
        int minutes = (periodTillDue - hours * 60 * 60)/60;
        
        if (hours > 0) {
            [dueDateText appendString:[self formatHours:hours]];
        }
        if (minutes > 0) {
            [dueDateText appendString:[self formatMinutes:minutes]];
        }
    } else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        if (periodTillDue < 60 * 60 * 24 * 7){
            [dateFormatter setDateFormat: @"HH:mm  —  EEEE"];
        }
        else {
            [dateFormatter setDateFormat:@"HH:mm  —  dd MMMM"];
        }
        [dueDateText appendString:[dateFormatter stringFromDate: dueDate]];
    }
    self.dueDate.text = dueDateText;
}
@end
