//
//  NNEvent.h
//  Nerd Nite
//
//  Created by Amber Conville on 3/9/13.
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

#import "NNEvent.h"
#import "NNPresentation.h"
#import "NSDictionary+NNUtilities.h"
#import "NNPhoto.h"


@implementation NNEvent

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.id = [dictionary nonNullStringForKey:@"id"];
        self.title = [dictionary uppercaseStringForKey:@"title"];
        self.venueName = [dictionary uppercaseStringForKey:@"venue_name"];
        self.address = [dictionary nonNullStringForKey:@"address"];
        self.about = [dictionary nonNullStringForKey:@"description"];
        self.date = [self getDate:dictionary];
        self.ticketsLink = [dictionary nonNullStringForKey:@"tickets_link"];
        self.price = [dictionary nonNullStringForKey:@"price"];
        self.eventLink = [dictionary nonNullStringForKey:@"event_link"];
        NSArray *rawPresenters = [dictionary objectForKey:@"presenters"];
        NSMutableArray *presenters = [[NSMutableArray alloc] init];

        [rawPresenters enumerateObjectsUsingBlock:^(NSDictionary *rawPresenter, NSUInteger idx, BOOL *stop) {
            if (rawPresenter != (id)[NSNull null]){
                NNPresentation *presenter = [[NNPresentation alloc] initWithDictionary:rawPresenter];
                [presenters addObject:presenter];
            }
        }];

        self.presenters = [NSArray arrayWithArray:presenters];

        NSArray *rawPhotos = [dictionary objectForKey:@"photos"];
        NSMutableArray *photos = [[NSMutableArray alloc] init];

        [rawPhotos enumerateObjectsUsingBlock:^(NSDictionary *rawPhoto, NSUInteger idx, BOOL *stop) {
            if (rawPhoto != (id)[NSNull null]){
                NNPhoto *photo = [[NNPhoto alloc] initWithDictionary:rawPhoto];
                [photos addObject:photo];
            }
        }];

        self.photos = [NSArray arrayWithArray:photos];
    }
    return self;
}

- (NSDate *)getDate:(NSDictionary *)dictionary {
    NSTimeInterval date = [[dictionary valueForKey:@"date"]doubleValue];
    return [NSDate dateWithTimeIntervalSince1970:date];
}

@end