//
// Created by amber on 3/9/13.
//


#import "NNEvent.h"
#import "NNPresentation.h"
#import "NSDictionary+NNUtilities.h"
#import "NNPhoto.h"


@implementation NNEvent

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.id = [dictionary nonNullStringForKey:@"id"];
        self.title = [dictionary uppercaseStringForKey:@"title"];
        self.venueName = [dictionary uppercaseStringForKey:@"venue_name"];
        self.address = [dictionary nonNullStringForKey:@"address"];
        self.about = [dictionary nonNullStringForKey:@"description"];
        self.date = [self getDate:dictionary];
        self.time = [dictionary nonNullStringForKey:@"time"];
        self.ticketsLink = [dictionary nonNullStringForKey:@"tickets_link"];
        self.price = [dictionary nonNullStringForKey:@"price"];
        self.eventLink = [dictionary nonNullStringForKey:@"event_link"];
        NSArray *rawPresenters = [dictionary objectForKey:@"presenters"];
        NSMutableArray *presenters = [[NSMutableArray alloc] init];

        [rawPresenters enumerateObjectsUsingBlock:^(NSDictionary *rawPresenter, NSUInteger idx, BOOL *stop) {
            if (rawPresenter != (id)[NSNull null]){
                NNPresentation *presenter = [[NNPresentation alloc] initWithDictionary:rawPresenter];
                [presenters addObject:presenter];
            }
        }];

        self.presenters = [NSArray arrayWithArray:presenters];

        NSArray *rawPhotos = [dictionary objectForKey:@"photos"];
        NSMutableArray *photos = [[NSMutableArray alloc] init];

        [rawPhotos enumerateObjectsUsingBlock:^(NSDictionary *rawPhoto, NSUInteger idx, BOOL *stop) {
            if (rawPhoto != (id)[NSNull null]){
                NNPhoto *photo = [[NNPhoto alloc] initWithDictionary:rawPhoto];
                [photos addObject:photo];
            }
        }];

        self.photos = [NSArray arrayWithArray:photos];
    }
    return self;
}

- (NSDate *)getDate:(NSDictionary *)dictionary {
    NSString *dateString = [dictionary valueForKey:@"date"];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    return [df dateFromString:dateString];
}

@end