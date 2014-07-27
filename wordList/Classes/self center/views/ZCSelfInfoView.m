//
//  ZCSelfInfoView.m
//  wordList
//
//  Created by Jason Zhou on 7/23/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCSelfInfoView.h"

@interface ZCSelfInfoView()



@end

@implementation ZCSelfInfoView

+ (instancetype)selfInfoView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZCSelfInfoView" owner:nil options:nil] lastObject];
}



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setup
{
//    wait for adding
}

-(void)awakeFromNib
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
/**
    self.unknownWords.translatesAutoresizingMaskIntoConstraints = NO;
    self.wordsLearned.translatesAutoresizingMaskIntoConstraints = NO;
    self.wordsRemaining.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *dict1 = NSDictionaryOfVariableBindings(_unknownWords);
    NSDictionary *dict2 = NSDictionaryOfVariableBindings(_wordsLearned);
    NSDictionary *dict3 = NSDictionaryOfVariableBindings(_wordsRemaining);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_wordsLearned]-10-|" options:0 metrics:nil views:dict2]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_unknownWords]-10-|" options:0 metrics:nil views:dict1]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_wordsRemaining]-10-|" options:0 metrics:nil views:dict3]];
 */
}



- (IBAction)Login:(UIButton *)sender {
    
    if ([self.myDelegate respondsToSelector:@selector(viewloginOrRegister:)]) {
        [self.myDelegate viewloginOrRegister:self];
    }
}
@end
