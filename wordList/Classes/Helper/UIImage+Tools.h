





#import <UIKit/UIKit.h>

@interface UIImage (Tools)

/** 
 *将指定图像拉伸
 */
+ (UIImage *)stretchImage:(UIImage *)image;

/** 
 *从自己(大图)中按照指定区域，裁剪出小图 
 */

- (UIImage *)createImageWithRect:(CGRect)rect;

@end
