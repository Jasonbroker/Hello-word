//
//  ZCDetailViewController.m
//  wordList
//
//  Created by Jason Zhou on 7/10/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCDetailViewController.h"

@interface ZCDetailViewController ()



@end

@implementation ZCDetailViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.wordLabel = [[UILabel alloc] init];
    
    self.wordLabel.numberOfLines = 0;
    
    [self.view addSubview:self.wordLabel];
    
//    self.wordLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
//    NSDictionary *dict = NSDictionaryOfVariableBindings(_wordLabel);
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-180-[_wordLabel]" options:0 metrics:nil views:dict]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[_wordLabel]-50-|" options:0 metrics:nil views:dict]];

}

- (void)viewWillLayoutSubviews
{
    self.wordLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *dict = NSDictionaryOfVariableBindings(_wordLabel);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-200-[_wordLabel]" options:0 metrics:nil views:dict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-80-[_wordLabel]-80-|" options:0 metrics:nil views:dict]];
}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    
//    self.wordLabel.text = self.word;
//    
//}



@end
