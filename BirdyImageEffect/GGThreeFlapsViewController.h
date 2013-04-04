//
//  GGThreeFlapsViewController.h
//  BirdyImageEffect
//
//  Created by Gwenn on 03/04/13.
//  Copyright (c) 2013 Free. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GGThreeFlapsViewControllerProtocol <NSObject>

-(void) openFlap;

@end

@interface GGThreeFlapsViewController : UIViewController <GGThreeFlapsViewControllerProtocol>

@property (nonatomic, strong) IBOutlet UIViewController *masterViewController;
@property (nonatomic, readonly) BOOL isOpened;
@property (nonatomic, strong) IBOutlet UIViewController *subMasterViewController;
@property (nonatomic, strong) IBOutlet UIViewController *detailViewController;
@property (nonatomic, strong) NSArray *viewControllers;

- (void) setMasterViewController:(UIViewController *)masterViewController andSubMasterViewController:(UIViewController*) subMasterViewController andDetailViewController:(UIViewController*)detailViewController;


@end
