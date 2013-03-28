//
//  NNNextEventViewController.m
//  Nerd Nite
//
//  Created by Christopher Trevarthen on 3/17/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import "NNNextEventViewController.h"
#import "NNCityViewController.h"
#import "NNCity.h"
#import "AFJSONRequestOperation.h"
#import "NNEvent.h"
#import "NNPresenter.h"
#import "NNService.h"

@interface NNNextEventViewController()
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
