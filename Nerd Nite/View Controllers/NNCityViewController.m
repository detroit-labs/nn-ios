//
//  NNCityViewController.m
//  Nerd Nite
//
//  Created by Amber Conville on 2/22/13.
//
// Copyright (c) 2014 Detroit Labs, LLC.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//


#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import "NNCityViewController.h"
#import "NNCity.h"
#import "NNBoss.h"
#import "NNEvent.h"
#import "NNPresentation.h"
#import "NNService.h"
#import "NNPastEventsViewController.h"
#import "NNBossCollectionViewCell.h"
#import "NNCityPreviewImageCollectionViewCell.h"
#import "NNPresenterImageCollectionViewCell.h"
#import "NNNextEventViewController.h"

static NSString *const bossCellIdentifier = @"NNBossCell";
static NSString *const previewImageCellIdentifier = @"NNCityPreviewImageCollectionViewCell";
static NSString *const presenterImageCellIdentifier = @"NNPresenterImageCollectionViewCell";

@interface NNCityViewController ()

@end

@implementation NNCityViewController

- (id)initWithCity:(NNCity *)city {
    self = [super initWithNibName:@"NNCityViewController" bundle:nil];
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
    [super createNavBar:@"nerd nite"];
    
    [self.navigationItem setHidesBackButton:YES];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 28.0, 28.0);
    [button setBackgroundImage:[UIImage imageNamed:@"change-Location"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeLocation) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *changeLocationButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setRightBarButtonItem:changeLocationButton];
}

-(void)viewDidLoad {
    [super viewDidLoad];

    [self.bossCollectionView registerNib:[UINib nibWithNibName:@"NNBossCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:bossCellIdentifier];
    [self.cityPreviewImages registerNib:[UINib nibWithNibName:@"NNCityPreviewImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:previewImageCellIdentifier];
    [self.presenterImages registerNib:[UINib nibWithNibName:@"NNPresenterImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:presenterImageCellIdentifier];

    [self clearPlaceholderLabels];
    
    [self.cityBorderView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.cityBorderView.layer setBorderWidth:3];
    
    [self.aboutBorderView.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.aboutBorderView.layer setBorderWidth:3];
    
    [self.service getCity:self.city.id withSuccess:^(NNCity *city) {
        self.city = city;
        [self.bossCollectionView reloadData];
        [self.cityPreviewImages reloadData];
        [self.presenterImages reloadData];
        [self loadImage:self.mainPicture forPath:self.city.bannerImage];
        self.cityLabel.text = self.city.name;
        self.eventTitle.text = self.city.nextEvent.title;
        self.eventVenueLabel.text = self.city.nextEvent.venueName;
        [self setupDateLabel];
        self.aboutLabel.text = self.city.about;
        self.yearEstablishedLabel.text = [self.city.yearEst stringValue];

        if (!self.city.nextEvent.id) {
            [self.learnMoreButton setHidden:YES];
        }
        if (!self.city.twitter) {
            [self.twitterButton setHidden:YES];
        }
        if (!self.city.facebook) {
            [self.facebookButton setHidden:YES];
        }

        [self resizeLabelForText:self.aboutLabel width:300];

        [self moveViewElement:self.meetTheBossesLabel belowViewElement:self.aboutLabel withMargin:20];
        [self moveViewElement:self.bossCollectionView belowViewElement:self.meetTheBossesLabel withMargin:10];

        NSUInteger numberOfBossRows = ([self.city.bosses count] % 3) + 1;
        int heightOfBossRow = 126;
        NSUInteger correctedBossCollectionHeight = (numberOfBossRows * heightOfBossRow) - 10;
        [self.bossCollectionView setFrame:(CGRect) {self.bossCollectionView.frame.origin,
                {self.bossCollectionView.frame.size.width, correctedBossCollectionHeight}}];
        [(UIScrollView *) self.view
                setContentSize:CGSizeMake(self.view.frame.size.width,
                        self.bossCollectionView.frame.origin.y + correctedBossCollectionHeight + 10)];
    } andFailure:^() {
        [[[UIAlertView alloc] initWithTitle:@"NOES"
                                    message:@"Couldn't get city info!!"
                                   delegate:nil cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }];
    
}

- (void)resizeLabelForText:(UILabel *)label width:(CGFloat)width {
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(width, MAXFLOAT)];
    [label setFrame:(CGRect){label.frame.origin, size}];
}

- (void)moveViewElement:(UIView *)bottom belowViewElement:(UIView *)top withMargin:(int)margin {
    float bottomY = top.frame.origin.y + top.frame.size.height + margin;
    [bottom setFrame:(CGRect) {{bottom.frame.origin.x, bottomY}, bottom.frame.size}];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO
                                             animated:animated];
    [self createNavBar];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(collectionView == self.bossCollectionView) {
        return [self.city.bosses count];
    } else if (collectionView == self.cityPreviewImages){
        return [self.city.previewImages count];
    } else if (collectionView == self.presenterImages){
        return [self.city.nextEvent.presenters count];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    if(collectionView == self.bossCollectionView) {
        NNBoss *boss = [self.city.bosses objectAtIndex:[indexPath row]];
        NNBossCollectionViewCell *bossCell = [collectionView dequeueReusableCellWithReuseIdentifier:bossCellIdentifier forIndexPath:indexPath];
        [bossCell setBoss:boss];
        cell = bossCell;
    } else if (collectionView == self.cityPreviewImages) {
        NSString *imagePath = [self.city.previewImages objectAtIndex:[indexPath row]];
        NNCityPreviewImageCollectionViewCell *imageCell = [collectionView dequeueReusableCellWithReuseIdentifier:previewImageCellIdentifier forIndexPath:indexPath];
        [imageCell setImage:imagePath];
        cell = imageCell;
    } else if (collectionView == self.presenterImages) {
        NNPresentation *presenter = [self.city.nextEvent.presenters objectAtIndex:[indexPath row]];
        NNPresenterImageCollectionViewCell *imageCell = [collectionView dequeueReusableCellWithReuseIdentifier:presenterImageCellIdentifier forIndexPath:indexPath];
        [imageCell setImage:[presenter pic]];
        cell = imageCell;
    }

    return cell;
}

- (IBAction)facebookTapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"fb://profile/%@", self.city.facebook]]];
}

- (IBAction)twitterTapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://twitter.com/%@", self.city.twitter]]];
}

- (IBAction)learnMoreTapped:(id)sender {
    NNNextEventViewController *eventVC = [[NNNextEventViewController alloc] initWithEvent:self.city.nextEvent];
    [self.navigationController pushViewController:eventVC animated:YES];
}

- (IBAction)previousEventsTapped:(id)sender {
    NNPastEventsViewController *controller = [[NNPastEventsViewController alloc] initWithCity:self.city];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)changeLocation {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    [self setMainPicture:nil];
    [self setCityBorderView:nil];
    [self setCityLabel:nil];
    [self setEventTitle:nil];
    [self setEventDateLabel:nil];
    [self setEventDateSuffixLabel:nil];
    [self setEventVenueLabel:nil];
    [self setAboutBorderView:nil];
    [self setYearEstablishedLabel:nil];
    [self setAboutLabel:nil];
    [self setPresenterImages:nil];
    [super viewDidUnload];
}
@end
