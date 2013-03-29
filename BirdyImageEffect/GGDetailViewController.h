//
//  GGDetailViewController.h
//  BirdyImageEffect
//
//  Created by Gwenn on 21/03/13.
//  Copyright (c) 2013 Free. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GGDetailViewController : UIViewController

@property (nonatomic, strong) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end
