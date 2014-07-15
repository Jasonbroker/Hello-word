//
//  Words.h
//  wordList
//
//  Created by Jason Zhou on 7/14/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Word;

@interface Words : NSManagedObject

@property (nonatomic, retain) NSNumber * wordsReadNum;
@property (nonatomic, retain) NSNumber * unknownWordsNum;
@property (nonatomic, retain) Word *word;

@end
