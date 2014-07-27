//
//  ZCDataCenter.h
//  wordList
//
//  Created by Jason Zhou on 7/25/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface ZCDataCenter : NSObject
/**
 the array contains a dictionary
 
    dictionary
 -----------------
 wordName:
 
 pronaciation:
 
 translation:
 
 explaination:......
 ------------------
 
 */

@property (nonatomic, strong) NSArray *words;

/** contains dictionarys which user added */
@property (nonatomic, strong) NSMutableArray *unknownWords;

@property (nonatomic, assign) NSInteger userReadingProgressMarker;

@property (nonatomic, assign) NSInteger userMaxReadingProgressMarker;

@property (nonatomic, assign) BOOL wordIsAdded;


//single_h(ZCDataCenter)
+ (ZCDataCenter *)sharedData;



@end
