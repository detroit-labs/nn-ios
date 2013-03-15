//
// Created by amber on 3/8/13.
//


#import "NNBoss.h"
#import "NSDictionary+NNUtilities.h"


@implementation NNBoss

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.id = [dictionary nonNullStringForKey:@"id"];
        self.name = [dictionary nonNullStringForKey:@"name"];
        self.pic = [dictionary nonNullStringForKey:@"pic"];
        self.link = [dictionary nonNullStringForKey:@"link"];
    }
    return self;
}

@end