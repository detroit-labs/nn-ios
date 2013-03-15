//
// Created by amber on 3/8/13.
//


#import <Foundation/Foundation.h>


@interface NNBoss : NSObject

@property(nonatomic, strong) NSString *pic;
@property(nonatomic, strong) id id;
@property(nonatomic, strong) id name;
@property(nonatomic, strong) id link;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end