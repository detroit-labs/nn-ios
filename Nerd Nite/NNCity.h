//
// Created by amber on 2/22/13.
//


#import <Foundation/Foundation.h>


@interface NNCity : NSObject

@property(nonatomic, strong) id city;
@property(nonatomic, strong) id state;
@property(nonatomic, strong) id id;

- (NNCity *)initWithDictionary:(NSDictionary *)dictionary;

@end