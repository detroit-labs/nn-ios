//
// Created by amber on 2/22/13.
//


#import "NNCity.h"
#import "NNBoss.h"
#import "NNEvent.h"
#import "NSDictionary+NNUtilities.h"


@implementation NNCity

- (NNCity *)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = [dictionary uppercaseStringForKey:@"city"];
        self.state = [dictionary uppercaseStringForKey:@"state"];
        self.id = [dictionary nonNullStringForKey:@"id"];
    }
    return self;
}

- (id)initWithDetail:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.id = [dictionary nonNullStringForKey:@"id"];
        self.name = [dictionary uppercaseStringForKey:@"city"];
        self.state = [dictionary uppercaseStringForKey:@"state"];
        self.twitter = [dictionary nonNullStringForKey:@"twitter"];
        self.facebook = [dictionary nonNullStringForKey:@"facebook"];
        self.hashtag = [dictionary nonNullStringForKey:@"hashtag"];
        self.bannerImage = [dictionary nonNullStringForKey:@"banner_image"];
        self.about = [dictionary nonNullStringForKey:@"description"];
        self.yearEst = [dictionary nonNullStringForKey:@"year_est"];
        self.nextEvent = [[NNEvent alloc] initWithDictionary:[dictionary objectForKey:@"next_event"]];
        NSArray *rawBosses = [dictionary objectForKey:@"bosses"];
        NSMutableArray *bosses = [[NSMutableArray alloc] init];

        [rawBosses enumerateObjectsUsingBlock:^(NSDictionary *rawBoss, NSUInteger idx, BOOL *stop) {
            if (rawBoss != [NSNull null]){
                [bosses addObject:[[NNBoss alloc] initWithDictionary:rawBoss]];
            }
        }];

        self.bosses = [NSArray arrayWithArray:bosses];
        NSArray *rawPreviews = [dictionary objectForKey:@"preview_images"];
        NSMutableArray *previews = [[NSMutableArray alloc] init];

        [rawPreviews enumerateObjectsUsingBlock:^(NSDictionary *rawPreview, NSUInteger idx, BOOL *stop) {
            if (rawPreview != [NSNull null]){
                [previews addObject:[rawPreview nonNullStringForKey:@"link"]];
            }
        }];

        self.previewImages = [NSArray arrayWithArray:previews];
    }
    return self;
}

@end