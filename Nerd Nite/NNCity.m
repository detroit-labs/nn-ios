//
//  NNCity.m
//  Nerd Nite
//
//  Created by Amber Conville on 2/22/13.
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

#import "NNCity.h"
#import "NNBoss.h"
#import "NNEvent.h"
#import "NSDictionary+NNUtilities.h"


@implementation NNCity

- (NNCity *)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = [dictionary uppercaseStringForKey:@"city"];
        self.state = [dictionary uppercaseStringForKey:@"state"];
        self.id = [dictionary nonNullStringForKey:@"id"];
    }
    return self;
}

- (id)initWithDetail:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.id = [dictionary nonNullStringForKey:@"id"];
        self.name = [dictionary uppercaseStringForKey:@"city"];
        self.state = [dictionary uppercaseStringForKey:@"state"];
        self.twitter = [dictionary nonNullStringForKey:@"twitter"];
        self.facebook = [dictionary nonNullStringForKey:@"facebook"];
        self.hashtag = [dictionary nonNullStringForKey:@"hashtag"];
        self.bannerImage = [dictionary nonNullStringForKey:@"banner_image"];
        self.about = [dictionary nonNullStringForKey:@"description"];
        self.yearEst = [NSNumber numberWithInt:[[dictionary nonNullStringForKey:@"year_est"] intValue]];
        self.nextEvent = [[NNEvent alloc] initWithDictionary:[dictionary objectForKey:@"next_event"]];
        NSArray *rawBosses = [dictionary objectForKey:@"bosses"];
        NSMutableArray *bosses = [[NSMutableArray alloc] init];

        [rawBosses enumerateObjectsUsingBlock:^(NSDictionary *rawBoss, NSUInteger idx, BOOL *stop) {
            if (rawBoss != (id)[NSNull null]){
                [bosses addObject:[[NNBoss alloc] initWithDictionary:rawBoss]];
            }
        }];

        self.bosses = [NSArray arrayWithArray:bosses];
        NSArray *rawPreviews = [dictionary objectForKey:@"preview_images"];
        NSMutableArray *previews = [[NSMutableArray alloc] init];

        [rawPreviews enumerateObjectsUsingBlock:^(NSDictionary *rawPreview, NSUInteger idx, BOOL *stop) {
            if (rawPreview != (id)[NSNull null]){
                [previews addObject:[rawPreview nonNullStringForKey:@"link"]];
            }
        }];

        self.previewImages = [NSArray arrayWithArray:previews];
    }
    return self;
}

@end