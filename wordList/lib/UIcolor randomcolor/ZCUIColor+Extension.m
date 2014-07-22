//
//  ZCUIColor+Extension.m
//  01-键盘处理
//
//  Created by Jason Zhou on 7/3/14.
//  Copyright (c) 2014 itcast. All rights reserved.
//

#import "ZCUIColor+Extension.h"

#define hll_color(r,g,b,a) [UIColor colorWithRed:(float)r/255.f green:(float)g/255.f blue:(float)b/255.f  alpha:a]


@implementation UIColor (Extension)
/// *** random color

+ (UIColor *)randomColor
{
    static BOOL seeded = NO;
    
    if (!seeded) {
        seeded = YES;
        srandom(time(NULL));
    }
    CGFloat red = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f]; 
    
}


/* the cyclic background colors */
+ (NSArray*)cyclicColors
{
    return @[hll_color(255, 117, 96, 1), hll_color(254, 89, 121, 1), hll_color(233, 71, 144, 1), hll_color(255, 103, 193, 1), hll_color(197, 130, 236, 1), hll_color(164, 158, 255, 1), hll_color(159, 182, 249, 1), hll_color(164, 158, 255, 1), hll_color(197, 130, 236, 1), hll_color(255, 103, 193, 1),  hll_color(233, 71, 144, 1)];
}

+(UIColor *)cyclicColor4Index:(int)index
{
    index = index % [UIColor cyclicColors].count;
    UIColor *color = [UIColor cyclicColors][index];
    
    return color;
    
}

@end
