//
//  NNEventPicturesViewController.h
//  Nerd Nite
//
//  Created by Amber Conville on 4/6/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NNEvent;

@interface NNEventPicturesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NNEvent *event;

- (IBAction)close:(id)sender;

@end
