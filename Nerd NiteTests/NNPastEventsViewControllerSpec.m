//
//  NNPastEventsViewControllerSpec.m
//  Nerd Nite
//
//  Created by Amber Conville on 4/4/14.
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

#import "Kiwi.h"
#import "NNPastEventsViewController.h"
#import "NNService.h"
#import "NNEvent.h"


SPEC_BEGIN(NNPastEventsViewControllerSpec)

describe(@"NNPastEventsViewController", ^{

    __block NNPastEventsViewController *controller;

    beforeEach(^{
        controller = [[NNPastEventsViewController alloc] init];
    });

    describe(@"viewDidAppear:", ^{

        context(@"when there are no past events", ^{

            it(@"makes an alert that there are no events", ^{
                NSArray *events = @[];
                NNService *service = [NNService nullMock];
                controller.service = service;
                [service stub:@selector(getPastEventsForCity:withSuccess:andFailure:) withBlock:^id(NSArray *params) {
                    void (^successBlock)(NSArray *successEvents) = [params objectAtIndex:1];
                    successBlock(events);
                    return nil;
                }];

                UIAlertView *alertView = [UIAlertView nullMock];
                [UIAlertView stub:@selector(alloc) andReturn:alertView];

                [[alertView should] receive:@selector(initWithTitle:message:delegate:cancelButtonTitle:otherButtonTitles:) withArguments:@"oh, snap!",@"no past events!",controller,@"go back to the future",nil];

                [controller viewDidAppear:YES];
            });

            it(@"shows ^ alert", ^{
                NSArray *events = @[];
                NNService *service = [NNService nullMock];
                controller.service = service;
                [service stub:@selector(getPastEventsForCity:withSuccess:andFailure:) withBlock:^id(NSArray *params) {
                    void (^successBlock)(NSArray *successEvents) = [params objectAtIndex:1];
                    successBlock(events);
                    return nil;
                }];

                UIAlertView *alertView = [UIAlertView nullMock];
                [UIAlertView stub:@selector(alloc) andReturn:alertView];
                [alertView stub:@selector(initWithTitle:message:delegate:cancelButtonTitle:otherButtonTitles:) andReturn:alertView];

                [[alertView should] receive:@selector(show)];

                [controller viewDidAppear:YES];
            });

        });

        context(@"when there are past events", ^{

            it(@"does not make an alert", ^{
                [NSBundle stub:@selector(mainBundle)];
                NSArray *events = @[[[NNEvent alloc] init]];
                NNService *service = [NNService nullMock];
                controller.service = service;
                [service stub:@selector(getPastEventsForCity:withSuccess:andFailure:) withBlock:^id(NSArray *params) {
                    void (^successBlock)(NSArray *successEvents) = [params objectAtIndex:1];
                    successBlock(events);
                    return nil;
                }];

                [[UIAlertView shouldNot] receive:@selector(alloc)];

                [controller viewDidAppear:YES];
            });

        });

    });

});

SPEC_END
