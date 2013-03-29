//
//  GGSPlitViewController.m
//  BirdyImageEffect
//
//  Created by Gwenn on 22/03/13.
//  Copyright (c) 2013 Free. All rights reserved.
//

#import "GGSPlitViewController.h"

@interface GGSPlitViewController ()

@end

@implementation GGSPlitViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (BOOL)shouldAutomaticallyForwardRotationMethods
{
    return NO;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods
{
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationMaskLandscapeLeft & UIInterfaceOrientationMaskLandscapeRight;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder]))
    {
	}
	
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) setup
{
}

- (void) layoutSubViews
{
    [self layoutSubviewsForInterfaceOrientation:self.interfaceOrientation withAnimation:YES];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self.masterViewController viewWillLayoutSubviews];
    [self.detailViewController viewWillLayoutSubviews];
    
    [self layoutSubViews];
}

- (void) layoutSubviewsForInterfaceOrientation:(UIInterfaceOrientation)orientation withAnimation:(BOOL)animated
{
    // add subbiews
    if (self.masterViewController && !self.masterViewController.view.superview)
        [self.view addSubview:self.masterViewController.view];
    if (self.detailViewController && !self.detailViewController.view.superview)
        [self.view addSubview:self.detailViewController.view];
    
    //CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGRect screenBounds = self.view.bounds;
    float width = screenBounds.size.width;
    float height = screenBounds.size.height;
    
    if (UIInterfaceOrientationIsLandscape(orientation))
    {
        //width = screenBounds.size.height;
        //height = screenBounds.size.width;
    }
    
    //NSLog(@"width %f, height %f",width,height);
    //NSLog(@"self.frame %@",NSStringFromCGRect(self.view.frame));
    
    float splitPosition = 320.0;
    
    CGRect frame = CGRectMake(0, 0, width, height);
    // master
    frame.size.width = splitPosition;
    self.masterViewController.view.frame = frame;
    self.masterViewController.view.layer.borderWidth = 1.0f;
    
    // details
    frame.size.width = width - splitPosition;
    frame.origin.x = splitPosition;
    self.detailViewController.view.frame = frame;
    self.detailViewController.view.layer.borderWidth = 1.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.masterViewController viewWillAppear:animated];
    [self.detailViewController viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.masterViewController viewDidAppear:animated];
    [self.detailViewController viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.masterViewController viewWillDisappear:animated];
    [self.detailViewController viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.masterViewController viewDidDisappear:animated];
    [self.detailViewController viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (self.detailViewController)
    {
        return [self.detailViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
    }
    
    return YES;
}

//1
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[self.masterViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	[self.detailViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

//2
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
										 duration:(NSTimeInterval)duration
{
	[self.masterViewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	[self.detailViewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	[self layoutSubviewsForInterfaceOrientation:toInterfaceOrientation withAnimation:YES];
}

//3
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.masterViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.detailViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

-(void)setMasterViewController:(UIViewController *)masterViewController andDetailViewController:(UIViewController *)detailViewController
{
    self.masterViewController = masterViewController;
    self.detailViewController = detailViewController;
}


- (void)setMasterViewController:(UIViewController *)viewController
{
    if (_masterViewController != viewController)
    {
        _masterViewController = viewController;
        [self addChildViewController:_masterViewController];
        [_masterViewController didMoveToParentViewController:self];
    }
    
}

- (void)setDetailViewController:(UIViewController *)viewController
{
    if (_detailViewController != viewController)
    {
        _detailViewController = viewController;
        [self addChildViewController:_detailViewController];
        [_detailViewController didMoveToParentViewController:self];
    }
}

@synthesize masterViewController = _masterViewController;
@synthesize detailViewController = _detailViewController;

@end
