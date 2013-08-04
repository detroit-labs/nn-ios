//
//  NNPresentationTableViewCell.m
//  Nerd Nite
//
//  Created by Amber Conville on 8/4/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import "NNPresentationTableViewCell.h"
#import "NNPresentation.h"
#import "AFImageRequestOperation.h"

@implementation NNPresentationTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.presenterAndTopicLabel setText:@""];
        [self.topicImage setImage:nil];
        [self.abstractLabel setText:@""];
        [self.aboutPresenterTitleLabel setText:@""];
        [self.bioLabel setText:@""];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)setPresentation:(NNPresentation *)presentation {
    NSString *uppercasePresenter = [presentation.name uppercaseString];
    NSString *presenterAndTopic = [NSString stringWithFormat:@"/ %@ – %@", uppercasePresenter, [presentation.topic uppercaseString]];
    [self.presenterAndTopicLabel setText:presenterAndTopic];
    [self.abstractLabel setText:presentation.blurb];
    [self.aboutPresenterTitleLabel setText:[NSString stringWithFormat:@"/ ABOUT %@:", uppercasePresenter]];
    [self.bioLabel setText:presentation.bio];

    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:presentation.pic]]
                                                      success:^(UIImage *image) {
                                                          [self.topicImage setImage:image];
                                                          [self.imageSpinner stopAnimating];
                                                      }];
    [operation start];

    //resize all the shits
}

//@property (strong, nonatomic) IBOutlet UILabel *presenterAndTopicLabel;
//@property (strong, nonatomic) IBOutlet UIImageView *topicImage;
//@property (strong, nonatomic) IBOutlet UILabel *abstractLabel;
//@property (strong, nonatomic) IBOutlet UILabel *aboutPresenterTitleLabel;
//@property (strong, nonatomic) IBOutlet UILabel *bioLabel;

@end
