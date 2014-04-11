//
// Created by amber on 6/9/13.
//


#import "NNEventPictureCell.h"
#import "AFImageRequestOperation.h"
#import "NNPhoto.h"


@interface NNEventPictureCell ()
@property (nonatomic, strong) AFImageRequestOperation *imageOperation;

@end
@implementation NNEventPictureCell

-(void)setPhoto:(NNPhoto *)photo {
    [self.photoTitleLabel setText:[NSString stringWithFormat:@"\"%@\"", photo.title]];
    if (self.imageOperation) {
        [self resetImageStuff];
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:photo.path]];
    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    self.imageOperation = [AFImageRequestOperation imageRequestOperationWithRequest:request success:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.photoView setImage:image];
            [self.loader stopAnimating];
            [self setNeedsLayout];
        });
    }];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.imageOperation start];
    });
}

- (void)resetImageStuff {
    [self.imageOperation cancel];
    self.imageOperation = nil;
    [self.photoView setImage:nil];
    [self.loader startAnimating];
    [self.loader setHidden:NO];
}

@end