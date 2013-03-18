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
        self.name = [self shortenName:dictionary];
        self.pic = [dictionary nonNullStringForKey:@"pic"];
        self.link = [dictionary nonNullStringForKey:@"link"];
    }
    return self;
}

- (NSString *)shortenName:(NSDictionary *)dictionary {
    NSString *name = [dictionary nonNullStringForKey:@"name"];
    NSArray *words = [name componentsSeparatedByString:@" "];
    NSString *firstName = [words objectAtIndex:0];
    NSString *lastInitial = [NSString stringWithFormat:@"%@.", [[words lastObject] substringToIndex:1]];
    return [@[firstName, lastInitial] componentsJoinedByString:@" "];
}

@end