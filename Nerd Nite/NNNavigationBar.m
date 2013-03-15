//
//  NNNavigationBar.m
//  Nerd Nite
//
//  Created by Amber Conville on 2/22/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import "NNNavigationBar.h"

@implementation NNNavigationBar

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self.topItem setTitle:@"nerd nite"];
        UIFont *titleBarFont = [UIFont fontWithName:@"Courier New" size:23.0f];
        NSDictionary *titleBarTextAttributes = @{UITextAttributeFont:titleBarFont, UITextAttributeTextColor: [UIColor blackColor]};

        [self setBackgroundColor:[UIColor whiteColor]];
        [self setTitleTextAttributes:titleBarTextAttributes];
        [self setTitleVerticalPositionAdjustment:4.0f forBarMetrics:UIBarMetricsDefault];
    }
    return self;
}

@end
