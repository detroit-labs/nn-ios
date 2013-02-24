//
// Created by amber on 2/22/13.
//


#import <QuartzCore/QuartzCore.h>
#import "NNCityViewController.h"
#import "NNCity.h"

@interface NNCityViewController ()
@property(nonatomic, strong) NNCity *city;

@end

@implementation NNCityViewController

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

    [self.cityBorderView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.cityBorderView.layer setBorderWidth:3];

    [self.aboutBorderView.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.aboutBorderView.layer setBorderWidth:3];

    [self makeCircle:self.presenter1Image];
    [self makeCircle:self.presenter2Image];
    [self makeCircle:self.presenter3Image];
    [self makeCircle:self.boss1Image];
    [self makeCircle:self.boss2Image];
    [self makeCircle:self.boss3Image];

    [(UIScrollView *)self.view setContentSize:CGSizeMake(self.view.frame.size.width, self.boss3Label.frame.origin.y + self.boss3Label.frame.size.height + 20)];
}

- (void)makeCircle:(UIImageView *)imageView {
    CALayer *imageLayer = imageView.layer;
    [imageLayer setCornerRadius:imageView.frame.size.height/2];
    [imageLayer setMasksToBounds:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
}

- (IBAction)facebookTapped:(id)sender {
}

- (IBAction)twitterTapped:(id)sender {
}

- (IBAction)learnMoreTapped:(id)sender {
}

- (IBAction)previousEventsTapped:(id)sender {
}

- (IBAction)upcomingEventsTapped:(id)sender {
}

- (id)initWithCity:(NNCity *)city {
    self = [super initWithNibName:@"NNCityViewController" bundle:nil];
    if (self){
        self.city = city;
    }
    return self;
}

-(void)changeLocation {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    [self setMainPicture:nil];
    [self setCityBorderView:nil];
    [self setPresenter1Image:nil];
    [self setPresenter2Image:nil];
    [self setPresenter3Image:nil];
    [self setCityLabel:nil];
    [self setEventTitle:nil];
    [self setEventDateLabel:nil];
    [self setEventDateSuffixLabel:nil];
    [self setEventVenueLabel:nil];
    [self setCityPhoto1:nil];
    [self setCityPhoto2:nil];
    [self setCityPhoto3:nil];
    [self setCityPhoto4:nil];
    [self setAboutBorderView:nil];
    [self setYearEstablishedLabel:nil];
    [self setAboutLabel:nil];
    [self setLittleGlasses:nil];
    [self setBoss1Image:nil];
    [self setBoss2Image:nil];
    [self setBoss3Image:nil];
    [self setBoss1Label:nil];
    [self setBoss2Label:nil];
    [self setBoss3Label:nil];
    [super viewDidUnload];
}
@end