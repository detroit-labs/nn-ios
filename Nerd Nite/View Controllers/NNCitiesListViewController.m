//
//  NNCitiesListViewController+.m
//  Nerd Nite
//
//  Created by Amber Conville on 2/15/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import "NNCitiesListViewController.h"
#import "NNCityTableViewCell.h"
#import "NNCity.h"
#import "NNService.h"
#import "NNCityViewController.h"

@interface NNCitiesListViewController ()

@property (strong, nonatomic) NSArray *cities;
@property (strong, nonatomic) NNService *service;

@end

@implementation NNCitiesListViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.service = [[NNService alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    UINib *cityCell = [UINib nibWithNibName:@"NNCityTableViewCell" bundle:nil];
    [self.tableView registerNib:cityCell forCellReuseIdentifier:NNCityCellId];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self loadData];
}

-(void)loadData {
    [self.service getCitiesWithSuccess:^(NSArray *cities){
        self.cities = cities;
        [self.tableView reloadData];
        [self.loadingIndicator stopAnimating];
    } andFailure:^{
        [self.loadingIndicator stopAnimating];
        [[[UIAlertView alloc] initWithTitle:@"yikes"
                                   message:@"we couldn't find the cities... maybe check your network connection?"
                                  delegate:nil
                         cancelButtonTitle:@"ok"
                         otherButtonTitles:nil] show];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NNCityCellId];
    NNCity *city = [self.cities objectAtIndex:indexPath.row];
    [cell displayCity:city];
    if(indexPath.row < [self.cities count] - 1){
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:[UIColor darkGrayColor]];
        [line setFrame:(CGRect){{0, cell.frame.size.height-1},{cell.frame.size.width, 1}}];
        [cell addSubview:line];
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    NNCity *city = [self.cities objectAtIndex:indexPath.row];

    NNCityViewController *controller = [[NNCityViewController alloc] initWithCity:city];
    [self.navigationController pushViewController:controller animated:YES]  ;
}

- (void)viewDidUnload {
    [self setLoadingIndicator:nil];
    [super viewDidUnload];
}
@end
