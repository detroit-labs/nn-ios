//
//  NNPastEventsViewController.m
//  Nerd Nite
//
//  Created by Amber Conville on 3/22/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "NNPastEventsViewController.h"
#import "NNService.h"
#import "NNCity.h"
#import "NNPastEventView.h"
#import "NNEvent.h"

static NSString *const cellId = @"PastEventCell";

@interface NNPastEventsViewController ()

@property (nonatomic, strong) NSArray *events;

@end

@implementation NNPastEventsViewController

- (id)initWithCity: (NNCity *)city {
    self = [super initWithNibName:@"NNPastEventsViewController" bundle:nil];
    if (self) {
        self.service = [[NNService alloc] init];
        self.city = city;
    }
    return self;
}

-(void)createNavBar {
    [super createNavBar:@"past events"];
    [self.navigationItem setHidesBackButton:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self createNavBar];

    [self.service getPastEventsForCity:self.city withSuccess:^(NSArray *events) {
        self.events = events;
        self.pageControl.numberOfPages = [events count];

        __block int x = 0;
        [events enumerateObjectsUsingBlock:^(NNEvent *event, NSUInteger idx, BOOL *stop) {
            NNPastEventView *view = [[[NSBundle mainBundle] loadNibNamed:@"NNPastEventView" owner:self options:nil] objectAtIndex:0];
            [view setEventToView:event];
            [view setFrame:(CGRect){{x, 0}, {view.frame.size.width, self.scrollView.frame.size.height}}];
            x += view.frame.size.width;
            [self.scrollView addSubview:view];
        }];
        
        CGSize contentSize = self.scrollView.contentSize;
        [self.scrollView setContentSize:CGSizeMake(x, contentSize.height)];

    } andFailure:^{
        [[[UIAlertView alloc] initWithTitle:@"oh, snap!"
                                   message:@"could not get past events."
                                  delegate:nil
                         cancelButtonTitle:@"ok"
                         otherButtonTitles:nil] show];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = floor(scrollView.contentOffset.x / 275);
}

- (IBAction)pageChanged:(id)sender {
    NSInteger currentPage = [(UIPageControl *)sender currentPage];
    [self.scrollView setContentOffset:CGPointMake(currentPage * 275, 0) animated:YES];
}

@end
