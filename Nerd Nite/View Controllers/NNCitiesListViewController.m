//
//  NNCitiesListViewController.m
//  Nerd Nite
//
//  Created by Amber Conville on 2/15/13.
//
// Copyright (c) 2014 Detroit Labs, LLC.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES
                                             animated:animated];
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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
