//
//  NNPastEventView.m
//  Nerd Nite
//
//  Created by Amber Conville on 3/22/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import "NNPastEventView.h"
#import "NNEvent.h"

@implementation NNPastEventView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

- (IBAction)voteButtonTapped:(id)sender {
}

- (IBAction)picsButtonTapped:(id)sender {
}

- (void)setEvent:(NNEvent *)event {
    [self.eventTitleLabel setText:event.title];
    [self.descriptionLabel setText:event.about];
    [self.venueLabel setText:event.venueName];
    [self setupDateLabel:event.date];
}

- (void)setupDateLabel: (NSDate *)eventDate {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMMM dd"];
    NSString *dateString = [[df stringFromDate:eventDate] uppercaseString];
    self.eventDateLabel.text = dateString;

    [self moveLabel:self.eventDateSuffixLabel toTheRightOf:self.eventDateLabel];

    NSDateFormatter *monthDayFormatter = [[NSDateFormatter alloc] init];
    [monthDayFormatter setDateFormat:@"d"];
    int date_day = [[monthDayFormatter stringFromDate:eventDate] intValue];
    NSArray *suffixes = @[@"st",@"nd", @"rd", @"th", @"th", @"th", @"th", @"th", @"th", @"th", @"th", @"th", @"th",
            @"th", @"th", @"th", @"th", @"th", @"th", @"th", @"st", @"nd", @"rd", @"th", @"th", @"th", @"th", @"th",
            @"th", @"th", @"st"];
    self.eventDateSuffixLabel.text = [[suffixes objectAtIndex:date_day - 1] uppercaseString];
}

- (void)moveLabel:(UILabel *)rightLabel toTheRightOf:(UILabel *)leftLabel {
    CGRect leftFrame = leftLabel.frame;
    CGSize leftLabelSize = [leftLabel.text sizeWithFont:leftLabel.font constrainedToSize:leftFrame.size];
    CGRect rightFrame = rightLabel.frame;
    rightLabel.frame = CGRectMake(leftFrame.origin.x + leftLabelSize.width,
            rightFrame.origin.y, rightFrame.size.width, rightFrame.size.height);
}

@end
