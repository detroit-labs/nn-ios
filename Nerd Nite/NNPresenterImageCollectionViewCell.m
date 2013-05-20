//
//  NNPresenterImageCollectionViewCell.m
//  Nerd Nite
//
//  Created by Amber Conville on 5/17/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import "NNPresenterImageCollectionViewCell.h"

@implementation NNPresenterImageCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setImage:(NSString *)imagePath {
    [self makeCircle:self.imageView];
    [self loadImage:self.imageView forPath:imagePath];
}

@end
