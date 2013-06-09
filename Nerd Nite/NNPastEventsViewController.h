//
//  NNPastEventsViewController.h
//  Nerd Nite
//
//  Created by Amber Conville on 3/22/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNViewController.h"
#import "NNPastEventView.h"

@class NNCity;

@interface NNPastEventsViewController : NNViewController <UIScrollViewDelegate, NNPastEventDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

- (id)initWithCity: (NNCity *)city;
- (IBAction)pageChanged:(id)sender;

@end
