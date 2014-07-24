//
//  ZCLoginViewController.m
//  wordList
//
//  Created by Jason Zhou on 7/24/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCLoginViewController.h"

@interface ZCLoginViewController ()

@property (nonatomic, strong)UIButton *dismiss;


@end

@implementation ZCLoginViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.view.backgroundColor = [UIColor redColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dismiss = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.dismiss.backgroundColor = [UIColor yellowColor];
    
    [self.dismiss addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_dismiss];
#warning  test hrere;
    self.name = @"Jason";
    self.password = @"123";
    
    
}

- (void)viewWillLayoutSubviews
{
    _dismiss.frame = CGRectMake(150, 150, 40, 40);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///**************************************    action    **************************************
- (void)done
{
    if ([self.myDelegate respondsToSelector:@selector(loginDone:withName:andPassword:)]) {
        
        [self.myDelegate loginDone:self withName:self.name andPassword:self.password];
        
    }
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
