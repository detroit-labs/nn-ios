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

- (id)initWithEvent:(NNEvent *)event;
@property (strong, nonatomic) IBOutlet UIButton *facebookButtonTapped;
@property (strong, nonatomic) IBOutlet UIButton *twitterButtonTapped;
@property (strong, nonatomic) IBOutlet UIButton *butTicketsButtonTapped;

@end
