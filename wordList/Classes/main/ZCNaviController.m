//
//  ZCNaviController.m
//  wordList
//
//  Created by Jason Zhou on 7/20/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCNaviController.h"

@implementation ZCNaviController


+ (void)initialize
{
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"%s", __func__);
    
    viewController.hidesBottomBarWhenPushed = YES;
//    with this super, you can not push viewcontroller
    [super pushViewController:viewController animated:YES];
}
@end
