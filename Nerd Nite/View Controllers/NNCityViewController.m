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
#import "NNPresenter.h"
#import "NNNextEventViewController.h"

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

    NSString *path = [NSString stringWithFormat:@"http://nn-server-dev.herokuapp.com/cities/%@", self.city.id];
    AFJSONRequestOperation *cityOp = [AFJSONRequestOperation
            JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]
                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                        self.city = [[NNCity alloc] initWithDetail:JSON];
                                        [self.city.bosses enumerateObjectsUsingBlock:^(NNBoss *boss, NSUInteger idx, BOOL *stop) {
                                            if(idx < 3){
                                                UIImageView *image = [self.bossImages objectAtIndex:idx];
                                                [self makeCircle:image];
                                                [self loadImage:image forPath:[boss pic]];
                                            }
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
    NNNextEventViewController *eventVC = [[NNNextEventViewController alloc] initWithCity:self.city];
    [self.navigationController pushViewController:eventVC animated:YES];
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
    [self setCityLabel:nil];
    [self setEventTitle:nil];
    [self setEventDateLabel:nil];
    [self setEventDateSuffixLabel:nil];
    [self setEventVenueLabel:nil];
    [self setAboutBorderView:nil];
    [self setYearEstablishedLabel:nil];
    [self setAboutLabel:nil];
    [self setLittleGlasses:nil];
    [self setBoss1Label:nil];
    [self setBoss2Label:nil];
    [self setBoss3Label:nil];
    [self setPresenterImages:nil];
    [self setCityPhotos:nil];
    [self setBossImages:nil];
    [super viewDidUnload];
}
@end