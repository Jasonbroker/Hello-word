//
//  ZCTabBarView.h
//  wordList
//
//  Created by Jason Zhou on 7/19/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCNoHighLightBtn.h"

@class ZCTabBarView;


@protocol ZCTabBarViewDelegate <NSObject>

- (void)tabBarView:(ZCTabBarView *)tabBarView didSelectedButton:(ZCNoHighLightBtn *)button;

@end

@interface ZCTabBarView : UIView

@property (nonatomic, weak) id <ZCTabBarViewDelegate> delegate;

+ (instancetype)tabBarViewWithImageSet:(NSArray *)image andHighLightedImageSet:(NSArray *)selectedImage frame:(CGRect)frame;

+ (instancetype)tabBarViewWithImage:(NSString *)image andSelectedImage:(NSString *)selectedImage frame:(CGRect)frame AndItemNumber:(int)itemNumber;


@end
