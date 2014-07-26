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
        
        NSArray *wordsFromPlist = [NSArray arrayWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"wordsData.plist" withExtension:nil]];
        
//        NSArray *wordsFromPlist = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wordsData.plist" ofType:nil]];

        NSMutableArray *wordsM = [NSMutableArray arrayWithCapacity:0];
        
        for (NSDictionary *dict in wordsFromPlist) {
            
            ZCWord *word = [ZCWord wordWithDict:dict];
            
            [wordsM addObject:word];

        }
        
        _words = wordsM;
    
    }
    
    return  _words;
}

- (NSMutableArray *)unknownWords
{
    if (_unknownWords == nil) {
        
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:0];
        
        _unknownWords = arrayM;
    }
    
    return _unknownWords;
}

- (int)userMaxReadingProgressMarker
{
#warning need code..
    return 0;
}

- (int)userReadingProgressMarker
{
    return 0;
}

//- (NSArray *)userMaxReadingProgressMarkerAtIndexes:(NSIndexSet *)indexes
//{
//    return [NSArray array];
//}





@end
