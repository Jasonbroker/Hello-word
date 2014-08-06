//
//  CALayer+Animation.m
//  wordList
//
//  Created by Jason Zhou on 8/5/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "CALayer+Animation.h"

@implementation CALayer (Animation)

- (void)shake
{
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    shake.fromValue = @(-0.2f);
    
    shake.toValue =  @(0.2f);
    
    shake.duration = 0.05f;
    
    
    
    shake.autoreverses = YES;
    
    shake.repeatCount = 8;
    
    [self addAnimation:shake forKey:nil];
}

@end
