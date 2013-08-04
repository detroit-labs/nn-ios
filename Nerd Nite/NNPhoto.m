//
// Created by amber on 6/9/13.
//


#import "NNPhoto.h"


@implementation NNPhoto

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if(self) {
        self.path = [dictionary valueForKey:@"link"];
        self.title = [dictionary valueForKey:@"title"];
    }
    return self;
}

@end