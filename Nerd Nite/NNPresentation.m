//
// Created by amber on 3/9/13.
//


#import "NNPresentation.h"
#import "NSDictionary+NNUtilities.h"


@implementation NNPresentation

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.id = [dictionary nonNullStringForKey:@"id"];
        self.name = [dictionary nonNullStringForKey:@"name"];
        self.bio = [dictionary nonNullStringForKey:@"bio"];
        self.blurb = [dictionary nonNullStringForKey:@"blurb"];
        self.topic = [dictionary nonNullStringForKey:@"topic"];
        self.pic = [dictionary nonNullStringForKey:@"pic"];
        self.link = [dictionary nonNullStringForKey:@"link"];
    }
    return self;
}

@end