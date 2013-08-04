//
//  NNNextEventViewController.m
//  Nerd Nite
//
//  Created by Amber Conville on 8/3/13.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//

#import "NNNextEventViewController.h"
#import "NNEvent.h"
#import "NNPresentationTableViewCell.h"

static NSString *const PresentationCellId = @"NNPresentationCell";

@interface NNNextEventViewController ()

@property (strong, nonatomic) NNEvent *event;

@end

@implementation NNNextEventViewController

- (id)initWithEvent:(NNEvent *)event
{
    self = [super initWithNibName:@"NNNextEventViewController" bundle:nil];
    if (self) {
        self.event = event;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.presentationTableView registerNib:[UINib nibWithNibName:@"NNPresentationTableViewCell" bundle:nil]
                     forCellReuseIdentifier:PresentationCellId];

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

@end
