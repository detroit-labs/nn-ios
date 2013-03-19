//
//  NNNextEventViewController.h
//  Nerd Nite
//
//  Created by Christopher Trevarthen on 3/17/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NNCity;
@class NNService;

@interface NNNextEventViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *mainPicture;
@property (strong, nonatomic) IBOutlet UIView *cityBorderView;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventTitle;
@property (strong, nonatomic) IBOutlet UILabel *eventDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventDateSuffixLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventVenueLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventVenueAddressLabel;
@property (strong, nonatomic) IBOutlet UIView *aboutBorderView;
@property (strong, nonatomic) IBOutlet UILabel *aboutLabel;
@property (strong, nonatomic) IBOutlet UIImageView *littleGlasses;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *presenterImages;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *presenterNames;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *cityPhotos;

@property(nonatomic, strong) NNService *service;

- (IBAction)facebookTapped:(id)sender;
- (IBAction)twitterTapped:(id)sender;
- (IBAction)buyTicketsTapped:(id)sender;

- (id)initWithCity:(NNCity *)city;

@end
