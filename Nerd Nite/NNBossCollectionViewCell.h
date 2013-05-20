//
//  NNBossCollectionViewCell.h
//  Nerd Nite
//
//  Created by Amber Conville on 5/17/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNCollectionViewCell.h"

@class NNBoss;

@interface NNBossCollectionViewCell : NNCollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *bossImageView;
@property (strong, nonatomic) IBOutlet UILabel *bossNameLabel;

- (void)setBoss:(NNBoss *)boss;

@end
