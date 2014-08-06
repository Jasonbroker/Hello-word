//
//  ZCDetailViewController.m
//  wordList
//
//  Created by Jason Zhou on 7/10/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCDetailViewController.h"
#import "ZCUIColor+Extension.h"

@interface ZCDetailViewController ()



@end

@implementation ZCDetailViewController

- (void)loadView
{
    ZCLog(@"%s", __func__);
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.wordLabel = [[UILabel alloc] init];
    
    self.wordLabel.numberOfLines = 0;
    
    self.wordLabel.textColor = [UIColor iOS7Blue];
    self.wordLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    
    [self.view addSubview:self.wordLabel];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ZCLog(@"%s", __func__);
}


- (void)viewWillLayoutSubviews
{
        ZCLog(@"%s", __func__);
    self.wordLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *dict = NSDictionaryOfVariableBindings(_wordLabel);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-200-[_wordLabel]" options:0 metrics:nil views:dict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[_wordLabel]-50-|" options:0 metrics:nil views:dict]];
    
//    this can be set up before push
    self.wordLabel.text = self.word.spelling;
    
//    test
    ZCLog(@"%@, %@", self.word.derivatives, self.word.meaning);
}




@end
