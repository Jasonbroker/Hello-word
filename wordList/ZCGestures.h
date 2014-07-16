//
//  ZCGestures.h
//  wordList
//
//  Created by Jason Zhou on 7/16/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCGestures : NSObject
/** 
 *  swip left and swipe right to change the page
 */
- (void)addSwipeGesture:(UISwipeGestureRecognizer *)recognizer;

- (void)addTapGesture:(UISwipeGestureRecognizer *)recognizer;



@end
