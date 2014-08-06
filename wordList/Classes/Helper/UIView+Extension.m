//
//  UIView+Extension.h
//
//
//  Created by Jason on 05/08/14.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
///**************************************     x   **************************************
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

///**************************************  y      **************************************
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}
///**************************************  width      **************************************
- (void)setWidth:(CGFloat)width
{
    // 注意, 不要用bounds来设置宽高, 会有一些未知bug
    // 用bounds来设置宽高, 如果控件事先已经设置过xy了, 会被bounds的xy覆盖
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}
///**************************************  height      **************************************
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}
///**************************************  size      **************************************

- (void)setSize:(CGSize)size{
//    self.frame.size = size;
    
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

///**************************************  centerX      **************************************
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}
///**************************************  centerY      **************************************
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

@end
