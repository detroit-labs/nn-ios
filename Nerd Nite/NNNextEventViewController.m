//
//  NNNextEventViewController.m
//  Nerd Nite
//
//  Created by Christopher Trevarthen on 3/17/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import "NNNextEventViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "NNCityViewController.h"
#import "NNCity.h"
#import "AFImageRequestOperation.h"
#import "AFJSONRequestOperation.h"
#import "NNEvent.h"
#import "NNPresenter.h"
#import "NNService.h"

@interface NNNextEventViewController()
    @property(nonatomic, strong) NNCity *city;
    @property(nonatomic, strong) NNEvent *event;
@end

@implementation NNNextEventViewController

- (id)initWithCity:(NNCity *)city {
    self = [super initWithNibName:@"NNNextEventViewController" bundle:nil];
    if (self){
        self.city = city;
        self.service = [[NNService alloc] init];
    }
    return self;
}

- (void)clearPlaceholderLabels {
    self.cityLabel.text = nil;
    self.eventTitle.text = nil;
    self.eventVenueLabel.text = nil;
    self.eventDateLabel.text = nil;
    self.eventDateSuffixLabel.text = nil;
    self.aboutLabel.text = nil;
}

-(void)createNavBar {
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar.topItem setTitle:@"next event"];
    UIFont *titleBarFont = [UIFont fontWithName:@"Courier New" size:12.0f];
    NSDictionary *titleBarTextAttributes = @{UITextAttributeFont:titleBarFont, UITextAttributeTextColor: [UIColor blackColor]};
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title_bar"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:titleBarTextAttributes];
    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:6.0f forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setHidesBackButton:YES];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.navigationItem setRightBarButtonItem:backButton];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self createNavBar];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self clearPlaceholderLabels];

    [self createNavBar];
    
    [self.service getCity:self.city.id withSuccess:^(NNCity *city) {
        self.city = city;
        [self loadImage:self.mainPicture forPath:self.city.bannerImage];
        [self.city.nextEvent.presenters enumerateObjectsUsingBlock:^(NNPresenter *presenter, NSUInteger idx, BOOL *stop) {
            UIImageView *image = [self.presenterImages objectAtIndex:idx];
            [self makeCircle:image];
            [self loadImage:image forPath:[presenter pic]];
        }];
        
        [self.city.previewImages enumerateObjectsUsingBlock:^(NSString *imagePath, NSUInteger idx, BOOL *stop) {
            UIImageView *image = [self.cityPhotos objectAtIndex:idx];
            [self loadImage:image forPath:imagePath];
        }];
        self.cityLabel.text = self.city.name;
        self.eventTitle.text = self.city.nextEvent.title;
        self.eventVenueLabel.text = self.city.nextEvent.venueName;
        [self setupDateLabel];
        self.aboutLabel.text = self.city.about;
        UIView *lastPresenter = [self.presenterNames objectAtIndex:[self.city.nextEvent.presenters count] - 1];
        [(UIScrollView *) self.view setContentSize:CGSizeMake(self.view.frame.size.width, lastPresenter.frame.origin.y + lastPresenter.frame.size.height + 20)];
    } andFailure:^() {
        [[[UIAlertView alloc] initWithTitle:@"NOES"
                                    message:@"Couldn't get city info!!"
                                   delegate:nil cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)loadImage:(UIImageView *)imageView forPath:(NSString *)path {
    if(path){
        AFImageRequestOperation *imageRequestOperation = [AFImageRequestOperation
                                                          imageRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]
                                                          success:^(UIImage *image) {
                                                              [imageView setImage:image];
                                                          }];
        [imageRequestOperation start];
    }
}

- (void)makeCircle:(UIImageView *)imageView {
    CALayer *imageLayer = imageView.layer;
    [imageLayer setCornerRadius:imageView.frame.size.height/2];
    [imageLayer setMasksToBounds:YES];
}

- (void)setupDateLabel {
    NSDate *eventDate = self.city.nextEvent.date;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMMM dd"];
    NSString *dateString = [[df stringFromDate:eventDate] uppercaseString];
    self.eventDateLabel.text = dateString;
    
    CGRect dateFrame = self.eventDateLabel.frame;
    CGSize dateSize = [dateString sizeWithFont:self.eventDateLabel.font constrainedToSize:dateFrame.size];
    CGRect suffixFrame = self.eventDateSuffixLabel.frame;
    self.eventDateSuffixLabel.frame = CGRectMake(dateFrame.origin.x + dateSize.width,
                                                 suffixFrame.origin.y, suffixFrame.size.width, suffixFrame.size.height);
    
    NSDateFormatter *monthDayFormatter = [[NSDateFormatter alloc] init];
    [monthDayFormatter setDateFormat:@"d"];
    int date_day = [[monthDayFormatter stringFromDate:eventDate] intValue];
    NSArray *suffixes = @[@"st",@"nd", @"rd", @"th", @"th", @"th", @"th", @"th", @"th", @"th", @"th", @"th", @"th",
                          @"th", @"th", @"th", @"th", @"th", @"th", @"th", @"st", @"nd", @"rd", @"th", @"th", @"th", @"th", @"th",
                          @"th", @"th", @"st"];
    self.eventDateSuffixLabel.text = [[suffixes objectAtIndex:date_day - 1] uppercaseString];
}

- (IBAction)facebookTapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.city.facebook]];
}

- (IBAction)twitterTapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://twitter.com/%@", self.city.twitter]]];
}

- (IBAction)buyTicketsTapped:(id)sender {
    
}

-(void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
