//
//  NNMapAnnotation.m
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

#import "NNMapAnnotation.h"

@interface NNMapAnnotation ()

@property(strong, nonatomic) NSString *customTitle;
@property(strong, nonatomic) NSString *customImage;
@property(nonatomic) CLLocationCoordinate2D customCoordinate;

@end

@implementation NNMapAnnotation

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate andTitle:(NSString *)title andImage:(NSString *)image {
    self = [super init];
    if (self) {
        self.customTitle = title;
        self.customCoordinate = coordinate;
        self.customImage = image;
    }
    return self;
}

- (NSString *)title {
    return self.customTitle;
}

- (UIImage *)image {
    return [UIImage imageNamed:self.customImage];
}

- (CLLocationCoordinate2D)coordinate {
    return self.customCoordinate;
}

@end