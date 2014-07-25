//
//  ZCSelfInfoView.h
//  wordList
//
//  Created by Jason Zhou on 7/23/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZCSelfInfoView;

@protocol ZCSelfInfoViewDelgate <NSObject>

-(void)viewloginOrRegister:(ZCSelfInfoView *)selfInfoView;


@end

@interface ZCSelfInfoView : UIView
@property (weak, nonatomic) IBOutlet UIView *iconView;
- (IBAction)Login:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *wordsLearned;
@property (weak, nonatomic) IBOutlet UILabel *wordsRemaining;
@property (weak, nonatomic) IBOutlet UILabel *unknownWords;

@property id <ZCSelfInfoViewDelgate> myDelegate;
//  for init
+ (instancetype)selfInfoView;

@end
