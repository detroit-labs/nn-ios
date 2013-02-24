//
// Created by amber on 2/22/13.
//


#import "NNCityTableViewCell.h"
#import "NNCity.h"

@interface NNCityTableViewCell ()

@property(nonatomic, strong) NNCity *city;

@end

@implementation NNCityTableViewCell

- (void)displayCity:(NNCity *)city {
    self.city = city;

    [self.cityLabel setText:[city.city uppercaseString]];
    [self.stateLabel setText:[city.state uppercaseString]];
}

@end