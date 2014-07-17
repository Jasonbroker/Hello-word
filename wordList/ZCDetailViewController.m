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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.wordLabel.text = self.word;
    
    
//    self.navigationController.hidesBottomBarWhenPushed = YES;
}


@end
