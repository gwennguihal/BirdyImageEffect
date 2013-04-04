//
//  GGDetailViewController.h
//  BirdyImageEffect
//
//  Created by Gwenn on 21/03/13.
//  Copyright (c) 2013 Free. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GGSubMasterViewController.h"

@protocol GGDetailViewControllerDelegate <NSObject>

- (void) applyFilter;

@end

@interface GGDetailViewController : UIViewController <GGDetailViewControllerDelegate>

@property (nonatomic, weak) GGSubMasterViewController *subMasterViewController;

@property (nonatomic, copy) NSString *selectedFilterName;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
