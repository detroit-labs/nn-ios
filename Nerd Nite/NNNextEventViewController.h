//
//  NNNextEventViewController.h
//  Nerd Nite
//
//  Created by Amber Conville on 8/3/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import "NNViewController.h"

@interface NNNextEventViewController : NNViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *presentationTableView;

- (id)initWithEvent:(NNEvent *)event;

@end
