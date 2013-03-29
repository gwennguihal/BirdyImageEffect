//
//  GGDetailViewController.m
//  BirdyImageEffect
//
//  Created by Gwenn on 21/03/13.
//  Copyright (c) 2013 Free. All rights reserved.
//

#import "GGDetailViewController.h"

@interface GGDetailViewController ()

@end

@implementation GGDetailViewController

@synthesize detailItem = _detailItem, detailLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setDetailItem:(id)detailItem
{
    if (_detailItem != detailItem)
    {
        _detailItem = detailItem;
        self.detailLabel.text = _detailItem;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.detailItem = @"hello";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
