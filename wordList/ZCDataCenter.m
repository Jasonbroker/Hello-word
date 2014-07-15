//
//  ZCDataCenter.m
//  wordList
//
//  Created by Jason Zhou on 7/13/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCDataCenter.h"
#import "ZCFilePathManager.h"

@implementation ZCDataCenter

- (NSMutableArray *)unknownWords
{
    if (!_unknownWords) {
        _unknownWords = [NSMutableArray arrayWithContentsOfFile:[ZCFilePathManager unknownWordFilePath]];
        if (_unknownWords == nil) {
            _unknownWords = [NSMutableArray array];
        }
    }
        return _unknownWords;
}

- (void)dealloc
{
    NSLog(@"dealloc");
}

@end
