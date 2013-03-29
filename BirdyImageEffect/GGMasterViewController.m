//
//  GGMasterViewController.m
//  BirdyImageEffect
//
//  Created by Gwenn on 21/03/13.
//  Copyright (c) 2013 Free. All rights reserved.
//

#import "GGMasterViewController.h"

@interface GGMasterViewController ()

@property NSArray *filters;

@end


@implementation GGMasterViewController

@synthesize filters, detailViewController;

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 400.0);
        //self.modalPresentationStyle = UIModalTransitionStyleFlipHorizontal;
    }
    [super awakeFromNib];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    //self.tableView sc
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.filters = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    
    for (NSString *filterName in self.filters)
    {
        CIFilter *filter = [CIFilter filterWithName:filterName];
        NSLog(@"%@", [filter attributes]);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.filters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self.filters objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.detailViewController.detailItem = [self.filters objectAtIndex:indexPath.row];
     
}

@end
