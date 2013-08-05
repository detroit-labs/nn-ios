//
// Created by amber on 8/5/13.
//


#import "NNMapAnnotation.h"

@interface NNMapAnnotation ()

@property(strong, nonatomic) NSString *customTitle;
@property(strong, nonatomic) NSString *customImage;
@property(nonatomic) CLLocationCoordinate2D customCoordinate;

@end

@implementation NNMapAnnotation

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate andTitle:(NSString *)title andImage:(NSString *)image {
    self = [super init];
    if (self) {
        self.customTitle = title;
        self.customCoordinate = coordinate;
        self.customImage = image;
    }
    return self;
}

- (NSString *)title {
    return self.customTitle;
}

- (UIImage *)image {
    return [UIImage imageNamed:self.customImage];
}

- (CLLocationCoordinate2D)coordinate {
    return self.customCoordinate;
}

@end