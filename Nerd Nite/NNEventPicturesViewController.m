//
//  NNEventPicturesViewController.m
//  Nerd Nite
//
//  Created by Amber Conville on 4/6/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import "NNEventPicturesViewController.h"
#import "NNService.h"
#import "NNEventPictureCell.h"
#import "NNEvent.h"
#import "NNPhoto.h"

static NSString *const EventPictureCellId = @"NNEventPictureCell";

@interface NNEventPicturesViewController ()

@property(nonatomic, strong) NNService *service;

@end

@implementation NNEventPicturesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.service = [[NNService alloc] init];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)close:(id)sender {
    [self.view removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"NNEventPictureCell" bundle:nil] forCellReuseIdentifier:EventPictureCellId];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.event.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NNEventPictureCell *cell = [self.tableView dequeueReusableCellWithIdentifier:EventPictureCellId];
    NNPhoto *photo = [self.event.photos objectAtIndex:indexPath.row];
    [cell setPhoto:photo];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 235;
}

@end
