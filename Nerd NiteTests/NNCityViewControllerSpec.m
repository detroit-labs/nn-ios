//
//  NNCityViewControllerSpec.m
//  Nerd Nite
//
//  Created by Amber Conville on 8/5/13.
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

#import "NNCityViewController.h"
#import "Kiwi.h"
#import "NNService.h"
#import "NNCity.h"
#import "NNEvent.h"

SPEC_BEGIN(NNCityViewControllerSpec)

describe(@"NNCityViewController", ^{

    describe(@"#viewDidLoad", ^{
        __block NNCity *city;
        __block NNCityViewController *controller;

        beforeEach(^{
           city = [[NNCity alloc] init];

            controller = [[NNCityViewController alloc] init];
            NNService *service = [NNService nullMock];
            controller.service = service;
            [service stub:@selector(getCity:withSuccess:andFailure:) withBlock:^id(NSArray *params) {
                void (^successBlock)(NNCity *successCity) = [params objectAtIndex:1];
                successBlock(city);
                return nil;
            }];
        });
        context(@"get a city with no event", ^{
            it(@"hides the learnMoreButton", ^{
                city.nextEvent = [[NNEvent alloc] init];
                UIButton *learnMoreButton = [UIButton nullMock];
                controller.learnMoreButton = learnMoreButton;

                [[learnMoreButton should] receive:@selector(setHidden:) withArguments:theValue(YES)];

                [controller viewDidLoad];
            });
        });


        describe(@"the twitter button", ^{
            __block UIButton *twitterButton;

            beforeEach(^{
                twitterButton = [UIButton nullMock];
                    controller.twitterButton = twitterButton;
            });
            context(@"get a city with no twitter", ^{
                it(@"hides the twitterButton", ^{
                    [[twitterButton should] receive:@selector(setHidden:) withArguments:theValue(YES)];

                    [controller viewDidLoad];
                });
            });
            context(@"get a city with a twitter", ^{
                it(@"does not hide the twitterButton", ^{
                    city.twitter = @"Twitter.com/detroit";

                    [[twitterButton shouldNot] receive:@selector(setHidden:)];

                    [controller viewDidLoad];
                });
            });
        });
        describe(@"the facebook button", ^{
            __block UIButton *facebookButton;

            beforeEach(^{
                facebookButton = [UIButton nullMock];
                controller.facebookButton = facebookButton;
            });
            context(@"get a city with no facebook", ^{
                it(@"hides the facebookButton", ^{
                    [[facebookButton should] receive:@selector(setHidden:) withArguments:theValue(YES)];

                    [controller viewDidLoad];
                });
            });
            context(@"get a city with a facebook", ^{
                it(@"does not hide the facebookButton", ^{
                    city.facebook = @"facebook.com/poop";

                    [[facebookButton shouldNot] receive:@selector(setHidden:)];

                    [controller viewDidLoad];
                });
            });
        });
    });

});

SPEC_END