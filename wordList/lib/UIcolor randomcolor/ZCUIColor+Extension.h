//
//  ZCUIColor+Extension.h
//  01-键盘处理
//
//  Created by Jason Zhou on 7/3/14.
//  Copyright (c) 2014 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

+ (UIColor *)randomColor;

/* the cyclic background colors */
+ (NSArray*)cyclicColors;

+ (UIColor *)cyclicColor4Index:(int)index;

@end
