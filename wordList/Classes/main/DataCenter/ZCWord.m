//
//  ZCWord.m
//  wordList
//
//  Created by Jason Zhou on 7/25/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCWord.h"

#define kspelling @"spelling"
#define kderivatives @"derivatives"
#define kmeaning @"meaning"
#define kusage @"usage"

@implementation ZCWord

// encode
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_spelling forKey:kspelling];
    [encoder encodeObject:_derivatives forKey:kderivatives];
    [encoder encodeObject:_meaning forKey:kmeaning];
    [encoder encodeObject:_usage forKey:kusage];
}
/**
 decode
 */
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    
    if (self) {
        _spelling = [decoder decodeObjectForKey:kspelling];
        _derivatives = [decoder decodeObjectForKey:kderivatives];
        _meaning = [decoder decodeObjectForKey:kmeaning];
        _usage = [decoder decodeObjectForKey:kusage];
    }
    return self;
}




- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
//        [self setValuesForKeysWithDictionary:dict];
        self.spelling = [dict valueForKey:kspelling];
        self.derivatives = [dict valueForKey:kderivatives];
        self.meaning = [dict valueForKey:kmeaning];
        self.usage = [dict valueForKey:kusage];
    }
    return self;
}


+ (instancetype)wordWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}




@end
