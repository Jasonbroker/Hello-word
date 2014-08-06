//
//  dasboardView.h
//  dashboard
//
//  Created by Jason Zhou on 8/5/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DasboardView : UIView

@property (nonatomic, strong) UIView *mainPionter;

- (void)showDashboardAnimationWithOriginalAngle:(CGFloat)orignalAngle Rotation:(CGFloat)ToAngle after:(CGFloat)afterTime animateWithDuration:(CGFloat)duration delay:(CGFloat)delay;


@end
