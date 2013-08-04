//
// Created by amber on 2/22/13.
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