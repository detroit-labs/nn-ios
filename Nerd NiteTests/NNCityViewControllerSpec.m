//
// Created by amber on 3/28/14.
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