//
// Created by amber on 3/9/13.
//


#import <Foundation/Foundation.h>


@interface NNPresentation : NSObject

@property(nonatomic, strong) NSString *id;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *bio;
@property(nonatomic, strong) NSString *blurb;
@property(nonatomic, strong) NSString *topic;
@property(nonatomic, strong) NSString *pic;
@property(nonatomic, strong) NSString *link;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end