//
//  ZCRootController.m
//  wordList
//
//  Created by Jason Zhou on 7/11/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCRootController.h"
#import "ZCTabBarView.h"
#import "ZCNoHighLightBtn.h"
#import "ZCDataCenter.h"

@interface ZCRootController ()<ZCTabBarViewDelegate>

@property (nonatomic, strong)NSArray *imageSet;

@property (nonatomic, strong)NSArray *selectedImageSet;
//second
@property (nonatomic, copy)NSString *normalImage;
@property (nonatomic, copy)NSString *selectedImage;

@end

@implementation ZCRootController

///**************************************    life circle    **************************************
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    CGRect frame = self.tabBar.frame;
#warning refine here~ ~s

//    ZCTabBarView *customTabBar = [ZCTabBarView tabBarViewWithImageSet:self.imageSet andHighLightedImageSet:self.selectedImageSet frame:frame];
//    second method
    
    ZCTabBarView *customTabBar = [ZCTabBarView tabBarViewWithImage:self.normalImage andSelectedImage:self.selectedImage frame:frame AndItemNumber:4];
    customTabBar.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
    customTabBar.center = CGPointMake(0, 0);
    customTabBar.layer.anchorPoint = CGPointMake(0, 0);
    
    customTabBar.delegate = self;
    
    [self.tabBar addSubview:customTabBar];
    
    
    [self addObserver:self.viewControllers forKeyPath:@"self.frame" options:NSKeyValueObservingOptionOld context:nil];
    
//    self.tabBarController.tabBar.frame
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"%s............", __func__);
}

///**************************************    getter setter    **************************************
- (NSArray *)imageSet
{
    if (_imageSet == nil) {
        
        _imageSet = [NSArray arrayWithObjects:
                     @"tabBar1",
                     @"tabBar2",
                     @"tabBar3",
                     @"tabBar4",
                     nil];
    }
    
    return _imageSet;
}
                            
- (NSArray *)selectedImageSet
{
    if (_selectedImageSet == nil) {
        _selectedImageSet =[NSArray arrayWithObjects:
                            @"tabBar1Highlight",
                            @"tabBar2Highlight",
                            @"tabBar3Highlight",
                            @"tabBar4Highlight",
                            nil];

    }
    return _selectedImageSet;
}

- (NSString *)normalImage
{
    return @"normalTab";
}

- (NSString *)selectedImage
{
    return @"selectedTab";
}

- (ZCDataCenter *)dataCenter
{
    if (_dataCenter == nil) {
        
        _dataCenter = [[ZCDataCenter alloc] init];
    }
    return _dataCenter;
}
///**************************************   delegate     **************************************

- (void)tabBarView:(ZCTabBarView *)tabBarView didSelectedButton:(UIButton *)button
{
    self.selectedIndex = button.tag;
}



@end
