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

@interface ZCSettingsViewController ()<UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITableViewCell *reset;

@end

@implementation ZCSettingsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - delegate method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        UIActionSheet *reset = [[UIActionSheet alloc] initWithTitle:@"RESET will wipe all your data!" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:@"RESET" otherButtonTitles:nil];
        
        [reset showInView:self.view];
    }

}

#pragma mark - reset data
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
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
    
    }
    
}

@end
