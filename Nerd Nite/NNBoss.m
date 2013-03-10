//
// Created by amber on 3/8/13.
//


#import "NNBoss.h"


@implementation NNBoss

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.id = [dictionary valueForKey:@"id"];
        self.name = [dictionary valueForKey:@"name"];
        self.pic = [dictionary valueForKey:@"pic"];
        self.link = [dictionary valueForKey:@"link"];
    }
    return self;
}

@end