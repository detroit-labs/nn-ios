//
//  NNViewController.h
//  Nerd Nite
//
//  Created by Christopher Trevarthen on 3/28/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NNCity;
@class NNEvent;
@class NNService;

@interface NNViewController : UIViewController {
    
}
@property(nonatomic, strong) NNCity *city;
@property(nonatomic, strong) NNEvent *event;
@property (strong, nonatomic) NNService *service;
@property (strong, nonatomic) IBOutlet UILabel *eventDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventDateSuffixLabel;

- (void)setupDateLabel;
- (void)createNavBar:(NSString *)title;
- (void)loadImage:(UIImageView *)imageView forPath:(NSString *)path;
- (void)makeCircle:(UIImageView *)imageView;
- (void)goBack;

@end
