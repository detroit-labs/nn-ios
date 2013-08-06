//
//  NNPastEventView.h
//  Nerd Nite
//
//  Created by Amber Conville on 3/22/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NNEvent;

@protocol NNPastEventDelegate <NSObject>

- (void)viewPhotosFromEvent:(NNEvent *)event;

@end

@interface NNPastEventView : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventDateSuffixLabel;
@property (strong, nonatomic) IBOutlet UILabel *venueLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UIButton *picsButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property(nonatomic, strong) id<NNPastEventDelegate> delegate;

- (IBAction)picsButtonTapped:(id)sender;
- (void)setEventToView:(NNEvent *)event;

@end
