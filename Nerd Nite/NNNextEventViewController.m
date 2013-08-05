//
//  NNNextEventViewController.m
//  Nerd Nite
//
//  Created by Amber Conville on 8/3/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "NNNextEventViewController.h"
#import "NNEvent.h"
#import "NNPresentationTableViewCell.h"
#import "NNMapAnnotation.h"

static NSString *const PresentationCellId = @"NNPresentationCell";

@interface NNNextEventViewController ()

@property (strong, nonatomic) NNEvent *event;
@property(strong, nonatomic) CLLocationManager *locationManager;
@property(nonatomic) CLLocationCoordinate2D destination;

@end

@implementation NNNextEventViewController

- (id)initWithEvent:(NNEvent *)event
{
    self = [super initWithNibName:@"NNNextEventViewController" bundle:nil];
    if (self) {
        self.event = event;
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.presentationTableView registerNib:[UINib nibWithNibName:@"NNPresentationTableViewCell" bundle:nil]
                     forCellReuseIdentifier:PresentationCellId];

    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:self.event.address completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        CLLocation *location = placemark.location;
        CLLocationCoordinate2D coordinate = location.coordinate;

        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, 0.25 * 1609.344, 0.25 * 1609.344);
        MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
        [self.mapView setRegion:adjustedRegion animated:NO];

        NNMapAnnotation *annotation = [[NNMapAnnotation alloc] initWithCoordinate:coordinate
                                                                         andTitle:self.event.venueName
                                                                         andImage:@"custom-pin"];

        [self.mapView addAnnotations:@[annotation]];

    }];

    NSUInteger numberOfPresentationRows = [self.event.presenters count];
    int heightOfPresentationRow = 311;
    NSUInteger correctedPresentationTableHeight = numberOfPresentationRows * heightOfPresentationRow;
    [self.presentationTableView setFrame:(CGRect) {self.presentationTableView.frame.origin,
            {self.presentationTableView.frame.size.width, correctedPresentationTableHeight}}];
    [(UIScrollView *) self.view
            setContentSize:CGSizeMake(self.view.frame.size.width,
                    self.presentationTableView.frame.origin.y + correctedPresentationTableHeight + 10)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super createNavBar:@"next event"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation {
    NNMapAnnotation *mapAnnotation = (NNMapAnnotation *) annotation;
    static NSString *AnnotationViewID = @"annotationViewID";

    MKAnnotationView *annotationView = [map dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:mapAnnotation reuseIdentifier:AnnotationViewID];
    }

    annotationView.centerOffset = CGPointMake(mapAnnotation.image.size.width / 6.0, -mapAnnotation.image.size.height / 2.0);
    [annotationView setImage:mapAnnotation.image];

    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    [mapView deselectAnnotation:[view annotation] animated:YES];
    self.destination = ((NNMapAnnotation *) view.annotation).coordinate;
    CLLocation *currentLocation = [self.locationManager location];
    if (currentLocation == nil) {
        [self.locationManager startUpdatingLocation];
    } else {
        [self getDirections:currentLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [self.locationManager stopUpdatingLocation];
    [self getDirections:newLocation];
}

- (void)getDirections:(CLLocation *)location {
    CLLocationCoordinate2D coordinate = [location coordinate];
    NSString *latitude = [[NSNumber numberWithDouble:coordinate.latitude] stringValue];
    NSString *longitude = [[NSNumber numberWithDouble:coordinate.longitude] stringValue];

    NSString *destinationLatitude = [[NSNumber numberWithDouble:self.destination.latitude] stringValue];
    NSString *destinationLongitude = [[NSNumber numberWithDouble:self.destination.longitude] stringValue];
    NSString *destinationString = [NSString stringWithFormat:@"%@,%@",destinationLatitude,destinationLongitude];

    NSString *maps = [NSString stringWithFormat:@"maps://?saddr=%@,%@&daddr=%@", latitude, longitude, destinationString];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:maps]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.event.presenters count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 311;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NNPresentationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PresentationCellId];
    [cell setPresentation:[self.event.presenters objectAtIndex:indexPath.row]];
    return cell;
}

- (void)viewDidUnload {
    [self.locationManager stopUpdatingLocation];
    [self setMapView:nil];
    [super viewDidUnload];
}

@end
