//
//  ZCRootController.m
//  wordList
//
//  Created by Jason Zhou on 7/11/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCTabBarController.h"
#import "ZCTabBarView.h"
#import "ZCNoHighLightBtn.h"
#import "ZCDataCenter.h"
#import "ViewController.h"
#import "ZCScheduleTableViewController.h"
#import "ZCVocListTableViewController.h"
#import "ZCSelfCenterViewController.h"
#import "ZCNaviController.h"


@interface ZCTabBarController ()<ZCTabBarViewDelegate>

@property (nonatomic, strong)NSArray *imageSet;

@property (nonatomic, strong)NSArray *selectedImageSet;
//second
@property (nonatomic, copy)NSString *normalImage;
@property (nonatomic, copy)NSString *selectedImage;


@end

@implementation ZCTabBarController

///**************************************    life circle    **************************************
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
//        ViewController *wordViewVC = [[ViewController alloc] init];
////        [self addChildViewController:wordViewVC];
//        
////        ZCScheduleTableViewController *scheduleVC = [[ZCScheduleTableViewController alloc] init];
////        ZCNaviController *naviScheduleVC = [[ZCNaviController alloc] initWithRootViewController:scheduleVC];
//        ZCNaviController *naviScheduleVC = [[ZCNaviController alloc] initWithRootViewController:[[ZCScheduleTableViewController alloc] init]];
////        [self addChildViewController:naviScheduleVC];
//        
////        ZCVocListTableViewController *unknownWordVC = [[ZCVocListTableViewController alloc] init];
//        ZCNaviController *naviUnknownWordVC = [[ZCNaviController alloc] initWithRootViewController:[[ZCVocListTableViewController alloc] init]];
//
////        [self addChildViewController:naviUnknownWordVC];
//        
////        ZCSelfCenterViewController *profileVC = [[ZCSelfCenterViewController alloc] init];
//        ZCNaviController *naviProfileVC = [[ZCNaviController alloc] initWithRootViewController: [[ZCSelfCenterViewController alloc] init]];
//        [self addChildViewController:naviProfileVC];
        
        ViewController *wordViewVC = [[ViewController alloc] init];
        ZCNaviController *naviScheduleVC = [[ZCNaviController alloc] initWithRootViewController:[[ZCScheduleTableViewController alloc] init]];
        ZCNaviController *naviUnknownWordVC = [[ZCNaviController alloc] initWithRootViewController:[[ZCVocListTableViewController alloc] init]];
        ZCNaviController *naviProfileVC = [[ZCNaviController alloc] initWithRootViewController: [[ZCSelfCenterViewController alloc] init]];
        NSArray *array = [NSArray arrayWithObjects:wordViewVC,naviScheduleVC,naviUnknownWordVC, naviProfileVC, nil];
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self addChildViewController:obj];
        }];
        
#warning test theree /.
        ZCLog(@"init ............%@", self.tabBar.subviews);
//        [self customTabBar];

    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    
//    [self addObserver:self.viewControllers forKeyPath:@"self.frame" options:NSKeyValueObservingOptionOld context:nil];
    
//    self.tabBarController.tabBar.frame
    ZCLog(@"%s -------------- %@", __func__, self.tabBar.subviews);

    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self customTabBar];

    ZCLog(@"%s -------------- %@", __func__, self.tabBar.subviews);

}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    NSLog(@"%s............", __func__);
//}

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

- (ZCTabBarView *)customTabBar
{
    if (_customTabBar == nil) {
#warning refine here~ ~s
                CGRect frame = self.tabBar.bounds;
//            ZCTabBarView *customTabBar = [ZCTabBarView tabBarViewWithImageSet:self.imageSet andHighLightedImageSet:self.selectedImageSet frame:frame];
        //    second method
        
        ZCTabBarView *customTabBar = [ZCTabBarView tabBarViewWithImage:self.normalImage andSelectedImage:self.selectedImage frame:frame AndItemNumber:4];
        
        //    customTabBar.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
        
        customTabBar.delegate = self;
        
        #warning test theree /.
        ZCLog(@"custom get -------------- %@", self.tabBar.subviews);

        
        [self.tabBar addSubview:customTabBar];
        
        _customTabBar = customTabBar;
        
    }
    
    return _customTabBar;

}
///**************************************   delegate     **************************************

- (void)tabBarView:(ZCTabBarView *)tabBarView didSelectedButton:(UIButton *)button
{
    self.selectedIndex = button.tag;
}



@end
