//
//  NNPastEventsViewController.m
//  Nerd Nite
//
//  Created by Amber Conville on 3/22/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import "NNPastEventsViewController.h"
#import "NNService.h"
#import "NNCity.h"
#import "NNPastEventView.h"

static NSString *const cellId = @"PastEventCell";

@interface NNPastEventsViewController ()

@property (strong, nonatomic) NNService *service;
@property (strong, nonatomic) NNCity *city;
@property (nonatomic, strong) NSArray *events;

@end

@implementation NNPastEventsViewController

- (id)initWithCity: (NNCity *)city {
    self = [super initWithNibName:@"NNPastEventsViewController" bundle:nil];
    if (self) {
        self.service = [[NNService alloc] init];
        self.city = city;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"NNPastEventView" bundle:nil] forCellWithReuseIdentifier:cellId];
}

-(void)createNavBar {
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
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self createNavBar];

    [self.service getPastEventsForCity:self.city withSuccess:^(NSArray *events) {
        self.events = events;
        [self.collectionView reloadData];
    } andFailure:^{
        [[[UIAlertView alloc] initWithTitle:@"oh, snap!"
                                   message:@"could not get past events."
                                  delegate:nil
                         cancelButtonTitle:@"ok"
                         otherButtonTitles:nil] show];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.events count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NNPastEventView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    [cell setEvent:[self.events objectAtIndex:indexPath.row]];
    return cell;
}

@end
