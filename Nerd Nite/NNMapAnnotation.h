//
// Created by amber on 8/5/13.
//


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface NNMapAnnotation : NSObject <MKAnnotation>

@property(strong, nonatomic, readonly) UIImage *image;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate andTitle:(NSString *)title andImage:(NSString *)image;

@end