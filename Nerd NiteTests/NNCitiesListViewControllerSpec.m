//
//  NNCitiesListViewControllerSpec.m
//  Nerd Nite
//
//  Created by Amber Conville on 2/15/13.
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
#import "NNCitiesListViewController.h"
#import "NNCityTableViewCell.h"
#import "NNCity.h"
#import "NNService.h"

@interface NNCitiesListViewController ()

@property (strong, nonatomic) NSArray *cities;
@property (strong, nonatomic) NNService *service;

- (void)setupView;
- (void)loadData;

@end

SPEC_BEGIN(NNCitiesListViewControllerSpec)

describe(@"NNCitiesListViewController+", ^{

    __block NNCitiesListViewController *controller;
    __block UITableView *tableView;

    beforeEach(^{
        controller = [[NNCitiesListViewController alloc] init];
        tableView = [UITableView nullMock];
        [controller stub:@selector(tableView) andReturn:tableView];
    });

    describe(@"#numberOfSections", ^{
        it(@"has one section", ^{
            NSInteger numberOfSections = [controller numberOfSectionsInTableView:nil];

            [[theValue(numberOfSections) should] equal:theValue(1)];
        });
    });

    describe(@"#tableView:cellForRowAtIndexPath:", ^{

        context(@"makes a row for every name it has", ^{

            __block NNCityTableViewCell *expectedCell;
            __block NNCity *annArbor;
            __block NNCity *detroit;

            beforeEach(^{
                expectedCell = [NNCityTableViewCell nullMock];
                annArbor = [[NNCity alloc] initWithDictionary:@{@"name" : @"ann arbor", @"id" : @"1"}];
                detroit = [[NNCity alloc] initWithDictionary:@{@"name" : @"detroit", @"id" : @"2"}];

                [tableView stub:@selector(dequeueReusableCellWithIdentifier:) andReturn:expectedCell withArguments:NNCityCellId];
                [controller stub:@selector(cities) andReturn:@[annArbor, detroit]];
            });

            it(@"makes a cell for the first row", ^{
                UITableViewCell *cell = [controller tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

                [[cell should] equal:expectedCell];
            });

            it(@"sets the name on the first cell", ^{
                [[expectedCell should] receive:@selector(displayCity:) withArguments:annArbor];

                [controller tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            });

            it(@"sets the name on the second cell", ^{
                [[expectedCell should] receive:@selector(displayCity:) withArguments:detroit];

                [controller tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            });

        });

    });

    describe(@"#tableView:numberOfRowsInSection", ^{

        it(@"has the same number of rows as cities", ^{
            [controller stub:@selector(cities) andReturn:@[@{}, @{}]];

            NSInteger numberOfRows = [controller tableView:nil numberOfRowsInSection:0];

            [[theValue(numberOfRows) should] equal:theValue(2)];
        });

    });

    describe(@"#setupView", ^{

        __block id nib;

        beforeEach(^{
            nib = [UINib nullMock];
            [UINib stub:@selector(nibWithNibName:bundle:) andReturn:nib withArguments:@"NNCityTableViewCell", nil];
        });

        it(@"registers the name nib with the table view", ^{
            [[tableView should] receive:@selector(registerNib:forCellReuseIdentifier:) withArguments:nib, NNCityCellId];

            [controller setupView];
        });

    });

    describe(@"#loadData", ^{

        __block id service;

        beforeEach(^{
            service = [NNService nullMock];
            [controller stub:@selector(service) andReturn:service];
        });

        it(@"loads cities from the service", ^{
            [[service should] receive:@selector(getCitiesWithSuccess:andFailure:)];

            [controller loadData];
        });

        describe(@"successBlock", ^{

            __block void (^successBlock)(NSArray *);
            __block NSArray *cities;

            beforeEach(^{
                KWCaptureSpy *spy = [service captureArgument:@selector(getCitiesWithSuccess:andFailure:) atIndex:0];
                [controller loadData];
                successBlock = spy.argument;
                cities = @[[[NNCity alloc] initWithDictionary:@{@"name" : @"name", @"id" : @"3"}]];
            });

            it(@"saves the cities", ^{
                successBlock(cities);

                [[controller.cities should] equal:cities];
            });

            it(@"reloads the table view data", ^{
                [[tableView should] receive:@selector(reloadData)];

                successBlock(cities);
            });

        });

        describe(@"failureBlock", ^{

            __block void (^failureBlock)(void);

            beforeEach(^{
                KWCaptureSpy *spy = [service captureArgument:@selector(getCitiesWithSuccess:andFailure:) atIndex:1];
                [controller loadData];
                failureBlock = spy.argument;
            });

            it(@"shows an alert", ^{
                id alertView = [UIAlertView nullMock];
                [UIAlertView stub:@selector(alloc) andReturn:alertView];
                [alertView stub:@selector(initWithTitle:message:delegate:cancelButtonTitle:otherButtonTitles:)
                        andReturn:alertView
                    withArguments:@"yikes", @"we couldn't find the cities... maybe check your network connection?", nil,@"ok", nil];

                [[alertView should] receive:@selector(show)];

                failureBlock();
            });

        });

    });



});

SPEC_END
