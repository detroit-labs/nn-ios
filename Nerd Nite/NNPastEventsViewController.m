//
//  NNPastEventsViewController.m
//  Nerd Nite
//
//  Created by Amber Conville on 3/22/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import "NNPastEventsViewController.h"
#import "NNService.h"
#import "NNCity.h"
#import "NNEvent.h"
#import "NNEventPicturesViewController.h"

static NSString *const cellId = @"PastEventCell";

@interface NNPastEventsViewController ()

@property (nonatomic, strong) NSArray *events;
@property (nonatomic, strong) NNEventPicturesViewController *eventPicturesViewController;

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

- (void)createNavBar {
    [super createNavBar:@"past events"];
    [self.navigationItem setHidesBackButton:NO];
}

- (void)viewDidLoad {
    self.eventPicturesViewController = [[NNEventPicturesViewController alloc] init];
    CGRect navControllerFrame = self.navigationController.view.frame;
    [self.eventPicturesViewController.view setFrame:CGRectMake(0, 20, navControllerFrame.size.width, navControllerFrame.size.height - 20)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO
                                             animated:animated];
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
            [view setDelegate:self];
            [self.scrollView addSubview:view];
        }];
        
        [self.scrollView setContentSize:CGSizeMake(x, self.scrollView.frame.size.height)];

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

- (void)viewPhotosFromEvent:(NNEvent *)event {
    [self.eventPicturesViewController setEvent:event];
    [self.navigationController.view addSubview:self.eventPicturesViewController.view];
}

@end
