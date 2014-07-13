//
//  PTRControlBar.m
//  ReminderList
//
//  Created by Wu Jiashi on 5/7/14.
//
//

#import "PTRControlBar.h"

@implementation PTRControlBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(IBAction)editButtonSelected:(id)sender
{
    [self.delegateController performSegueWithIdentifier:@"editSegue" sender:self.editButton];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
