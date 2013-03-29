//
// Created by amber on 2/22/13.
//


#import <Foundation/Foundation.h>
#import "NNViewController.h"


@class NNCity;
@class NNService;


@interface NNCityViewController : NNViewController

@property (strong, nonatomic) IBOutlet UIImageView *mainPicture;
@property (strong, nonatomic) IBOutlet UIView *cityBorderView;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventTitle;
@property (strong, nonatomic) IBOutlet UILabel *eventVenueLabel;
@property (strong, nonatomic) IBOutlet UIView *aboutBorderView;
@property (strong, nonatomic) IBOutlet UILabel *yearEstablishedLabel;
@property (strong, nonatomic) IBOutlet UILabel *aboutLabel;
@property (strong, nonatomic) IBOutlet UIImageView *littleGlasses;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *presenterImages;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *cityPhotos;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *bossImages;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *bossLabels;

@property(nonatomic, strong) NNService *service;

- (IBAction)facebookTapped:(id)sender;
- (IBAction)twitterTapped:(id)sender;
- (IBAction)learnMoreTapped:(id)sender;
- (IBAction)previousEventsTapped:(id)sender;
- (IBAction)upcomingEventsTapped:(id)sender;

- (id)initWithCity:(NNCity *)city;

@end