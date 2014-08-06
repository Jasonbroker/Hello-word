//
//  ZCWelcomeView.h
//  wordList
//
//  Created by Jason Zhou on 8/1/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DKCircleButton;
#import "ZCWelDashboardView.h"
@class FBShimmeringView;

@interface ZCWelcomeView : UIView

//+ (instancetype) welcomeView;

@property (nonatomic, strong) DKCircleButton *readModeBtn;

@property (nonatomic, strong) DKCircleButton *testModeBtn;

@property (strong, nonatomic) ZCWelDashboardView *dashboardView;

@property (strong, nonatomic) FBShimmeringView *slideView;

@property (nonatomic, strong) UILabel *wordLabel;


@end
