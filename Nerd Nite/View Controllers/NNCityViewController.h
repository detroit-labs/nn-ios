//
// Created by amber on 2/22/13.
//


#import <Foundation/Foundation.h>
#import "NNViewController.h"


@class NNCity;
@class NNService;

@interface NNCityViewController : NNViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *mainPicture;
@property (strong, nonatomic) IBOutlet UIView *cityBorderView;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventTitle;
@property (strong, nonatomic) IBOutlet UILabel *eventVenueLabel;
@property (strong, nonatomic) IBOutlet UIView *aboutBorderView;
@property (strong, nonatomic) IBOutlet UILabel *yearEstablishedLabel;
@property (strong, nonatomic) IBOutlet UILabel *aboutLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *bossCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *cityPreviewImages;
@property (strong, nonatomic) IBOutlet UICollectionView *presenterImages;
@property (strong, nonatomic) IBOutlet UIButton *learnMoreButton;

@property(nonatomic, strong) NNService *service;
@property (strong, nonatomic) IBOutlet UILabel *meetTheBossesLabel;

- (IBAction)facebookTapped:(id)sender;
- (IBAction)twitterTapped:(id)sender;
- (IBAction)learnMoreTapped:(id)sender;
- (IBAction)previousEventsTapped:(id)sender;

- (id)initWithCity:(NNCity *)city;

@end