//
//  NNPresentationTableViewCell.h
//  Nerd Nite
//
//  Created by Amber Conville on 8/4/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NNPresentation;

@interface NNPresentationTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *presenterAndTopicLabel;
@property (strong, nonatomic) IBOutlet UIImageView *topicImage;
@property (strong, nonatomic) IBOutlet UILabel *abstractLabel;
@property (strong, nonatomic) IBOutlet UILabel *aboutPresenterTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *bioLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *imageSpinner;

-(void)setPresentation:(NNPresentation *)presentation;

@end
