//
// Created by amber on 5/31/13.
//


#import "NNViewController.h"
#import "NNDateLabelFormatter.h"


@implementation NNDateLabelFormatter

+ (void)setUpDateLabel:(UILabel *)eventDateLabel andSuffixLabel:(UILabel *)eventDateSuffixLabel forDate:(NSDate *)date {
    NSDate *eventDate = date;

    eventDateLabel.text = [self getDateString:eventDate];
    eventDateSuffixLabel.text = ([self getDateSuffixForDate:eventDate]);
    [self moveLabel:eventDateSuffixLabel toTheRightOf:eventDateLabel];
}

+ (NSString *)getDateString:(NSDate *)eventDate {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMMM dd"];
    return [[df stringFromDate:eventDate] uppercaseString];
}

+ (void)moveLabel:(UILabel *)rightLabel toTheRightOf:(UILabel *)leftLabel {
    CGRect leftFrame = leftLabel.frame;
    CGSize leftLabelSize = [leftLabel.text sizeWithFont:leftLabel.font constrainedToSize:leftFrame.size];
    CGRect rightFrame = rightLabel.frame;
    rightLabel.frame = CGRectMake(leftFrame.origin.x + leftLabelSize.width,
            rightFrame.origin.y, rightFrame.size.width, rightFrame.size.height);
}

+ (NSString *)getDateSuffixForDate:(NSDate *)eventDate {
    NSDateFormatter *monthDayFormatter = [[NSDateFormatter alloc] init];
    [monthDayFormatter setDateFormat:@"d"];
    int date_day = [[monthDayFormatter stringFromDate:eventDate] intValue];
    NSArray *suffixes = @[@"st",@"nd", @"rd", @"th", @"th", @"th", @"th", @"th", @"th", @"th", @"th", @"th", @"th",
                              @"th", @"th", @"th", @"th", @"th", @"th", @"th", @"st", @"nd", @"rd", @"th", @"th", @"th", @"th", @"th",
                              @"th", @"th", @"st"];
    return [[suffixes objectAtIndex:date_day - 1] uppercaseString];
}

@end