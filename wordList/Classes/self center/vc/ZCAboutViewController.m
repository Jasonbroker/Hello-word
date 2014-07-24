//
//  ZCAboutViewController.m
//  wordList
//
//  Created by Jason Zhou on 7/24/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCAboutViewController.h"

@interface ZCAboutViewController ()
@property (nonatomic, strong)UIImageView *about;

@end

@implementation ZCAboutViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    }

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.about = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weibo"]];
    
    [self.view addSubview:_about];
    
//    self.about.backgroundColor = [UIColor redColor];

}

- (void)viewWillLayoutSubviews
{
    self.about.translatesAutoresizingMaskIntoConstraints =NO;
    
    id myTop = self.topLayoutGuide;
//    self rightLayoutGuide.righ
    NSDictionary *dict = NSDictionaryOfVariableBindings(_about, myTop);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_about]-0-|" options:0 metrics:nil views:dict]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[myTop]-[_about]" options:0 metrics:nil views:dict]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
