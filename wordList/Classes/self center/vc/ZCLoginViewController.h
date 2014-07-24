//
//  ZCLoginViewController.h
//  wordList
//
//  Created by Jason Zhou on 7/24/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCLoginViewController;

@protocol ZCLoginViewControllerDelegate <NSObject>

- (void)loginDone:(ZCLoginViewController *)login withName:(NSString *)name andPassword:(NSString *)password;

@end


@interface ZCLoginViewController : UIViewController

@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *password;


@property (nonatomic, weak) id <ZCLoginViewControllerDelegate> myDelegate;

@end
