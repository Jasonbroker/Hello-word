//
//  ZCTabBarView.m
//  wordList
//
//  Created by Jason Zhou on 7/19/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCTabBarView.h"
#import "ZCNoHighLightBtn.h"

@interface ZCTabBarView()

@property (nonatomic, strong) NSArray *imageNames;

@property (nonatomic, strong) NSArray *selectedImageNames;


@end

@implementation ZCTabBarView
///**************************************   init view     **************************************
+ (instancetype)tabBarViewWithImageSet:(NSArray *)image andHighLightedImageSet:(NSArray *)selectedImage frame:(CGRect)frame
{
    
    
    NSLog(@"%s", __func__);
    ZCTabBarView *tabBarView = [[ZCTabBarView alloc] initWithFrame:frame];
//    tabBarView.backgroundColor = [UIColor redColor];
    
    tabBarView.imageNames = image;
    tabBarView.selectedImageNames = selectedImage;
    
    [tabBarView initTabBarbtn];
    
//    [tabBarView setTabBarBackground];


    return tabBarView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    NSLog(@"%s", __func__);
    self = [super initWithFrame:frame];
    
    if (self) {
        
    }
    return self;
}

- (void)initTabBarbtn
{
    int btnNumber = self.imageNames.count;
    
    for (int i = 0; i < btnNumber; i ++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        sett background
                    [btn setBackgroundImage:[UIImage imageNamed: (NSString *)self.imageNames[i]] forState:UIControlStateNormal];
        
                    [btn setBackgroundImage:[UIImage imageNamed: (NSString *)self.selectedImageNames[i]] forState:UIControlStateHighlighted];
        
        btn.tag = i;
        
        [self addSubview:btn];
        
        [btn addTarget:self action:@selector(press:) forControlEvents:UIControlEventTouchDown];
    }

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat y = 0;
    
    CGFloat w = self.bounds.size.width/self.subviews.count;
    
    CGFloat h = self.bounds.size.height;
    
    int btnNumber = self.subviews.count;
    for (int i = 0; i < btnNumber; i++ ) {
        
        UIView *btn = self.subviews[i];
        
        CGFloat x = i * w;
        btn.frame = CGRectMake(x, y , w, h);
    }
    
}
///**************************************        **************************************
- (void)press:(ZCNoHighLightBtn *)button
{
    NSLog(@"%s", __func__);
    if ([self.delegate respondsToSelector:@selector(tabBarView:didSelectedButton:)]) {
        [self.delegate tabBarView:self didSelectedButton:button];
    }
}

@end
