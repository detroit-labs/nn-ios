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

- (IBAction)voteButtonTapped:(id)sender {
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

    [self moveViewElement:self.voteButton belowViewElement:self.descriptionLabel];
    UIButton *lastButton = self.voteButton;

    if([self.event.photos count] > 0){
        [self moveViewElement:self.picsButton belowViewElement:self.voteButton];
        lastButton = self.picsButton;
        [self.picsButton setHidden:NO];
    } else {
        [self.picsButton setHidden:YES];
    }

    float viewHeight = lastButton.frame.origin.y + lastButton.frame.size.height + 10;
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.contentSize.width, viewHeight)];
}

- (void)resizeLabel:(UILabel *)label toFitText:(NSString *)text {
    CGRect originalDescriptionFrame = label.frame;
    CGFloat descriptionWidth = originalDescriptionFrame.size.width;
    CGSize descriptionSize = [text sizeWithFont:label.font constrainedToSize:CGSizeMake(descriptionWidth, MAXFLOAT)];
    [label setFrame:(CGRect) {originalDescriptionFrame.origin, {descriptionWidth, descriptionSize.height}}];
}

- (void)moveViewElement:(UIView *)bottom belowViewElement:(UIView *)top {
    float bottomY = top.frame.origin.y + top.frame.size.height + 10;
    [bottom setFrame:(CGRect) {{bottom.frame.origin.x, bottomY}, bottom.frame.size}];
}

@end
