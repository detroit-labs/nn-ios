//
//  NNPastEventsViewController.h
//  Nerd Nite
//
//  Created by Amber Conville on 3/22/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NNCity;

@interface NNPastEventsViewController :UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

- (id)initWithCity: (NNCity *)city;

@end
