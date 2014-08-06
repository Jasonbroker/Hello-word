//
//  ZCTabBarView.m
//  wordList
//
//  Created by Jason Zhou on 7/19/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCTabBarView.h"
#import "ZCNoHighLightBtn.h"
#import "UIImage+Tools.h"

@interface ZCTabBarView()

@property (nonatomic, strong) NSArray *imageNames;

@property (nonatomic, strong) NSArray *selectedImageNames;



@property (nonatomic, weak) ZCNoHighLightBtn *selectedBtn;
@end

@implementation ZCTabBarView
///**************************************   init view     **************************************
+ (instancetype)tabBarViewWithImageSet:(NSArray *)image andHighLightedImageSet:(NSArray *)selectedImage frame:(CGRect)frame
{
    
    
//    ZCLogFunc;
    ZCTabBarView *tabBarView = [[ZCTabBarView alloc] initWithFrame:frame];
//    tabBarView.backgroundColor = [UIColor redColor];
    
    tabBarView.imageNames = image;
    tabBarView.selectedImageNames = selectedImage;
    
    [tabBarView initTabBarbtn];
    
//    [tabBarView setTabBarBackground];


    return tabBarView;
}

+ (instancetype)tabBarViewWithImage:(NSString *)image andSelectedImage:(NSString *)selectedImage frame:(CGRect)frame AndItemNumber:(int)itemNumber
{
//    ZCLogFunc;

    ZCTabBarView *tabBarView = [[ZCTabBarView alloc] initWithFrame:frame];
    
    UIImage *bigNormalImage = [UIImage imageNamed:image];
    
    UIImage *bigSelectedImage = [UIImage imageNamed:selectedImage];
    
//    CGFloat screenScale = [UIScreen mainScreen].scale;
    
    CGFloat imageW = bigNormalImage.size.width / itemNumber;
    CGFloat imageH = bigNormalImage.size.height;
    
    for (int i = 0; i <itemNumber; i ++) {
        
        ZCNoHighLightBtn *btn = [ZCNoHighLightBtn buttonWithType:UIButtonTypeCustom];
        //        sett background
        CGRect itemRect = CGRectMake(i*imageW, 0, imageW, imageH);
        
        
        
        [btn setImage:[bigNormalImage createImageWithRect:itemRect] forState:UIControlStateNormal];
        
        [btn setImage:[bigSelectedImage createImageWithRect:itemRect] forState:UIControlStateSelected];
        
        btn.tag = i;
        
        [tabBarView addSubview:btn];
        
        if (tabBarView.subviews.count == 1) {
            
            [tabBarView press:btn];
        }
        
        [btn addTarget:tabBarView action:@selector(press:) forControlEvents:UIControlEventTouchDown];
        
    }
    
    [tabBarView setNeedsLayout];

    return tabBarView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
//    ZCLogFunc;
    self = [super initWithFrame:frame];
    
    if (self) {
        
    }
    return self;
}

- (void)initTabBarbtn
{
        NSInteger btnNumber = self.imageNames.count;
    
    for (int i = 0; i < btnNumber; i ++) {
        
        ZCNoHighLightBtn *btn = [ZCNoHighLightBtn buttonWithType:UIButtonTypeCustom];
//        sett background
        [btn setBackgroundImage:[UIImage imageNamed: (NSString *)self.imageNames[i]] forState:UIControlStateNormal];
        
        [btn setBackgroundImage:[UIImage imageNamed: (NSString *)self.selectedImageNames[i]] forState:UIControlStateSelected];
        
        btn.tag = i;
        
        [self addSubview:btn];
        
        if (self.subviews.count == 1) {
            
            [self press:btn];
        }
        
        [btn addTarget:self action:@selector(press:) forControlEvents:UIControlEventTouchDown];
    }

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    ZCLogFunc;
    
    CGFloat y = 0;
    
    CGFloat w = self.bounds.size.width/self.subviews.count;
    
    CGFloat h = self.bounds.size.height;
    
    NSInteger btnNumber = self.subviews.count;
    for (int i = 0; i < btnNumber; i++ ) {
        
        UIView *btn = self.subviews[i];
        
        CGFloat x = i * w;
        btn.frame = CGRectMake(x, y , w, h);
    }
    
}
///**************************************   press     **************************************
- (void)press:(ZCNoHighLightBtn *)button
{
    if(self.selectedBtn == button) return;
    
    if ([self.delegate respondsToSelector:@selector(tabBarView:didSelectedButton:)]) {
        [self.delegate tabBarView:self didSelectedButton:button];
    }
    
    self.selectedBtn.selected = NO;
    
    button.selected = YES;
    
//    ZCLog(@"%d", button.tag);
    
    self.selectedBtn = button;
    
}

@end












