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
    //[self setup];
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
    self.view.contentMode = UIViewContentModeRedraw;
}

- (void) setup
{
    [self layoutSubViews];
}

- (void) layoutSubViews
{
    [self layoutSubviewsForInterfaceOrientation:self.interfaceOrientation withAnimation:YES];
}

- (void) layoutSubviewsForInterfaceOrientation:(UIInterfaceOrientation)orientation withAnimation:(BOOL)animated
{
    // add subbiews
    if (self.masterViewController && !self.masterViewController.view.superview)
        [self.view addSubview:self.masterViewController.view];
    if (self.detailViewController && !self.detailViewController.view.superview)
        [self.view addSubview:self.detailViewController.view];
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    float width = screenBounds.size.width;
    float height = screenBounds.size.height;
    
    if (UIInterfaceOrientationIsLandscape(orientation))
    {
        width = screenBounds.size.height;
        height = screenBounds.size.width;
    }
    
    float splitPosition = 320.0;
    
    CGRect frame = CGRectMake(0, 0, width, height);
    // master
    frame.size.width = splitPosition;
    //frame.size.height = 1000.0;
    self.masterViewController.view.frame = frame;
    self.masterViewController.view.layer.borderWidth = 1.5f;
    
    // details
    frame.size.width = width - splitPosition;
    frame.origin.x = splitPosition;
    self.detailViewController.view.frame = frame;
    self.detailViewController.view.layer.borderWidth = 1.5f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.masterViewController viewWillAppear:animated];
    [self.detailViewController viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.masterViewController viewDidAppear:animated];
    [self.detailViewController viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.masterViewController viewWillDisappear:animated];
    [self.detailViewController viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
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


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[self.masterViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	[self.detailViewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[self.masterViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	[self.detailViewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
										 duration:(NSTimeInterval)duration
{
	[self.masterViewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	[self.detailViewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	
	[self layoutSubviewsForInterfaceOrientation:toInterfaceOrientation withAnimation:YES];
}


- (void)willAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[self.masterViewController willAnimateFirstHalfOfRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	[self.detailViewController willAnimateFirstHalfOfRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}


- (void)didAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	[self.masterViewController didAnimateFirstHalfOfRotationToInterfaceOrientation:toInterfaceOrientation];
	[self.detailViewController didAnimateFirstHalfOfRotationToInterfaceOrientation:toInterfaceOrientation];
}


- (void)willAnimateSecondHalfOfRotationFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration
{
	[self.masterViewController willAnimateSecondHalfOfRotationFromInterfaceOrientation:fromInterfaceOrientation duration:duration];
	[self.detailViewController willAnimateSecondHalfOfRotationFromInterfaceOrientation:fromInterfaceOrientation duration:duration];
}

- (void)setMasterViewController:(UIViewController *)viewController
{
    if (_masterViewController != viewController)
    {
        _masterViewController = viewController;
        [self layoutSubViews];
    }
    
}

- (void)setDetailViewController:(UIViewController *)viewController
{
    if (_detailViewController != viewController)
    {
        _detailViewController = viewController;
        [self layoutSubViews];
    }
}

@synthesize masterViewController = _masterViewController;
@synthesize detailViewController = _detailViewController;

@end
