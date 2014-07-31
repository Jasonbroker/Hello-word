//
//  ZCWord.h
//  wordList
//
//  Created by Jason Zhou on 7/25/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCWord : NSObject<NSCoding>

/**
 the word itself
 */
@property (nonatomic, copy) NSString * spelling;

// this part contains the pronaciation and the meanning if needed
@property (nonatomic, copy) NSString * meaning;

/**
 this two parts can be put together.
 */
@property (nonatomic, copy) NSString * derivatives;

@property (nonatomic, copy) NSString * usage;

/**
 init method
 */
+ (instancetype)wordWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
