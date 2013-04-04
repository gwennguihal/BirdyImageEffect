//
//  GGSubMasterViewController.h
//  BirdyImageEffect
//
//  Created by Gwenn on 03/04/13.
//  Copyright (c) 2013 Free. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GGDetailViewControllerDelegate;

@interface GGSubMasterViewController : UIViewController

@property (nonatomic, weak) id <GGDetailViewControllerDelegate> detailViewController;
@property (nonatomic, copy) NSString *selectedFilterName;
@property (strong, nonatomic) CIFilter *filter;
@property (strong, nonatomic) CIContext *context;
@property (strong, nonatomic) CIImage *beginImage;
@property (nonatomic, readonly) BOOL isFilterWithInputCenter;

@end
