//
// Created by amber on 6/9/13.
//


#import <Foundation/Foundation.h>


@interface NNPhoto : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *path;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end