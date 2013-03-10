//
// Created by amber on 3/9/13.
//


#import "NNEvent.h"
#import "NNPresenter.h"


@implementation NNEvent

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.id = [dictionary valueForKey:@"id"];
        self.title = [dictionary valueForKey:@"title"];
        self.venueName = [dictionary valueForKey:@"venue_name"];
        self.address = [dictionary valueForKey:@"address"];
        self.about = [dictionary valueForKey:@"description"];
        self.date = [dictionary valueForKey:@"date"];
        self.ticketsLink = [dictionary valueForKey:@"tickets_link"];
        self.price = [dictionary valueForKey:@"price"];
        self.eventLink = [dictionary valueForKey:@"event_link"];
        NSArray *rawPresenters = [dictionary valueForKey:@"presenters"];
        NSMutableArray *presenters = [[NSMutableArray alloc] init];

        [rawPresenters enumerateObjectsUsingBlock:^(NSDictionary *rawPresenter, NSUInteger idx, BOOL *stop) {
            NNPresenter *presenter = [[NNPresenter alloc] initWithDictionary:rawPresenter];
            [presenters addObject:presenter];
        }];

        self.presenters = [NSArray arrayWithArray:presenters];
    }
    return self;
}

@end