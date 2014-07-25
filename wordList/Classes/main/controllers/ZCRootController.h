//
//  ZCRootController.h
//  wordList
//
//  Created by Jason Zhou on 7/11/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCDataCenter.h"
#import "ZCWord.h"

@interface ZCRootController : UITabBarController

//  define a data center to manage All the data

@property (nonatomic, strong) ZCDataCenter *dataCenter;


#warning will delete this code then
@property (nonatomic, assign) int userReadingProgressMarker;

@property (nonatomic, assign) int userMaxReadingProgressMarker;


@end