//
// Created by amber on 6/9/13.
//


#import "NNEventPictureCell.h"
#import "AFImageRequestOperation.h"
#import "NNPhoto.h"


@implementation NNEventPictureCell

-(void)setPhoto:(NNPhoto *)photo {
    [self.photoTitleLabel setText:[NSString stringWithFormat:@"\"%@\"", photo.title]];

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:photo.path]];
    AFImageRequestOperation *imageOperation = [AFImageRequestOperation imageRequestOperationWithRequest:request success:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.photoView setImage:image];
            [self.loader stopAnimating];
            [self setNeedsLayout];
        });
    }];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [imageOperation start];
    });
}

@end