//
//  ZCWord.h
//  wordList
//
//  Created by Jason Zhou on 7/25/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCWord : NSObject

@property (nonatomic, copy) NSString * spelling;

@property (nonatomic, copy) NSString * meaning;

@property (nonatomic, copy) NSString * derivatives;

@property (nonatomic, copy) NSString * usage;

+ (instancetype)wordWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
