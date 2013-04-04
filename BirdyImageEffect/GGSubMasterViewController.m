//
//  GGSubMasterViewController.m
//  BirdyImageEffect
//
//  Created by Gwenn on 03/04/13.
//  Copyright (c) 2013 Free. All rights reserved.
//

#import "GGSubMasterViewController.h"
#import "GGDetailViewController.h"

@interface GGSubMasterViewController ()

@property (strong, nonatomic) NSMutableArray *_uiControls;

@end

@implementation GGSubMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"photo" ofType:@"jpeg"];
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
    
    beginImage = [CIImage imageWithContentsOfURL:fileNameAndPath];
    
    _uiControls = [NSMutableArray array];
    
    EAGLContext *myEAGLContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setObject: [NSNull null] forKey: kCIContextWorkingColorSpace];
    context = [CIContext contextWithEAGLContext:myEAGLContext options:options];
    //context = [CIContext contextWithOptions:nil];
}

- (void)setSelectedFilterName:(NSString *)filterName
{
    if (_selectedFilterName != filterName)
    {
        _selectedFilterName = filterName;
        [self configureFilter];
    }
}

- (void) configureFilter
{
    for (UIView *control in _uiControls)
    {
        [control removeFromSuperview];
    }
    [_uiControls removeAllObjects];
    
    filter = [CIFilter filterWithName:_selectedFilterName];
    
    // default attributes
    _isFilterWithInputCenter = NO;
    [filter setDefaults];
    
    int y = 10;
    int tag = 0; // incremente because each UIComponent corresponds to an input
    
    for (NSString *key in filter.inputKeys)
    {
        NSDictionary *inputInfos = [filter.attributes objectForKey:key];
        NSString *attributeType = [inputInfos objectForKey:@"CIAttributeType"];
        
        // attribute type
        if ([attributeType isEqualToString:kCIAttributeTypeImage])
        {
            [filter setValue:beginImage forKey:key];
        }
        else if ([attributeType isEqualToString:kCIAttributeTypeTime] ||
                 [attributeType isEqualToString:kCIAttributeTypeScalar] ||
                 [attributeType isEqualToString:kCIAttributeTypeDistance] ||
                 [attributeType isEqualToString:kCIAttributeTypeAngle] ||
                 [attributeType isEqualToString:kCIAttributeTypeBoolean])
        {
            // add Label
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, y, self.view.frame.size.width - 20, 22)];
            label.text = key;
            y += 22;
            [self.view addSubview:label];
            [_uiControls addObject:label];
            
            // add slider
            UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(10, y, self.view.frame.size.width - 20, 44)];
            slider.tag = tag;
            slider.minimumValue = ((NSString*)[inputInfos objectForKey:@"CIAttributeSliderMin"]).floatValue;
            slider.maximumValue = ((NSString*)[inputInfos objectForKey:@"CIAttributeSliderMax"]).floatValue;
            slider.value = slider.minimumValue = ((NSString*)[inputInfos objectForKey:@"CIAttributeDefault"]).floatValue;
            //slider.continuous = NO;
            [self.view addSubview:slider];
            y += 44 + 10;
            
            [slider addTarget:self action:@selector(sliderHandler:) forControlEvents:UIControlEventValueChanged];
            
            [_uiControls addObject:slider];
        }
        else if ([attributeType isEqualToString:kCIAttributeTypePosition])
        {
            _isFilterWithInputCenter = YES;
        }
        tag++;
    }
    
    [self.detailViewController applyFilter];
}

- (void) sliderHandler:(id)sender
{
    NSString *key = [filter.inputKeys objectAtIndex:((UISlider*)sender).tag];
    [filter setValue: [NSNumber numberWithFloat:((UISlider*)sender).value] forKey:key];
    
    [self.detailViewController applyFilter];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@synthesize selectedFilterName = _selectedFilterName, filter, context, isFilterWithInputCenter = _isFilterWithInputCenter, detailViewController, beginImage;
@synthesize _uiControls;

@end
