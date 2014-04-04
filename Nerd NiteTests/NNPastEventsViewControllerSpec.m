//
// Created by amber on 4/4/14.
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
