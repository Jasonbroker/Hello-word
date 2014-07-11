//
//  ZCSettingsViewController.m
//  wordList
//
//  Created by Jason Zhou on 7/11/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCSettingsViewController.h"

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
    UIActionSheet *reset = [[UIActionSheet alloc] initWithTitle:@"RESET will wipe all your data!" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:@"RESET" otherButtonTitles:nil];

    [reset showInView:self.view];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
    }
}

@end
