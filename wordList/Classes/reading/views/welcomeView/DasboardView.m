//
//  dasboardView.m
//  dashboard
//
//  Created by Jason Zhou on 8/5/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "DasboardView.h"

@interface DasboardView()

@property (nonatomic, weak) CALayer *whiteLayer;

@property (nonatomic, strong)CALayer *mainPointer;

@property (nonatomic, weak) CALayer *simplePointer;
@end

@implementation DasboardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        LogFunc;
        
        [self mainPionter];
//        [self simplePointer];
    }
    return self;

}

///**************************************        **************************************

- (CALayer *)simplePointer
{
    if (_simplePointer == nil) {
        
        CALayer *simplePointer = [[CALayer alloc] init];
        
        simplePointer.bounds = CGRectMake(0, 0, self.bounds.size.width-5.0f, 1.5f);
        
        simplePointer.anchorPoint = CGPointMake(1, 0.5f);
        simplePointer.position = CGPointMake(self.frame.size.width * 0.5f, self.frame.size.height);
        
        simplePointer.cornerRadius = 1.0f;
        
        [self.layer addSublayer:simplePointer];
        
        _simplePointer = simplePointer;
        
        
    }
    return  _simplePointer;
}

- (UIView *)mainPionter
{
    if (_mainPionter == nil) {
        _mainPionter = [[UIView alloc] init];
        
//        _whiteLayer.bounds = CGRectMake(0, 0, _mainPionter.bounds.size.width, _mainPionter.bounds.size.height);
        
        _mainPionter.bounds = CGRectMake(0, 0, self.frame.size.height - 50.0f, 2.0f );
        _mainPionter.layer.anchorPoint = CGPointMake(1, 0.5);
        
        _mainPionter.layer.position = CGPointMake(self.frame.size.width *0.5f, self.frame.size.height);
        
        _mainPionter.layer.cornerRadius= 1.0f;
        
//        UIView *whiteView = [[UIView alloc] init];
//        whiteView.bounds = CGRectMake(0, 0, _mainPionter.frame.size.width*0.5, _mainPionter.frame.size.height);
//            whiteView.bounds = CGRectMake(0, 0, 90, _mainPionter.frame.size.height);
//        
//        [_mainPionter addSubview:whiteView];
//        whiteView.backgroundColor = [UIColor whiteColor];
        _mainPionter.backgroundColor = [UIColor redColor];
        [self addSubview:_mainPionter];

        
            }
    return _mainPionter;
}



- (void)showDashboardAnimationWithOriginalAngle:(CGFloat)orignalAngle Rotation:(CGFloat)ToAngle after:(CGFloat)afterTime animateWithDuration:(CGFloat)duration delay:(CGFloat)delay
{
//    set original angle.
    _mainPionter.transform = CGAffineTransformMakeRotation(orignalAngle);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(afterTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseOut animations:^{
            _mainPionter.transform = CGAffineTransformMakeRotation(ToAngle + 0.5 * M_PI_4);
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.8f delay:0.1f options: UIViewAnimationOptionCurveEaseOut animations:^{
                _mainPionter.transform = CGAffineTransformMakeRotation(ToAngle);

            } completion:nil];
        }];
    });
    
    
}

- (void)layoutSubviews
{

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
