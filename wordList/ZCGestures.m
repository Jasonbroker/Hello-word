//
//  ZCGestures.m
//  wordList
//
//  Created by Jason Zhou on 7/16/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCGestures.h"

@interface ZCGestures()

@end

@implementation ZCGestures

- (void)addSwipeGesture:(UISwipeGestureRecognizer *)recognizer inView:(UIView *)view
{
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe)];
    
    [view addGestureRecognizer:swipeRight];
    [view addGestureRecognizer:swipeLeft];
    
}

- (void)swipe
{

}

- (void)addTapGesture:(UISwipeGestureRecognizer *)recognizer
{
    
}


@end
