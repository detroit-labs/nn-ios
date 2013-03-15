//
// Created by amber on 3/10/13.
//


#import "NSDictionary+NNUtilities.h"


@implementation NSDictionary (NNUtilities)

- (NSString *)nonNullStringForKey:(NSString *)key {
    NSString *value = [self valueForKey:key];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}


- (NSString *)uppercaseStringForKey:(NSString *)key {
    return [[self nonNullStringForKey:key] uppercaseString];
}

@end