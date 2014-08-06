//
//  ZCWordsView.h
//  wordList
//
//  Created by Jason Zhou on 7/31/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCFireworksButton.h"
@class ZCWordsView;


@protocol ZCWordViewDelegate <NSObject>

- (void)add2WordList;

@end

@interface ZCWordsView : UIView

@property (strong, nonatomic) UITextView *spellingView;

@property (strong, nonatomic) UITextView *detailsView;

@property (nonatomic, strong) MCFireworksButton *addBtn;

/// add btn delegate;
@property (nonatomic, weak) id myDelegate;

@end
