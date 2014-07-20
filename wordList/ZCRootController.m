//
//  ZCRootController.m
//  wordList
//
//  Created by Jason Zhou on 7/11/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCRootController.h"
#import "ZCTabBarView.h"

@interface ZCRootController ()<ZCTabBarViewDelegate>

@property (nonatomic, strong)NSArray *imageSet;

@property (nonatomic, strong)NSArray *selectedImageSet;

@end

@implementation ZCRootController

///**************************************    life circle    **************************************
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect frame = self.tabBar.frame;
#warning refine here~~
#warning need hide the tabbar!
//    self.tabBar.center = CGPointMake(0, self.view.bounds.size.height/2);
//    self.tabBar.layer.anchorPoint = CGPointMake(0, 0);
//    self.tabBar.barTintColor = [UIColor redColor];
    self.tabBar.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.0f];
    
    
    
    NSLog(@"%p", self);
    
    ZCTabBarView *customTabBar = [ZCTabBarView tabBarViewWithImageSet:self.imageSet andHighLightedImageSet:self.selectedImageSet frame:frame];
    
    customTabBar.center = CGPointMake(0, self.view.bounds.size.height);
    customTabBar.layer.anchorPoint = CGPointMake(0, 1);
    
    customTabBar.delegate = self;
    
    [self.view addSubview:customTabBar];
    
    
//    [self addObserver:self.viewControllers forKeyPath:@"self.tabBarController.tabBar.frame" options:NSKeyValueObservingOptionOld context:nil];
    
//    self.tabBarController.tabBar.frame
}

///**************************************    getter setter    **************************************
- (NSArray *)imageSet
{
    if (_imageSet == nil) {
        
        _imageSet = [NSArray arrayWithObjects:
                     @"read",
                     @"schedule",
                     @"vocList",
                     @"mime",
                     nil];
    }
    
    return _imageSet;
}
                            
- (NSArray *)selectedImageSet
{
    if (_selectedImageSet == nil) {
        _selectedImageSet =[NSArray arrayWithObjects:
                            @"read",
                            @"schedule",
                            @"vocList",
                            @"mime",
                            nil];

    }
    return _selectedImageSet;
}

///**************************************   delegate     **************************************

- (void)tabBarView:(ZCTabBarView *)tabBarView didSelectedButton:(UIButton *)button
{
    NSLog(@"%s", __func__);
    self.selectedIndex = button.tag;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
