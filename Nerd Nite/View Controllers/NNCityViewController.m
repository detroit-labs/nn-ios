//
// Created by amber on 2/22/13.
//


#import <QuartzCore/QuartzCore.h>
#import "NNCityViewController.h"
#import "NNCity.h"
#import "AFImageRequestOperation.h"
#import "NNBoss.h"
#import "NNEvent.h"
#import "NNPresenter.h"
#import "NNNextEventViewController.h"
#import "NNService.h"
#import "NNPastEventsViewController.h"

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
    UIBarButtonItem *changeLocationButton = [[UIBarButtonItem alloc] initWithTitle:@"change" style:UIBarButtonItemStylePlain target:self action:@selector(changeLocation)];
    [self.navigationItem setRightBarButtonItem:changeLocationButton];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self clearPlaceholderLabels];
    
    [self createNavBar];
    
    [self.cityBorderView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.cityBorderView.layer setBorderWidth:3];
    
    [self.aboutBorderView.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.aboutBorderView.layer setBorderWidth:3];
    
    [self.service getCity:self.city.id withSuccess:^(NNCity *city) {
        self.city = city;
        [self.city.bosses enumerateObjectsUsingBlock:^(NNBoss *boss, NSUInteger idx, BOOL *stop) {
            UIImageView *image = [self.bossImages objectAtIndex:idx];
            [self makeCircle:image];
            [self loadImage:image forPath:[boss pic]];
            ((UILabel *) [self.bossLabels objectAtIndex:idx]).text = [boss name];
        }];
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
        self.yearEstablishedLabel.text = [self.city.yearEst stringValue];
        UIView *lastBoss = [self.bossLabels objectAtIndex:[self.city.bosses count] - 1];
        [(UIScrollView *) self.view setContentSize:CGSizeMake(self.view.frame.size.width, lastBoss.frame.origin.y + lastBoss.frame.size.height + 20)];
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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self createNavBar];
}

- (IBAction)facebookTapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.city.facebook]];
}

- (IBAction)twitterTapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://twitter.com/%@", self.city.twitter]]];
}

- (IBAction)learnMoreTapped:(id)sender {
    NNNextEventViewController *eventVC = [[NNNextEventViewController alloc] initWithCity:self.city];
    [self.navigationController pushViewController:eventVC animated:YES];
}

- (IBAction)previousEventsTapped:(id)sender {
    NNPastEventsViewController *controller = [[NNPastEventsViewController alloc] initWithCity:self.city];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)upcomingEventsTapped:(id)sender {
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
    [self setLittleGlasses:nil];
    [self setPresenterImages:nil];
    [self setCityPhotos:nil];
    [self setBossImages:nil];
    [super viewDidUnload];
}
@end