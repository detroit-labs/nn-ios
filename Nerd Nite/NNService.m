//
//  NNService.m
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

#import "NNService.h"
#import "AFJSONRequestOperation.h"
#import "NNCity.h"
#import "NNEvent.h"


@implementation NNService

-(void)getCitiesWithSuccess:(void(^)(NSArray *))success andFailure:(void(^)(void))failure {
    NSURLRequest *request= [self getNSURLRequestForPath:@"cities"];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
       success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
           NSArray *rawCities = (NSArray *) JSON;
           NSMutableArray *cities = [[NSMutableArray alloc] init];

           [rawCities enumerateObjectsUsingBlock:^(NSDictionary *rawCity, NSUInteger idx, BOOL *stop) {
               NNCity *city = [[NNCity alloc] initWithDictionary:rawCity];
               [cities addObject:city];
           }];

           success(cities);
       }
       failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
           failure();
       }];
    [operation start];
}

- (NSURLRequest *)getNSURLRequestForPath:(NSString *)path {
    NSString *server = @"http://nn-server-dev.herokuapp.com";
    return [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", server, path]]];
}

- (void)getCity:(NSString *)id withSuccess:(void (^)(NNCity *))success andFailure:(void (^)())failure {
    NSURLRequest *request= [self getNSURLRequestForPath:[NSString stringWithFormat:@"cities/%@", id]];
    AFJSONRequestOperation *cityOp = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
         success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSDictionary *JSON) {
             NNCity *city = [[NNCity alloc] initWithDetail:JSON];
             if (success) {
                 success(city);
             }
         }
         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSDictionary *JSON) {
             if (failure) {
                 failure();
             }
         }];

    [cityOp start];
}

- (void)getPastEventsForCity:(NNCity *)city withSuccess:(void (^)(NSArray *))success andFailure:(void (^)())failure {
    NSURLRequest *request= [self getNSURLRequestForPath:[NSString stringWithFormat:@"past-events/%@", city.id]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            NSArray *rawEvents = (NSArray *) JSON;
            NSMutableArray *events = [[NSMutableArray alloc] init];

            [rawEvents enumerateObjectsUsingBlock:^(NSDictionary *rawEvent, NSUInteger idx, BOOL *stop) {
                NNEvent *event = [[NNEvent alloc] initWithDictionary:rawEvent];
                [events addObject:event];
            }];

            success(events);
        }
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            failure();
        }];
    [operation start];
}

@end