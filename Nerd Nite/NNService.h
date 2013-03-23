//
// Created by amber on 2/22/13.
//


#import <Foundation/Foundation.h>

@class NNCity;

@interface NNService : NSObject

-(void)getCitiesWithSuccess:(void(^)(NSArray *))success andFailure:(void(^)(void))failure;
- (void)getCity:(NSString *)id withSuccess:(void (^)(NNCity *))success andFailure:(void (^)())failure;
- (void)getPastEventsForCity:(NNCity *)city withSuccess:(void (^)(NSArray *))success andFailure:(void (^)())failure;

@end