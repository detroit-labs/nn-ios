//
// Created by amber on 3/9/13.
//


#import <Foundation/Foundation.h>


@interface NNEvent : NSObject

@property(nonatomic, strong) NSString *id;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *venueName;
@property(nonatomic, strong) NSString *address;
@property(nonatomic, strong) NSString *about;
@property(nonatomic, strong) NSDate *date;
@property(nonatomic, strong) NSString *ticketsLink;
@property(nonatomic, strong) NSString *price;
@property(nonatomic, strong) NSString *eventLink;
@property(nonatomic, strong) NSArray *presenters;
@property(nonatomic, strong) NSArray *photos;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end