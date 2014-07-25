//
//  ZCSelfInfoView.m
//  wordList
//
//  Created by Jason Zhou on 7/23/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCSelfInfoView.h"

@interface ZCSelfInfoView()



@end

@implementation ZCSelfInfoView

+ (instancetype)selfInfoView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZCSelfInfoView" owner:nil options:nil] lastObject];
}



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setup
{
//    wait for adding
}



- (IBAction)Login:(UIButton *)sender {
    
    if ([self.myDelegate respondsToSelector:@selector(viewloginOrRegister:)]) {
        [self.myDelegate viewloginOrRegister:self];
    }
}
@end
