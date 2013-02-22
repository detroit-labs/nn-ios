//
// Created by amber on 2/22/13.
//


#import <Foundation/Foundation.h>


@interface NNService : NSObject

-(void)getCitiesWithSuccess:(void(^)(NSArray *))success andFailure:(void(^)(void))failure;

@end