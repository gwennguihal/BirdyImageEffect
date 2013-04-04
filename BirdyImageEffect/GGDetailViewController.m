//
//  GGDetailViewController.m
//  BirdyImageEffect
//
//  Created by Gwenn on 21/03/13.
//  Copyright (c) 2013 Free. All rights reserved.
//

#import "GGDetailViewController.h"

@interface GGDetailViewController ()
{
    BOOL _touchMoving;
}

@end

@implementation GGDetailViewController

@synthesize imageView, subMasterViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) applyFilter
{
    CIImage *outputImage = [subMasterViewController.filter outputImage];
    
    CGImageRef cgimg = [subMasterViewController.context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    
    self.imageView.image = newImg;
    CGImageRelease(cgimg);
    
    /*dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     
     CIImage *outputImage = [_currentFilter outputImage];
     CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
     UIImage *newImg = [UIImage imageWithCGImage:cgimg];
     
     dispatch_sync(dispatch_get_main_queue(), ^{
     self.imageView.image = newImg;
     CGImageRelease(cgimg);
     });
     });*/

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view]; // superview is necessary
    
    if (CGRectContainsPoint(self.imageView.frame, location) && subMasterViewController.isFilterWithInputCenter)
    {
        CGPoint location = [touch locationInView:self.imageView];
        
        [subMasterViewController.filter setValue: [CIVector vectorWithCGPoint:location] forKey:@"inputCenter"];
        [self applyFilter];
        _touchMoving = YES;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_touchMoving && subMasterViewController.isFilterWithInputCenter)
    {
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView:self.imageView];
        
        [subMasterViewController.filter setValue: [CIVector vectorWithCGPoint:location] forKey:@"inputCenter"];
        [self applyFilter];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _touchMoving = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
