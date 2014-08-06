//
//  ZCWordsView.m
//  wordList
//
//  Created by Jason Zhou on 7/31/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCWordsView.h"
#import "MCFireworksButton.h"
//#import "ZCDataCenter.h"

@interface ZCWordsView()

@property (nonatomic, strong) NSString *spelling;

@property (nonatomic, strong) NSString *meaning;

@end

@implementation ZCWordsView
///**************************************   getter     **************************************

//- (void)setSpelling:(NSString *)spelling
//{
//    
//        _spelling = self.spellingView.text;
//    
//}
//
//- (void)setMeaning:(NSString *)meaning
//{
//        _meaning = self.detailsView.text;
//    
//}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUp];
    }
    return self;
}

-(void)layoutSubviews
{
    self.spellingView.frame = CGRectMake(0, 30, self.frame.size.width, 120);
    
    self.detailsView.frame = CGRectMake(0, 180, self.frame.size.width, 280);
    
    self.addBtn.frame = CGRectMake(0, 0, 60, 60);
    
    ZCLog(@"......hah%@", NSStringFromCGPoint(self.center));
    self.addBtn.center = CGPointMake(self.bounds.size.width *0.84f, 5);
}


-(void)setUp
{
    [self detailsView];
    [self spellingView];
    [self addBtn];
    
    
    self.backgroundColor = [UIColor clearColor];
    
    
}
///**************************************    getter    **************************************
- (UITextView *)spellingView
{
    if (_spellingView == nil) {
        _spellingView = [[UITextView alloc] init];
        [self addSubview:self.spellingView];
        _spellingView.backgroundColor = [UIColor clearColor];
        _spellingView.textColor = [UIColor whiteColor];
        _spellingView.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:48.0f];
//        [_spellingView sizeToFit];
        
        _spellingView.editable = NO;
        _spellingView.scrollEnabled = NO;
//        _spellingView.selectable= NO;
        _spellingView.textAlignment = NSTextAlignmentCenter;
    }
    return _spellingView;
}
- (UITextView *)detailsView
{
    if (_detailsView == nil) {
        _detailsView = [[UITextView alloc] init];
        [self addSubview:_detailsView];
        
        _detailsView.backgroundColor = [UIColor clearColor];
        _detailsView.textColor = [UIColor whiteColor];
        _detailsView.font = [UIFont systemFontOfSize:17.0f];
        _detailsView.textContainerInset = UIEdgeInsetsMake(15, 15, 0, 10);
        _detailsView.contentMode = UIViewContentModeCenter;
//        _detailsView.textAlignment = NSTextAlignmentCenter;
        _detailsView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _detailsView.editable = NO;
//        _detailsView.selectable = NO;
        
    }
    return _detailsView;
}



- (MCFireworksButton *)addBtn{
    if (_addBtn == nil) {
        
        _addBtn = [[MCFireworksButton alloc] init];
        
        [self addSubview:_addBtn];
//        _addBtn.backgroundColor = [UIColor greenColor];
        [_addBtn setTitle:@"+" forState:UIControlStateNormal];
        [_addBtn setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
        
        _addBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:40.0f];
        _addBtn.particleImage = [UIImage imageNamed:@"Sparkle"];
        _addBtn.particleScale = 0.05;
        _addBtn.particleScaleRange = 0.05;

        
        [_addBtn addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    return _addBtn;
}


- (void)add:(MCFireworksButton *)btn
{
    [btn popOutsideWithDuration:0.5];
//    LogFunc;

    [btn animate];
    if ([self.myDelegate respondsToSelector:@selector(add2WordList)
        ]) {
        [self.myDelegate add2WordList];
    }
}


@end























