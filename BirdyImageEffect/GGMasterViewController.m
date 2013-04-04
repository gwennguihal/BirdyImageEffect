//
//  GGMasterViewController.m
//  BirdyImageEffect
//
//  Created by Gwenn on 21/03/13.
//  Copyright (c) 2013 Free. All rights reserved.
//

#import "GGMasterViewController.h"
#import "GGThreeFlapsViewController.h"

@interface GGMasterViewController ()

@property NSArray *filters;
@property NSMutableArray *filtersDisplayName;

@end


@implementation GGMasterViewController

@synthesize filters, subMasterViewController;

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        self.clearsSelectionOnViewWillAppear = NO;
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
    self.filtersDisplayName = [NSMutableArray arrayWithCapacity:self.filters.count];
    
    for (NSString *filterName in self.filters)
    {
        CIFilter *filter = [CIFilter filterWithName:filterName];
        [self.filtersDisplayName addObject:[filter.attributes objectForKey:@"CIAttributeFilterDisplayName"]];
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
    
    cell.textLabel.text = [self.filtersDisplayName objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.subMasterViewController.selectedFilterName = [self.filters objectAtIndex:indexPath.row];
    [((UIViewController <GGThreeFlapsViewControllerProtocol> *)(self.parentViewController)) openFlap];
     
}

@end
