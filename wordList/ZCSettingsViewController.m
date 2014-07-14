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

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 /**&& [[NSFileManager defaultManager] fileExistsAtPath:[ZCFilePathManager unknownWordFilePath]]*/) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
        
        [self.view addSubview:hud];
        [hud showAnimated:YES whileExecutingBlock:^{
          
//            LogObj(hud);
            NSLog(@"%@", hud);
            [[NSFileManager defaultManager] removeItemAtPath:[ZCFilePathManager unknownWordFilePath] error:nil];
            sleep(2);
        } completionBlock:^{
            
            [hud removeFromSuperview];
        }];
    
        
    }
    
}

@end
