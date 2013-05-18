//
//  NNBossCollectionViewCell.m
//  Nerd Nite
//
//  Created by Amber Conville on 5/17/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import "NNBossCollectionViewCell.h"
#import "NNBoss.h"

@implementation NNBossCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setBoss:(NNBoss *)boss {
    [self makeCircle:self.bossImageView];
    [self loadImage:self.bossImageView forPath:[boss pic]];
    self.bossNameLabel.text = [boss name];
}

@end
