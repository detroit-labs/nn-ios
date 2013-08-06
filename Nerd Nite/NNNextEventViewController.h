//
//  NNNextEventViewController.h
//  Nerd Nite
//
//  Created by Amber Conville on 8/3/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "NNViewController.h"

@class MKMapView;

@interface NNNextEventViewController : NNViewController <UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *presentationTableView;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventVenueLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *doorsAndCoverLabel;
@property (strong, nonatomic) IBOutlet UITableViewCell *eventHeaderCell;

- (id)initWithEvent:(NNEvent *)event;
- (IBAction)facebookButtonTapped:(id)sender;
- (IBAction)twitterButtonTapped:(id)sender;
- (IBAction)buyTicketsButtonTapped:(id)sender;

@end
