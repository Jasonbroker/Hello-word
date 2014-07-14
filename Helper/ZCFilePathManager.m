//
//  ZCFilePath.m
//  wordList
//
//  Created by Jason Zhou on 7/12/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCFilePathManager.h"
#import "NSString+Path.h"

@implementation ZCFilePathManager

+ (NSString *)unknownWordFilePath
{

     NSString *unknownWords = [@"unKonwnWords.plist" appendDocumentPath];
    
    return unknownWords;
}



@end
