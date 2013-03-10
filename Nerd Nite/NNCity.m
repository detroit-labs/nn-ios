//
// Created by amber on 2/22/13.
//


#import "NNCity.h"
#import "NNBoss.h"
#import "NNEvent.h"


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

- (id)initWithDetail:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.id = [dictionary valueForKey:@"id"];
        self.city = [dictionary valueForKey:@"city"];
        self.state = [dictionary valueForKey:@"state"];
        self.about = [dictionary valueForKey:@"description"];
        self.twitter = [dictionary valueForKey:@"twitter"];
        self.facebook = [dictionary valueForKey:@"facebook"];
        self.hashtag = [dictionary valueForKey:@"hashtag"];
        self.bannerImage = [dictionary valueForKey:@"banner_image"];
        self.yearEst = [dictionary valueForKey:@"year_est"];
        self.nextEvent = [[NNEvent alloc] initWithDictionary:[dictionary valueForKey:@"next_event"]];
        NSArray *rawBosses = [dictionary objectForKey:@"bosses"];
        NSMutableArray *bosses = [[NSMutableArray alloc] init];

        [rawBosses enumerateObjectsUsingBlock:^(NSDictionary *rawBoss, NSUInteger idx, BOOL *stop) {
            [bosses addObject:[[NNBoss alloc] initWithDictionary:rawBoss]];
        }];

        self.bosses = [NSArray arrayWithArray:bosses];
        NSArray *rawPreviews = [dictionary objectForKey:@"preview_images"];
        NSMutableArray *previews = [[NSMutableArray alloc] init];

        [rawPreviews enumerateObjectsUsingBlock:^(NSDictionary *rawPreview, NSUInteger idx, BOOL *stop) {
            [previews addObject:[rawPreview valueForKey:@"link"]];
        }];

        self.previewImages = [NSArray arrayWithArray:previews];
    }
    return self;
}
@end