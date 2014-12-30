//
//  NNPastEventsViewController.m
//  Nerd Nite
//
//  Created by Amber Conville on 3/22/13.
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

#import "NNPastEventsViewController.h"
#import "NNService.h"
#import "NNCity.h"
#import "NNEvent.h"
#import "NNEventPicturesViewController.h"

static NSString * const cellId = @"PastEventCell";

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
    [super viewDidLoad];

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

        if([events count] > 0) {
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
        } else {
            [[[UIAlertView alloc] initWithTitle:@"oh, snap!"
                                       message:@"no past events!"
                                      delegate:self
                             cancelButtonTitle:@"go back to the future"
                             otherButtonTitles:nil] show];
        }


    } andFailure:^{
        [[[UIAlertView alloc] initWithTitle:@"oh, snap!"
                                   message:@"could not get past events."
                                  delegate:nil
                         cancelButtonTitle:@"ok"
                         otherButtonTitles:nil] show];
    }];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
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
