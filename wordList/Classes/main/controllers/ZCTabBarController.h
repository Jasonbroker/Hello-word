//
//  ZCRootController.h
//  wordList
//
//  Created by Jason Zhou on 7/11/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCDataCenter.h"
#import "ZCTabBarView.h"
@interface ZCTabBarController : UITabBarController

//  define a data center to manage All the data

@property (nonatomic, strong) ZCDataCenter *dataCenter;

@property (nonatomic, weak)ZCTabBarView *customTabBar;
@end
