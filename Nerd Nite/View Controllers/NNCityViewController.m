//
// Created by amber on 2/22/13.
//


#import <QuartzCore/QuartzCore.h>
#import "NNCityViewController.h"
#import "NNCity.h"
#import "AFImageRequestOperation.h"
#import "NNBoss.h"
#import "NNEvent.h"
#import "NNPresentation.h"
#import "NNNextEventViewControllerOld.h"
#import "NNService.h"
#import "NNPastEventsViewController.h"
#import "NNBossCollectionViewCell.h"
#import "NNCityPreviewImageCollectionViewCell.h"
#import "NNPresenterImageCollectionViewCell.h"

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
    UIBarButtonItem *changeLocationButton = [[UIBarButtonItem alloc] initWithTitle:@"change" style:UIBarButtonItemStylePlain target:self action:@selector(changeLocation)];
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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.city.facebook]];
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
    [self setLittleGlasses:nil];
    [self setPresenterImages:nil];
    [super viewDidUnload];
}
@end
