//
//  NNNextEventViewControllerSpec.m
//  Nerd Nite
//
//  Created by Amber Conville on 3/28/14.
//  Copyright (c) 2014 Detroit Labs. All rights reserved.
//

#import "NNNextEventViewController.h"
#import "Kiwi.h"
#import "NNEvent.h"

@interface NNNextEventViewController ()

@property (strong, nonatomic) NNEvent *event;

@end

SPEC_BEGIN(NNNextEventViewControllerSpec)
describe(@"the time format", ^{
    it(@"is in 12-hour format", ^{
        NNNextEventViewController *controller = [[NNNextEventViewController alloc]init];
        NNEvent *event = [[NNEvent alloc]init];
        event.date = [NSDate dateWithTimeIntervalSince1970:1392939000];
        event.price = @"monkeybutt";
        controller.event = event;

        UILabel *doorsAndCoverLabel = [UILabel nullMock];
        controller.doorsAndCoverLabel = doorsAndCoverLabel;
        [[doorsAndCoverLabel should] receive:@selector(setText:) withArguments:@"DOORS AT 6:30PM / $monkeybutt COVER"];


        [controller viewDidLoad];
    });
});

SPEC_END