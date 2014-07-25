//
//  ZCSelfCenterViewController.m
//  wordList
//
//  Created by Jason Zhou on 7/22/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCSelfCenterViewController.h"
#import "ZCSelfInfoView.h"
#import "ZCSettingsViewController.h"
#import "ZCLoginViewController.h"

@interface ZCSelfCenterViewController ()<ZCSelfInfoViewDelgate, ZCLoginViewControllerDelegate>

// self info
@property (nonatomic, strong)ZCSelfInfoView *selfInfoView;

@property (nonatomic, strong)CALayer *graphic;
@end

@implementation ZCSelfCenterViewController

///**************************************   life circle     **************************************
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"self center";

    [self.view addSubview:self.selfInfoView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStyleBordered target:self action:@selector(pushSetting:)];
    
    self.selfInfoView.myDelegate = self;

}

-(void)viewWillLayoutSubviews
{
    self.selfInfoView.translatesAutoresizingMaskIntoConstraints = NO;
    id topGuide = self.topLayoutGuide;
    
    NSDictionary *dict = NSDictionaryOfVariableBindings(_selfInfoView, topGuide);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat: @"H:|-0-[_selfInfoView]-0-|"options:0 metrics:nil views:dict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topGuide]-[_selfInfoView(150)]" options:0 metrics:nil views:dict]];
    

}

///**************************************    setter getter    **************************************

// load from nib...
- (ZCSelfInfoView *)selfInfoView
{
    if (_selfInfoView == nil) {
        
        _selfInfoView = [ZCSelfInfoView selfInfoView];
    }
    return _selfInfoView;
}

- (void)pushSetting:(UIBarButtonItem *)sender
{
    ZCSettingsViewController *settingVC = [[ZCSettingsViewController alloc] init];
    
    settingVC.plistName = @"setting.plist";
    
    settingVC.title = @"settings";
    
    [self.navigationController pushViewController:settingVC animated:YES];
}


///**************************************   delegate implementation     **************************************

- (void)viewloginOrRegister:(ZCSelfInfoView *)selfInfoView
{
    NSLog(@" will log....");
    
    ZCLoginViewController *loginVC = [[ZCLoginViewController alloc] init];
    
    
    [self presentViewController: loginVC animated:YES completion:^{
        loginVC.myDelegate = self;

    }];
}

//   dismiss
- (void)loginDone:(ZCLoginViewController *)login withName:(NSString *)name andPassword:(NSString *)password
{
    NSLog(@"%@", name);
    NSLog(@"%@", password);
    NSLog(@"%@", login.name);
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
