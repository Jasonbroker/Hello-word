//
//  UIImage+Tools.m
//  网易彩票
//
//  Created by apple on 19/07/14.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIImage+Tools.h"

@implementation UIImage (Tools)

+ (UIImage *)stretchImage:(UIImage *)image
{
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

- (UIImage *)createImageWithRect:(CGRect)rect
{
    // 使用指定的区域，从一张大图中截取出小的图片
    // CG Core Graphics 是属于系统底层的API，针对"像素"进行操作的
    // "渐进" 如果是使用C语言的框架，如果有create,retain,copy字样创建的对象
    // 需要手动释放！需要释放什么类型，先敲一下，然后跟release
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    
    // 生成图像
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    
    // 释放内存
    CGImageRelease(imageRef);
    
    return image;
}

@end
