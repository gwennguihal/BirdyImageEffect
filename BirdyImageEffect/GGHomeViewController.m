//
//  GGViewController.m
//  BirdyImageEffect
//
//  Created by Gwenn on 21/03/13.
//  Copyright (c) 2013 Free. All rights reserved.
//

#import "GGHomeViewController.h"
#import "GGMasterViewController.h"
#import "GGDetailViewController.h"
#import "GGSubMasterViewController.h"

@interface GGHomeViewController ()

@end

@implementation GGHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIStoryboard *storyboard;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
    }
    
    self.masterViewController = [storyboard instantiateViewControllerWithIdentifier:@"Master"];
    self.detailViewController = [storyboard instantiateViewControllerWithIdentifier:@"Detail"];
    self.subMasterViewController = [storyboard instantiateViewControllerWithIdentifier:@"SubMaster"];
    
    ((GGMasterViewController*)self.masterViewController).subMasterViewController = ((GGSubMasterViewController*)self.subMasterViewController);
    
    ((GGDetailViewController*)self.detailViewController).subMasterViewController = ((GGSubMasterViewController*)self.subMasterViewController);
    ((GGSubMasterViewController*)self.subMasterViewController).detailViewController = ((GGDetailViewController*)self.detailViewController);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
