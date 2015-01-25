//
//  NNCity.h
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

#import <Foundation/Foundation.h>

@class NNEvent;


@interface NNCity : NSObject

@property(nonatomic, strong) NSString *id;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *state;
@property(nonatomic, strong) NSArray *bosses;
@property(nonatomic, strong) NSString *about;
@property(nonatomic, strong) NSString *twitter;
@property(nonatomic, strong) NSString *facebook;
@property(nonatomic, strong) NSString *hashtag;
@property(nonatomic, strong) NSString *bannerImage;
@property(nonatomic, strong) NSNumber *yearEst;
@property(nonatomic, strong) NNEvent *nextEvent;
@property(nonatomic, strong) NSArray *previewImages;

- (NNCity *)initWithDictionary:(NSDictionary *)dictionary;
- (id)initWithDetail:(NSDictionary *)detailDictionary;

@end