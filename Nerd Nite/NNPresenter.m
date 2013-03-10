//
// Created by amber on 3/9/13.
//


#import "NNPresenter.h"


@implementation NNPresenter

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.id = [dictionary valueForKey:@"id"];
        self.name = [dictionary valueForKey:@"name"];
        self.bio = [dictionary valueForKey:@"bio"];
        self.blurb = [dictionary valueForKey:@"blurb"];
        self.topic = [dictionary valueForKey:@"topic"];
        self.pic = [dictionary valueForKey:@"pic"];
        self.link = [dictionary valueForKey:@"link"];
    }
    return self;
}

@end