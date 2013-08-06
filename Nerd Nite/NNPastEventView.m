//
//  NNPastEventView.m
//  Nerd Nite
//
//  Created by Amber Conville on 3/22/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import "NNPastEventView.h"
#import "NNEvent.h"
#import "NNEventPicturesViewController.h"
#import "NNDateLabelFormatter.h"

@interface NNPastEventView ()

@property(nonatomic, strong) NNEvent *event;

@end

@implementation NNPastEventView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    return self;
}

- (IBAction)picsButtonTapped:(id)sender {
    [self.delegate viewPhotosFromEvent:self.event];
}

- (void)setEventToView:(NNEvent *)event {
    self.event = event;

    [self.eventTitleLabel setText:event.title];
    [self.descriptionLabel setText:event.about];
    [self.venueLabel setText:event.venueName];
    [NNDateLabelFormatter setUpDateLabel:self.eventDateLabel andSuffixLabel:self.eventDateSuffixLabel forDate:event.date];

    [self resizeLabel:self.descriptionLabel toFitText:event.about];

    UIView *lastElement = self.descriptionLabel;

    if([self.event.photos count] > 0){
        [self moveViewElement:self.picsButton belowViewElement:self.descriptionLabel withMargin:10];
        lastElement = self.picsButton;
        [self.picsButton setHidden:NO];
    } else {
        [self.picsButton setHidden:YES];
    }

    float viewHeight = lastElement.frame.origin.y + lastElement.frame.size.height + 10;
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.contentSize.width, viewHeight)];
}

- (void)resizeLabel:(UILabel *)label toFitText:(NSString *)text {
    CGRect originalDescriptionFrame = label.frame;
    CGFloat descriptionWidth = originalDescriptionFrame.size.width;
    CGSize descriptionSize = [text sizeWithFont:label.font constrainedToSize:CGSizeMake(descriptionWidth, MAXFLOAT)];
    [label setFrame:(CGRect) {originalDescriptionFrame.origin, {descriptionWidth, descriptionSize.height}}];
}

- (void)moveViewElement:(UIView *)bottom belowViewElement:(UIView *)top withMargin:(int)margin {
    float bottomY = top.frame.origin.y + top.frame.size.height + margin;
    [bottom setFrame:(CGRect) {{bottom.frame.origin.x, bottomY}, bottom.frame.size}];
}

@end
