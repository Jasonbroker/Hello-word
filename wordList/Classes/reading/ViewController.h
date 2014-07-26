//
//  ViewController.h
//  wordList
//
//  Created by Jason Zhou on 7/6/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ViewController;
@class ZCWords;

@protocol ZCViewControllerDelegate <NSObject>

- (void)viewController:(ViewController *)viewController AddNewWord:(NSString *)word;

@end


@interface ViewController : UIViewController

@property (nonatomic, assign) int count;

//@property (nonatomic, strong) NSArray *lineNumber;

@property (nonatomic, strong)NSArray *wordLines;



@end

