//
// Created by amber on 6/9/13.
//


#import <Foundation/Foundation.h>

@class NNPhoto;

@interface NNEventPictureCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *photoView;
@property (strong, nonatomic) IBOutlet UILabel *photoTitleLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loader;

-(void)setPhoto:(NNPhoto *)photoPath;

@end