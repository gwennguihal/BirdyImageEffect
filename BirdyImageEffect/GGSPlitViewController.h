//
//  GGSPlitViewController.h
//  BirdyImageEffect
//
//  Created by Gwenn on 22/03/13.
//  Copyright (c) 2013 Free. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGSPlitViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIViewController *masterViewController;
@property (nonatomic, strong) IBOutlet UIViewController *detailViewController;
@property (nonatomic, strong) NSArray *viewControllers;

- (void) setMasterViewController:(UIViewController *)masterViewController andDetailViewController:(UIViewController*)detailViewController;

@end
