//
// Created by amber on 2/22/13.
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
@property(nonatomic, strong) NSString *yearEst;
@property(nonatomic, strong) NNEvent *nextEvent;
@property(nonatomic, strong) NSArray *previewImages;

- (NNCity *)initWithDictionary:(NSDictionary *)dictionary;
- (id)initWithDetail:(NSDictionary *)detailDictionary;

@end