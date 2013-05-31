//
//  NNEventPicturesViewController.m
//  Nerd Nite
//
//  Created by Amber Conville on 4/6/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import "NNEventPicturesViewController.h"

@interface NNEventPicturesViewController ()

@end

@implementation NNEventPicturesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)close:(id)sender {
    [self.view removeFromSuperview];
}

@end
