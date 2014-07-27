//
//  ZCbBaiscViewController.m
//  wordList
//
//  Created by Jason Zhou on 7/18/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCbBaiscViewController.h"

@implementation ZCbBaiscViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"screen"];
    [self.view addSubview:imageView];
    
}
@end
