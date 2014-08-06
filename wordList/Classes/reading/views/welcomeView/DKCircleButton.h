//
//  DKCircleButton.h
//  DKCircleButton
//
//  Created by Dmitry Klimkin on 23/4/14.
//  Copyright (c) 2014 Dmitry Klimkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKCircleButton : UIButton

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic) BOOL animateTap;
@property (nonatomic) BOOL displayShading;
@property (nonatomic) CGFloat borderSize;

- (void)blink;

- (void)setImage:(UIImage *)image animated: (BOOL)animated;

/**
 * fast creation
 */
+ (id)circleButtonWithSize:(CGSize)size borderSize:(CGFloat)borderSize normalTitle:(NSString *)title addTarget:(id)target action:(SEL)action animated:(BOOL)animated;

///

- (void)selectedWithAnimation:(BOOL)animation;

- (void)deselected;

@end
