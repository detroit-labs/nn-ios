//
// Created by amber on 2/22/13.
//


#import <Foundation/Foundation.h>

@class NNCity;

#define NNCityCellId @"NNCityCell"

@interface NNCityTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;

- (void)displayCity:(NNCity *)city;

@end