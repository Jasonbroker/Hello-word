//
//  ZCDataCenter.m
//  wordList
//
//  Created by Jason Zhou on 7/25/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCDataCenter.h"
#import "ZCWord.h"
@implementation ZCDataCenter


- (NSArray *)words
{
    
    if (_words == nil) {
        
//        NSArray *wordsFromPlist = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:@"wordsData.plist"]];
        
        NSArray *wordsFromPlist = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wordsData.plist" ofType:nil]];
#warning try arraywithCapacity;
        NSMutableArray *wordsM = [NSMutableArray array];
        
        for (NSDictionary *dict in wordsFromPlist) {
            
            ZCWord *word = [ZCWord wordWithDict:dict];
            
            [wordsM addObject:word];

        }
        
        _words = wordsM;
    
    }
    
    return  _words;
}

@end
