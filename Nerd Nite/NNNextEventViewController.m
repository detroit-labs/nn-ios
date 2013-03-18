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

@interface NNNextEventViewController()
    @property(nonatomic, strong) NNCity *city;
    @property(nonatomic, strong) NNEvent *event;
@end

@implementation NNNextEventViewController

- (id)initWithCity:(NNCity *)city {
    self = [super initWithNibName:@"NNNextEventViewController" bundle:nil];
    if (self){
        self.city = city;
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar.topItem setTitle:@"nerd nite"];
    UIFont *titleBarFont = [UIFont fontWithName:@"Courier New" size:12.0f];
    NSDictionary *titleBarTextAttributes = @{UITextAttributeFont:titleBarFont, UITextAttributeTextColor: [UIColor blackColor]};
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title_bar"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:titleBarTextAttributes];
    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:6.0f forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setHidesBackButton:YES];
    UIBarButtonItem *changeLocationButton = [[UIBarButtonItem alloc] initWithTitle:@"change" style:UIBarButtonItemStylePlain target:self action:@selector(changeLocation)];
    [self.navigationItem setRightBarButtonItem:changeLocationButton];
    
//    [self.cityBorderView.layer setBorderColor:[UIColor whiteColor].CGColor];
//    [self.cityBorderView.layer setBorderWidth:3];
//    
//    [self.aboutBorderView.layer setBorderColor:[UIColor blackColor].CGColor];
//    [self.aboutBorderView.layer setBorderWidth:3];
    
    NSString *path = [NSString stringWithFormat:@"http://nn-server-dev.herokuapp.com/cities/%@", self.city.id];
    AFJSONRequestOperation *cityOp = [AFJSONRequestOperation
                                      JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]
                                      success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                          self.city = [[NNCity alloc] initWithDetail:JSON];
                                          [self loadImage:self.mainPicture forPath:self.city.bannerImage];
                                          [self.city.nextEvent.presenters enumerateObjectsUsingBlock:^(NNPresenter *presenter, NSUInteger idx, BOOL *stop) {
                                              UIImageView *image = [self.presenterImages objectAtIndex:idx];
                                              [self makeCircle:image];
                                              [self loadImage:image forPath:[presenter pic]];
                                          }];
                                          
                                          self.cityLabel.text = self.city.name;
                                          self.eventTitle.text = self.city.nextEvent.title;
                                          self.eventVenueLabel.text = self.city.nextEvent.venueName;
                                          self.eventVenueAddressLabel.text = self.city.nextEvent.address;
                                          [self setupDateLabel];
                                      } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                          [[[UIAlertView alloc] initWithTitle:@"NOES"
                                                                      message:@"Couldn't get city info!!"
                                                                     delegate:nil
                                                            cancelButtonTitle:@"ok"
                                                            otherButtonTitles:nil] show];
                                      }];
    
    [cityOp start];
    UILabel *presenterLabel = [self.presenterNames objectAtIndex:0];
    [(UIScrollView *)self.view setContentSize:CGSizeMake(self.view.frame.size.width, presenterLabel.frame.origin.y + presenterLabel.frame.size.height + 20)];
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


@end
