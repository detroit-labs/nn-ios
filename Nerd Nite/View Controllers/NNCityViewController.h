//
// Created by amber on 2/22/13.
//


#import <Foundation/Foundation.h>

@class NNCity;


@interface NNCityViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *mainPicture;
@property (strong, nonatomic) IBOutlet UIView *cityBorderView;
@property (strong, nonatomic) IBOutlet UIImageView *presenter1Image;
@property (strong, nonatomic) IBOutlet UIImageView *presenter2Image;
@property (strong, nonatomic) IBOutlet UIImageView *presenter3Image;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventTitle;
@property (strong, nonatomic) IBOutlet UILabel *eventDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventDateSuffixLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventVenueLabel;
@property (strong, nonatomic) IBOutlet UIImageView *cityPhoto1;
@property (strong, nonatomic) IBOutlet UIImageView *cityPhoto2;
@property (strong, nonatomic) IBOutlet UIImageView *cityPhoto3;
@property (strong, nonatomic) IBOutlet UIImageView *cityPhoto4;
@property (strong, nonatomic) IBOutlet UIView *aboutBorderView;
@property (strong, nonatomic) IBOutlet UILabel *yearEstablishedLabel;
@property (strong, nonatomic) IBOutlet UILabel *aboutLabel;
@property (strong, nonatomic) IBOutlet UIImageView *littleGlasses;
@property (strong, nonatomic) IBOutlet UIImageView *boss1Image;
@property (strong, nonatomic) IBOutlet UIImageView *boss2Image;
@property (strong, nonatomic) IBOutlet UIImageView *boss3Image;
@property (strong, nonatomic) IBOutlet UILabel *boss1Label;
@property (strong, nonatomic) IBOutlet UILabel *boss2Label;
@property (strong, nonatomic) IBOutlet UILabel *boss3Label;

- (IBAction)facebookTapped:(id)sender;
- (IBAction)twitterTapped:(id)sender;
- (IBAction)learnMoreTapped:(id)sender;
- (IBAction)previousEventsTapped:(id)sender;
- (IBAction)upcomingEventsTapped:(id)sender;

- (id)initWithCity:(NNCity *)city;

@end