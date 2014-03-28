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
        context(@"get a city with no event", ^{
            it(@"hides the learnMoreButton", ^{
                NNCity *city = [[NNCity alloc] init];
                city.nextEvent = [[NNEvent alloc] init];
                NNCityViewController *controller = [[NNCityViewController alloc] init];
                NNService *service = [NNService nullMock];
                controller.service = service;
                [service stub:@selector(getCity:withSuccess:andFailure:) withBlock:^id(NSArray *params) {
                    void (^successBlock)(NNCity *successCity) = [params objectAtIndex:1];
                    successBlock(city);
                    return nil;
                }];

                UIButton *learnMoreButton = [UIButton nullMock];
                [[learnMoreButton should] receive:@selector(setHidden:) withArguments:theValue(YES)];
                controller.learnMoreButton = learnMoreButton;

                [controller viewDidLoad];
            });
        });
    });
});

SPEC_END