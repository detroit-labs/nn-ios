//
//  NNCitiesListViewController+.h
//  Nerd Nite
//
//  Created by Amber Conville on 2/15/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNCitiesListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end