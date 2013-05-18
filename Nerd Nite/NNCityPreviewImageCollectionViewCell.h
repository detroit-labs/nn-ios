//
//  NNCityPreviewImageCollectionViewCell.h
//  Nerd Nite
//
//  Created by Amber Conville on 5/17/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNCollectionViewCell.h"

@interface NNCityPreviewImageCollectionViewCell : NNCollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (void)setImage:(NSString *)imagePath;

@end
