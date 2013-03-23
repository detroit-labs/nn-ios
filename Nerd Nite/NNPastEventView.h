//
//  NNPastEventView.h
//  Nerd Nite
//
//  Created by Amber Conville on 3/22/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NNEvent;

@interface NNPastEventView : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *eventTitle;
@property (strong, nonatomic) IBOutlet UILabel *wasLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventDateSuffixLabel;
@property (strong, nonatomic) IBOutlet UILabel *venueLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

- (IBAction)voteButtonTapped:(id)sender;
- (IBAction)picsButtonTapped:(id)sender;
- (void)setEvent:(NNEvent *)event;

@end
