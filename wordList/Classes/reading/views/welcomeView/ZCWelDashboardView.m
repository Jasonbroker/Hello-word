//
//  ZCWelDashboardView.m
//  wordList
//
//  Created by Jason Zhou on 8/1/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCWelDashboardView.h"
#import "DKCircleButton.h"
#import "DasboardView.h"

@interface ZCWelDashboardView()

//@property (nonatomic, weak) CALayer *whiteLayer;

//@property (nonatomic, strong)UIView *mainPointer;

@property (nonatomic, strong) DasboardView *dashboard;
    
@end

@implementation ZCWelDashboardView

- (instancetype)init
{
    self = [super init];
    if (self) {
//        LogFunc;
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        LogFunc;

        _dashboard = [[DasboardView alloc] initWithFrame:CGRectMake(0 , 0, 320, 150)];
//
        [self addSubview:_dashboard];
        
    [_dashboard showDashboardAnimationWithOriginalAngle:0.5*M_PI_4 Rotation:3*M_PI_4 after:0.5f animateWithDuration:0.5f delay:0.0f];
        [self setUpBtn];
    }
    return self;
}

- (void)layoutSubviews
{
    self.readModeBtn.center = CGPointMake(110, self.bounds.size.height * 0.9f);
    self.testModeBtn.center = CGPointMake(210, self.bounds.size.height * 0.9f);
    
    _dashboard.frame = CGRectMake(0 , self.frame.size.height* 0.3f, 320, 150);
}
#warning set up dash board here...

//- (void)

//- (UIView *)mainPointer
//{
//    if (_mainPointer == nil) {
//        _mainPointer = [[UIView alloc] init];
//        
//        _whiteLayer.bounds = CGRectMake(0, 0, _mainPointer.bounds.size.width, _mainPointer.bounds.size.height);
//        
//        //        _mainPionter.backgroundColor = [UIColor whiteColor];
//        
//        _mainPointer.bounds = CGRectMake(0, 0, self.frame.size.height - 55.0f, 2.0f );
//        _mainPointer.layer.anchorPoint = CGPointMake(1, 0.5);
//        
//        _mainPointer.layer.position = CGPointMake(self.frame.size.width *0.5f, self.frame.size.height);
//        
//        _mainPointer.layer.cornerRadius= 1.0f;
//        
//        UIView *whiteView = [[UIView alloc] init];
//        whiteView.bounds = CGRectMake(0, 0, _mainPointer.frame.size.width*0.5, _mainPointer.frame.size.height);
//        whiteView.bounds = CGRectMake(0, 0, 90, _mainPointer.frame.size.height);
//        
//        [_mainPointer addSubview:whiteView];
//        whiteView.backgroundColor = [UIColor whiteColor];
//        
//        [self addSubview:_mainPointer];
//        
//        
//    }
//    return _mainPointer;
//}

///**************************************  getter setter      **************************************
- (DKCircleButton *)readModeBtn
{
    if (_readModeBtn== nil) {
        _readModeBtn = [DKCircleButton circleButtonWithSize:CGSizeMake(60, 60) borderSize:1.5f normalTitle:@"Learn" addTarget:self action:@selector(modeBtnClick:) animated:YES];
    }
    return _readModeBtn;
}

- (DKCircleButton *)testModeBtn
{
    if (_testModeBtn == nil) {
        _testModeBtn = [DKCircleButton circleButtonWithSize:CGSizeMake(60, 60) borderSize:1.5f normalTitle:@"Test" addTarget:self action:@selector(modeBtnClick:) animated:YES];
    }
    return _testModeBtn;
}


- (void)setUpBtn
{
//    btn 1 
    [self readModeBtn];
    
    self.readModeBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    
    [_readModeBtn selectedWithAnimation:NO];
    
    [self addSubview:_readModeBtn];
//    btn 2
    [self testModeBtn];
    
    [self.testModeBtn setTitle:@"Test" forState:UIControlStateNormal];
    self.testModeBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    [self addSubview:_testModeBtn];

}


///**************************************   button actions     **************************************

- (void)modeBtnClick:(DKCircleButton *)btn
{
    if(btn.selected) return;
    if (btn == self.readModeBtn) {
        [_readModeBtn selectedWithAnimation:YES];
        [_testModeBtn deselected];
    }else{
        [_testModeBtn selectedWithAnimation:YES];
        [_readModeBtn deselected];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
