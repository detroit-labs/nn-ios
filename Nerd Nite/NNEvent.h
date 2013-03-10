//
// Created by amber on 3/9/13.
//


#import <Foundation/Foundation.h>


@interface NNEvent : NSObject
@property(nonatomic, strong) id id;

@property(nonatomic, strong) id title;

@property(nonatomic, strong) id venueName;

@property(nonatomic, strong) id address;

@property(nonatomic, strong) id about;

@property(nonatomic, strong) id date;

@property(nonatomic, strong) id ticketsLink;

@property(nonatomic, strong) id price;

@property(nonatomic, strong) id eventLink;

@property(nonatomic, strong) NSArray *presenters;

- (id)initWithDictionary:(NSDictionary *)dictionary;
@end