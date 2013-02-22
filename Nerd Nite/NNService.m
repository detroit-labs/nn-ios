//
// Created by amber on 2/22/13.
//


#import "NNService.h"
#import "AFJSONRequestOperation.h"
#import "NNCity.h"


@implementation NNService

-(void)getCitiesWithSuccess:(void(^)(NSArray *))success andFailure:(void(^)(void))failure {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://nn-server-dev.herokuapp.com/cities"]];
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

@end