//
//  GGMasterViewController.h
//  BirdyImageEffect
//
//  Created by Gwenn on 21/03/13.
//  Copyright (c) 2013 Free. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GGDetailViewController.h"
#import "GGSubMasterViewController.h"

@interface GGMasterViewController : UITableViewController

@property (nonatomic, weak) GGSubMasterViewController *subMasterViewController;
//@property (nonatomic, weak) id<GGThreeFlapsViewControllerProtocol> three

@end
