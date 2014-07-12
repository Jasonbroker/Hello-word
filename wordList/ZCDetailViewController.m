//
//  ZCDetailViewController.m
//  wordList
//
//  Created by Jason Zhou on 7/10/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCDetailViewController.h"

@interface ZCDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;

@end

@implementation ZCDetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



@end
