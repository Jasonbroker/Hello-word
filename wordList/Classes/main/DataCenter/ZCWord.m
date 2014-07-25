//
//  ZCWord.m
//  wordList
//
//  Created by Jason Zhou on 7/25/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCWord.h"

@implementation ZCWord


- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+ (instancetype)wordWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}




@end
