//
//  ZCWelcomeView.m
//  wordList
//
//  Created by Jason Zhou on 8/1/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCWelcomeView.h"
#import "DKCircleButton.h"
#import "ZCWelDashboardView.h"
#import "FBShimmeringView.h"

@interface ZCWelcomeView()



//@property (strong, nonatomic) FBShimmeringLayer *shimmerTextLayer;


@end


@implementation ZCWelcomeView

///**************************************    init    **************************************
- (instancetype)init
{
    self = [super init];
    if (self) {
    
//        ZCLogFunc;
    
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

//        LogFunc;
        _dashboardView = [[ZCWelDashboardView alloc] init];
        
        
//        _dashboardView.backgroundColor = [UIColor grayColor];
        
//        _slideView = 
        
        [self addSubview:_dashboardView]; 
        
//shimmer...
        
    }
    return self;
}

///**************************************  setter getter      **************************************

- (UIView *)slideView
{
    if (_slideView == nil) {
        
        _wordLabel = [[UILabel alloc] init];
        _wordLabel.text = @"Slide to start";
        _wordLabel.textColor = [UIColor whiteColor];
        //    _wordLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:18];
        _wordLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:40];
        _wordLabel.numberOfLines = 0;
        
        _wordLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _wordLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_wordLabel];

        _slideView = [[FBShimmeringView alloc] initWithFrame:self.bounds];
        
        [self addSubview:_slideView];
        
        _slideView.contentView = _wordLabel;
        _slideView.shimmeringOpacity = 0.5;
        _slideView.shimmeringPauseDuration = 0.1;
        
        _slideView.shimmeringSpeed = 150;
        
    }
    
    return _slideView;
}


- (void)layoutSubviews
{
    CGSize size = self.bounds.size;
    
    self.dashboardView.frame = CGRectMake(0, 0, size.width, size.height * 0.77f);
    
    self.slideView.frame = CGRectMake(0, size.height * 0.73f, size.width, size.height*0.25f);

//    NSLog(@"%@", self.subviews);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
