//
//  ZCDataCenter.m
//  wordList
//
//  Created by Jason Zhou on 7/25/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCDataCenter.h"
#import "ZCWord.h"
#import "Common.h"
#import "ZCFilePathManager.h"
@implementation ZCDataCenter

static id instance;
+ (ZCDataCenter *)sharedData
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZCDataCenter alloc] init];
    });
    return instance;
}


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
        

        
        if ([[NSFileManager defaultManager] fileExistsAtPath:[ZCFilePathManager unknownWordFilePath]]) {
 
#warning        test here..
            NSLog(@"read unknownwords");
            

            _unknownWords = [NSKeyedUnarchiver unarchiveObjectWithFile:[ZCFilePathManager unknownWordFilePath]];
            
            
        }else{
            
            NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:0];
            
            _unknownWords = arrayM;
        }
        
        return _unknownWords;
        
    }
    
    return _unknownWords;
}


- (NSInteger)userMaxReadingProgressMarker
{
    
    if (_userMaxReadingProgressMarker == 0 ) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        _userMaxReadingProgressMarker = [[defaults objectForKey:KUserMaxReadingProgressMarkerKey] integerValue];
        
    }
    return _userMaxReadingProgressMarker;
}

- (NSInteger)userReadingProgressMarker
{
    if (_userReadingProgressMarker == 0) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        _userReadingProgressMarker = [[defaults objectForKey:KUserReadingProgressMarkerKey] integerValue];
        
    }
    return 0;
}



@end
