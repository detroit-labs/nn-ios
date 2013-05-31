//
//  NNPastEventView.m
//  Nerd Nite
//
//  Created by Amber Conville on 3/22/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
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
    NNEventPicturesViewController *controller = [[NNEventPicturesViewController alloc] init];
    [controller.view setFrame:self.frame];
    [self addSubview:controller.view];
}

- (void)setEventToView:(NNEvent *)event {
    self.event = event;
    [self.eventTitleLabel setText:event.title];

    NSString *description = event.about;
    CGRect originalDescriptionFrame = self.descriptionLabel.frame;
    CGFloat descriptionWidth = originalDescriptionFrame.size.width;
    CGSize descriptionSize = [description sizeWithFont:self.descriptionLabel.font constrainedToSize:CGSizeMake(descriptionWidth, MAXFLOAT)];
    [self.descriptionLabel setFrame:(CGRect){originalDescriptionFrame.origin,{descriptionWidth, descriptionSize.height}}];

    float voteButtonY = self.descriptionLabel.frame.origin.y + self.descriptionLabel.frame.size.height + 10;
    [self.voteButton setFrame:(CGRect) {{self.voteButton.frame.origin.x, voteButtonY}, self.voteButton.frame.size}];

    float picsButtonY = self.voteButton.frame.origin.y + self.voteButton.frame.size.height + 10;
    [self.picsButton setFrame:(CGRect) {{self.picsButton.frame.origin.x, picsButtonY}, self.picsButton.frame.size}];

    float viewHeight = self.picsButton.frame.origin.y + self.picsButton.frame.size.height + 10;
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.contentSize.width, viewHeight)];

    [self.descriptionLabel setText:description];
    [self.venueLabel setText:event.venueName];
    [NNDateLabelFormatter setUpDateLabel:self.eventDateLabel andSuffixLabel:self.eventDateSuffixLabel forDate:event.date];
}

@end
