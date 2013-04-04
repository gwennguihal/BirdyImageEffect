//
//  GGThreeFlapsViewController.m
//  BirdyImageEffect
//
//  Created by Gwenn on 03/04/13.
//  Copyright (c) 2013 Free. All rights reserved.
//

#import "GGThreeFlapsViewController.h"

#define kSplit 320.0

@interface GGThreeFlapsViewController ()

@end

@implementation GGThreeFlapsViewController

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
        [self setup];
	}
	
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureHandler:)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRecognizer];
}

- (void) setup
{
    _isOpened = NO;
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
    [self.subMasterViewController viewWillLayoutSubviews];
    
    [self layoutSubViews];
}

- (void) layoutSubviewsForInterfaceOrientation:(UIInterfaceOrientation)orientation withAnimation:(BOOL)animated
{
    // add subbiews
    if (self.masterViewController && !self.masterViewController.view.superview)
        [self.view addSubview:self.masterViewController.view];
    if (self.subMasterViewController && !self.subMasterViewController.view.superview)
        [self.view addSubview:self.subMasterViewController.view];
    if (self.detailViewController && !self.detailViewController.view.superview)
        [self.view addSubview:self.detailViewController.view];
    
    //CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGRect screenBounds = self.view.bounds;
    float width = screenBounds.size.width;
    float height = screenBounds.size.height;
    
    if (UIInterfaceOrientationIsLandscape(orientation))
    {

    }
        
    float flapWidth, splitPosition;
    splitPosition = kSplit;
    flapWidth = kSplit - 20;
    
    CGRect frame = CGRectMake(0, 0, width, height);
    // master
    frame.size.width = splitPosition;
    self.masterViewController.view.frame = frame;
    
    // submaster
    frame = CGRectMake(0, 0, width, height);
    frame.size.width = flapWidth;
    frame.origin.x = splitPosition + 20;
    self.subMasterViewController.view.frame = frame;
    
    [self setShadowtoUIView:self.subMasterViewController.view];
    
    // details
    frame = CGRectMake(0, 0, width, height);
    frame.size.width = width - splitPosition;
    frame.origin.x = splitPosition;
    self.detailViewController.view.frame = frame;
    
    [self setShadowtoUIView:self.detailViewController.view];
}

- (void) setShadowtoUIView:(UIView*)view
{
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = 0.5;
    view.layer.shadowOffset = CGSizeMake(-3.0, 0.0);
    view.layer.shadowRadius = 3.0;
    
    // cache the shadow for perfomance
    view.layer.shouldRasterize = YES;
    view.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void) openFlap
{
    float flapWidth, splitPosition;
    splitPosition = kSplit;
    flapWidth = kSplit - 20;
    
    CGRect masterFrame = self.masterViewController.view.frame;
    masterFrame.origin.x = -flapWidth;
    
    CGRect subMasterFrame = self.subMasterViewController.view.frame;
    subMasterFrame.origin.x = 20;
    
    CGRect detailFrame = self.detailViewController.view.frame;
    detailFrame.origin.x = splitPosition;

    
    [UIView animateWithDuration:0.5f animations:^{
        
        self.masterViewController.view.frame = masterFrame;
        self.subMasterViewController.view.frame = subMasterFrame;
        self.detailViewController.view.frame = detailFrame;
    }];
}

- (void) closeFlap
{
    float flapWidth, splitPosition;
    splitPosition = kSplit;
    flapWidth = kSplit - 20;
    
    CGRect masterFrame = self.masterViewController.view.frame;
    masterFrame.origin.x = 0;
    
    CGRect subMasterFrame = self.subMasterViewController.view.frame;
    subMasterFrame.origin.x = splitPosition;
    
    CGRect detailFrame = self.detailViewController.view.frame;
    detailFrame.origin.x = splitPosition + flapWidth;
    
    
    [UIView animateWithDuration:0.5f animations:^{
        
        self.masterViewController.view.frame = masterFrame;
        self.subMasterViewController.view.frame = subMasterFrame;
        self.detailViewController.view.frame = detailFrame;
    }];
}

- (IBAction)swipeGestureHandler:(UISwipeGestureRecognizer*)gestureRecognizer
{
    [self closeFlap];
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
    [self.subMasterViewController viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.masterViewController viewDidAppear:animated];
    [self.detailViewController viewDidAppear:animated];
    [self.subMasterViewController viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.masterViewController viewWillDisappear:animated];
    [self.detailViewController viewWillDisappear:animated];
    [self.subMasterViewController viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.masterViewController viewDidDisappear:animated];
    [self.detailViewController viewDidDisappear:animated];
    [self.subMasterViewController viewDidDisappear:animated];
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
    [self.subMasterViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

//2
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
										 duration:(NSTimeInterval)duration
{
	[self.masterViewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	[self.detailViewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.subMasterViewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	[self layoutSubviewsForInterfaceOrientation:toInterfaceOrientation withAnimation:YES];
}

//3
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.masterViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.detailViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.subMasterViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

-(void)setMasterViewController:(UIViewController *)masterViewController andSubMasterViewController:(UIViewController*) subMasterViewController andDetailViewController:(UIViewController *)detailViewController
{
    self.masterViewController = masterViewController;
    self.detailViewController = detailViewController;
    self.subMasterViewController = subMasterViewController;
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

- (void)setSubMasterViewController:(UIViewController *)viewController
{
    if (_subMasterViewController != viewController)
    {
        _subMasterViewController = viewController;
        [self addChildViewController:_subMasterViewController];
        [_subMasterViewController didMoveToParentViewController:self];
    }
}

@synthesize masterViewController = _masterViewController;
@synthesize detailViewController = _detailViewController;
@synthesize subMasterViewController = _subMasterViewController;
@synthesize isOpened = _isOpened;

@end
