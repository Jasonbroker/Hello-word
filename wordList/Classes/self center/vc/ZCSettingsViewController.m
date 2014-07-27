//
//  ZCSettingsViewController.m
//  wordList
//
//  Created by Jason Zhou on 7/11/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCSettingsViewController.h"
#import "ZCFilePathManager.h"
#import "MBProgressHUD.h"
#import "Common.h"
#import "ZCsettingCell.h"

static NSString *settingID = @"settingIdentifier";

@interface ZCSettingsViewController ()<UIActionSheetDelegate, UITabBarControllerDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSArray *dataList;

@end

@implementation ZCSettingsViewController

///**************************************    life circle    **************************************
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerClass:[ZCsettingCell class] forCellReuseIdentifier:settingID];
    
}

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

///**************************************    setter getter    **************************************
- (void)setPlistName:(NSString *)plistName
{
    _plistName = plistName;
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:plistName withExtension:nil];
    
    self.dataList = [NSArray arrayWithContentsOfURL:url];
    
}
///**************************************    datasource    **************************************
#pragma mark number of section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataList.count;
}


#pragma mark number of rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataList[section] count];
}

#pragma mark 每一行显示怎样的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCsettingCell *cell = [tableView dequeueReusableCellWithIdentifier:settingID forIndexPath:indexPath];
    
    // 2.缓存池没有cell，重新创建cell
    if (cell == nil) {
        cell = [[ZCsettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingID];
    }
    
    // 3.传递模型数据
    NSDictionary *dict = self.dataList[indexPath.section][indexPath.row];
    
    cell.dataList = dict;

    return cell;
}

#pragma mark - delegate method
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}




///**************************************    delegate    **************************************
#pragma mark - delegate method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSDictionary *dict = self.dataList[indexPath.section][indexPath.row];
    
//  push vc..
    if ([dict valueForKey:@"push"]) {
        
        Class class = NSClassFromString([dict valueForKey:@"push"]);
        
        UIViewController *vc = [[class alloc] init];
        
        vc.title = dict[@"title"];
        
        vc.view.backgroundColor = [UIColor whiteColor];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
//     action
    
    if ([dict valueForKey:@"callFunction"]) {
        SEL func = NSSelectorFromString([dict valueForKey:@"callFunction"]);
        
        if ([self respondsToSelector:func]) {
            
# pragma clang diagnostic push
# pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:func];
# pragma clang diagnostic pop
        }
    }
}
///**************************************    actions    **************************************
- (void)numNeedLearn
{
#warning wait for update
    NSLog(@"wait for update");
}

- (void)reset
{
            UIActionSheet *resetSheet = [[UIActionSheet alloc] initWithTitle:@"RESET will wipe all your data!" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:@"RESET" otherButtonTitles:nil];
    
            [resetSheet showInView:self.view];

}

- (void)logout
{
#warning wait for update
    
    NSLog(@"wait for update");
    
    
}


#pragma mark - reset data
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
      
        [[NSFileManager defaultManager] removeItemAtPath:[ZCFilePathManager unknownWordFilePath] error:nil];
        
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:hud];
//        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
//        [self.view addSubview:hud];
        // The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
        // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        
        // Set custom view mode
        hud.mode = MBProgressHUDModeCustomView;
        
        hud.labelText = @"Data Reset !";
        
        [hud show:YES];
        
        [hud hide:YES afterDelay:3];
        
        hud.removeFromSuperViewOnHide = YES;
    
    }
    
}

@end
