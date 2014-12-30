//
//  NNPresentationTableViewCell.m
//  Nerd Nite
//
//  Created by Amber Conville on 8/4/13.
//
// Copyright (c) 2014 Detroit Labs, LLC.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
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

    [self resizeLabelForText:self.presenterAndTopicLabel width:300];
    [self resizeLabelForText:self.abstractLabel width:198];
    [self resizeLabelForText:self.aboutPresenterTitleLabel width:198];
    [self resizeLabelForText:self.bioLabel width:198];

    [self moveViewElement:self.topicImage belowViewElement:self.presenterAndTopicLabel withMargin:4];
    [self moveViewElement:self.abstractLabel belowViewElement:self.presenterAndTopicLabel withMargin:4];
    [self moveViewElement:self.aboutPresenterTitleLabel belowViewElement:self.abstractLabel withMargin:14];
    [self moveViewElement:self.bioLabel belowViewElement:self.aboutPresenterTitleLabel withMargin:1];

    CGFloat cellHeight = self.bioLabel.frame.origin.y + self.bioLabel.frame.size.height + 10;
    [self setFrame:(CGRect) {self.frame.origin, {self.frame.size.width, cellHeight}}];

    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:presentation.pic]]
                                                      success:^(UIImage *image) {
                                                          [self.topicImage setImage:image];
                                                          [self.imageSpinner stopAnimating];
                                                      }];
    [operation start];
}

- (void)resizeLabelForText:(UILabel *)label width:(CGFloat)width {
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(width, MAXFLOAT)];
    [label setFrame:(CGRect){label.frame.origin, size}];
}

- (void)moveViewElement:(UIView *)bottom belowViewElement:(UIView *)top withMargin:(int)margin {
    float bottomY = top.frame.origin.y + top.frame.size.height + margin;
    [bottom setFrame:(CGRect) {{bottom.frame.origin.x, bottomY}, bottom.frame.size}];
}

@end
