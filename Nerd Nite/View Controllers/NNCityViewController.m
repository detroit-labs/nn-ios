//
// Created by amber on 2/22/13.
//


#import <QuartzCore/QuartzCore.h>
#import "NNCityViewController.h"
#import "NNCity.h"
#import "AFImageRequestOperation.h"
#import "NNBoss.h"
#import "AFJSONRequestOperation.h"
#import "NNEvent.h"

@interface NNCityViewController ()
@property(nonatomic, strong) NNCity *city;

@end

@implementation NNCityViewController

- (id)initWithCity:(NNCity *)city {
    self = [super initWithNibName:@"NNCityViewController" bundle:nil];
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

    NSString *path = [NSString stringWithFormat:@"http://nn-server-dev.herokuapp.com/cities/%@", self.city.id];
    AFJSONRequestOperation *cityOp = [AFJSONRequestOperation
            JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]
                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                        self.city = [[NNCity alloc] initWithDetail:JSON];
//                                        [self loadImage:self.boss1Image forPath:[[self.city.bosses objectAtIndex:0] pic]];
//                                        [self loadImage:self.boss2Image forPath:[[self.city.bosses objectAtIndex:1] pic]];
//                                        [self loadImage:self.boss3Image forPath:[[self.city.bosses objectAtIndex:2] pic]];
                                        [self loadImage:self.mainPicture forPath:self.city.bannerImage];
//                                        [self loadImage:self.presenter1Image forPath:[[self.city.nextEvent.presenters objectAtIndex:0] pic]];
//                                        [self loadImage:self.presenter2Image forPath:[[self.city.nextEvent.presenters objectAtIndex:1] pic]];
//                                        [self loadImage:self.presenter3Image forPath:[[self.city.nextEvent.presenters objectAtIndex:2] pic]];
//                                        [self loadImage:self.cityPhoto1 forPath:[self.city.previewImages objectAtIndex:0]];
//                                        [self loadImage:self.cityPhoto2 forPath:[self.city.previewImages objectAtIndex:1]];
//                                        [self loadImage:self.cityPhoto3 forPath:[self.city.previewImages objectAtIndex:2]];
//                                        [self loadImage:self.cityPhoto4 forPath:[self.city.previewImages objectAtIndex:3]];
                                        self.cityLabel.text = self.city.name;
                                        self.eventTitle.text = self.city.nextEvent.title;
                                        self.eventVenueLabel.text = self.city.nextEvent.venueName;
                                        [self setupDateLabel];
                                    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                [[[UIAlertView alloc] initWithTitle:@"NOES"
                                           message:@"Couldn't get city info!!"
                                          delegate:nil
                                 cancelButtonTitle:@"ok"
                                 otherButtonTitles:nil] show];
            }];

    [cityOp start];

    [(UIScrollView *)self.view setContentSize:CGSizeMake(self.view.frame.size.width, self.boss3Label.frame.origin.y + self.boss3Label.frame.size.height + 20)];
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