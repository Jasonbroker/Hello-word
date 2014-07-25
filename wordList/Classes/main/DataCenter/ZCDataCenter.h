//
//  ZCDataCenter.h
//  wordList
//
//  Created by Jason Zhou on 7/25/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@property (nonatomic, assign) int userReadingProgressMarker;

@property (nonatomic, assign) int userMaxReadingProgressMarker;


@end
