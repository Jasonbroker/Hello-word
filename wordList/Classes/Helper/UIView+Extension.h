//
//  UIView+Extension.h
//
//
//  Created by Jason on 05/08/14.
//  Copyright (c) 2014年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

// 注意: 如果在分类中写@property, 只会生成方法的声明, 不会生成方法的实现和成员变量

@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;

@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;

@property (nonatomic,assign) CGSize size;

@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;

@end
