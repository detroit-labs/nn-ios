//
//  NNNextEventViewControllerOld.m
//  Nerd Nite
//
//  Created by Christopher Trevarthen on 3/17/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import "NNNextEventViewControllerOld.h"
#import "NNCityViewController.h"
#import "NNCity.h"
#import "AFJSONRequestOperation.h"
#import "NNEvent.h"
#import "NNPresenter.h"
#import "NNService.h"

@interface NNNextEventViewControllerOld ()
@end

@implementation NNNextEventViewControllerOld

- (id)initWithCity:(NNCity *)city {
    self = [super initWithNibName:@"NNNextEventViewControllerOld" bundle:nil];
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
    self.eventVenueAddressLabel.text = nil;
}

-(void)createNavBar {
    [super createNavBar:@"next event"];
    
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
        NNEvent *nextEvent = self.city.nextEvent;
        [self loadImage:self.mainPicture forPath:self.city.bannerImage];
        [nextEvent.presenters enumerateObjectsUsingBlock:^(NNPresenter *presenter, NSUInteger idx, BOOL *stop) {
            UIImageView *image = [self.presenterImages objectAtIndex:idx];
            [self makeCircle:image];
            [self loadImage:image forPath:[presenter pic]];
            ((UILabel *) [self.presenterNames objectAtIndex:idx]).text = [presenter name];
            UILabel *topicLabel = ((UILabel *) [self.presenterTopics objectAtIndex:idx]);
            ((UILabel *) [self.presenterTopics objectAtIndex:idx]).text = [presenter topic] ? [presenter topic] : @"";
            [((UILabel *) [self.presenterTopics objectAtIndex:idx]) sizeToFit];
            CGRect topicFrame = topicLabel.frame;
            topicFrame = CGRectMake(topicFrame.origin.x, topicFrame.origin.y, 90, topicFrame.size.height);
            topicLabel.frame = topicFrame;
        }];
        
        [self.city.previewImages enumerateObjectsUsingBlock:^(NSString *imagePath, NSUInteger idx, BOOL *stop) {
            UIImageView *image = [self.cityPhotos objectAtIndex:idx];
            [self loadImage:image forPath:imagePath];
        }];
        self.cityLabel.text = self.city.name;
        self.eventTitle.text = nextEvent.title;
        self.eventVenueLabel.text = nextEvent.venueName;
        [self setupDateLabel];
        self.eventVenueAddressLabel.text = nextEvent.address;
        self.aboutLabel.text = nextEvent.about;
        [self.aboutLabel sizeToFit];
        
        CGRect glassesFrame = self.littleGlasses.frame;
        
        
        UIView *lastTopic = [self.presenterTopics objectAtIndex:[nextEvent.presenters count] - 1];
        [(UIScrollView *) self.view setContentSize:CGSizeMake(self.view.frame.size.width, lastTopic.frame.origin.y + lastTopic.frame.size.height + 20)];
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
