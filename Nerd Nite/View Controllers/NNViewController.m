//
//  NNViewController.m
//  Nerd Nite
//
//  Created by Christopher Trevarthen on 3/28/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "NNViewController.h"
#import "NNCity.h"
#import "NNEvent.h"
#import "AFImageRequestOperation.h"
#import "NNDateLabelFormatter.h"

@interface NNViewController ()
@end

@implementation NNViewController

- (void)setupDateLabel {
    NSDate *date = self.city.nextEvent.date;
    UILabel *eventDateLabel = self.eventDateLabel;
    UILabel *eventDateSuffixLabel = self.eventDateSuffixLabel;

    if(self.city.nextEvent.id) {
        [NNDateLabelFormatter setUpDateLabel:eventDateLabel andSuffixLabel:eventDateSuffixLabel forDate:date];
    }
}

-(void)createNavBar:(NSString*)title {
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar.topItem setTitle:title];
    UIFont *titleBarFont = [UIFont fontWithName:@"Courier New" size:12.0f];
    NSDictionary *titleBarTextAttributes = @{UITextAttributeFont:titleBarFont, UITextAttributeTextColor: [UIColor blackColor]};
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title_bar"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:titleBarTextAttributes];
    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:6.0f forBarMetrics:UIBarMetricsDefault];

}

- (void)loadImage:(UIImageView *)imageView forPath:(NSString *)path {
    if(path){
        AFImageRequestOperation *imageRequestOperation = [AFImageRequestOperation
                                                          imageRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]
                                                          success:^(UIImage *image) {
                                                              [imageView setImage:image];
                                                          }];
        [imageRequestOperation start];
    }
}

- (void)makeCircle:(UIImageView *)imageView {
    CALayer *imageLayer = imageView.layer;
    [imageLayer setCornerRadius:imageView.frame.size.height/2];
    [imageLayer setMasksToBounds:YES];
}

-(void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
