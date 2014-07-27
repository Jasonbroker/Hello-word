//
//  ZCNaviController.m
//  wordList
//
//  Created by Jason Zhou on 7/20/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCNaviController.h"
//#import "ZCRootController.h"

@interface ZCNaviController()


@end

@implementation ZCNaviController


+ (void)initialize
{
    
}
//  new thing barhidden gesture
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self.tabBarController.tabBar addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew context:nil];
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{

//}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"%s", __func__);
    
    viewController.hidesBottomBarWhenPushed = YES;
//    with this super, you can not push viewcontroller
    [super pushViewController:viewController animated:YES];
}
@end
