//
// Created by amber on 2/22/13.
//


#import "NNCity.h"


@implementation NNCity

- (NNCity *)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.city = [dictionary valueForKey:@"city"];
        self.state = [dictionary valueForKey:@"state"];
        self.id = [dictionary valueForKey:@"id"];
    }
    return self;
}

@end