//
//  ZCScheduleTableViewController.m
//  wordList
//
//  Created by Jason Zhou on 7/7/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCScheduleTableViewController.h"
#import "ZCScheduleDetailController.h"
#import "ZCFilePathManager.h"
#import "Common.h"
#import "ZCRootController.h"

//test
#import "UIERealTimeBlurView.h"


@interface ZCScheduleTableViewController ()

@property (nonatomic, strong)NSDictionary *wordLines;

@property (nonatomic, strong)ZCRootController *rootVC;

@property (nonatomic, assign)int userMaxReadProgressNum;

@end

@implementation ZCScheduleTableViewController

///**************************************   life cricle     **************************************
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _userMaxReadProgressNum = self.rootVC.userMaxReadingProgressMarker;
    
    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    
//    UIERealTimeBlurView *blurView = [[UIERealTimeBlurView alloc] initWithFrame:CGRectMake(0, 110, 200, 200)];
//    
//    [self.navigationController.view addSubview:blurView];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
//    NSLog(@"%s", __func__);
}


- (void)viewDidDisappear:(BOOL)animated
{
    
//    self.tabBarController.tabBar.hidden = NO;
    
    if (_userMaxReadProgressNum != self.rootVC.userMaxReadingProgressMarker) {
        _userMaxReadProgressNum = self.rootVC.userMaxReadingProgressMarker;
        NSLog(@"reload data");
        [self.tableView reloadData];
    }
    
}


///**************************************   getter     **************************************
- (NSDictionary *)wordLines
{
    if (!_wordLines) {
                NSLog(@"%s.....", __func__);
        NSString *path = [ZCFilePathManager wordsFilePath];

        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            
            NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
            _wordLines = dict;
        }else{
            NSLog(@"ERROR at %@.....", path);
        }
    }

    return _wordLines;
}

- (ZCRootController *)rootVC   /**datacenter*/
{
    if (!_rootVC) {
        _rootVC = (ZCRootController *)[[UIApplication sharedApplication].windows[0] rootViewController];
    }
    return _rootVC;
}

///**************************************   data source     **************************************
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return self.wordLines.count/KwordInSection + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *identifier = @"scheduleCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat: @"Section %d", indexPath.section +1];;
    
//    (_userMaxReadProgressNum/KwordInSection > indexPath.section) ? (cell.detailTextLabel.text = @"已读完") : (cell.detailTextLabel.text = @"未读");
    // Configure the cell...
    if(_userMaxReadProgressNum/KwordInSection < indexPath.section)
    {
        cell.detailTextLabel.text = @"未读";
    }else if(_userMaxReadProgressNum/KwordInSection == indexPath.section){
        cell.detailTextLabel.text = @"Reading";
    }else{
        cell.detailTextLabel.text = @"已读";

    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//}

///**************************************    delegate    **************************************

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZCScheduleDetailController *scheduleDetailVC = [[ZCScheduleDetailController alloc] init];
    
    [self.navigationController pushViewController:scheduleDetailVC animated:YES];
    
    scheduleDetailVC.sectionNum = indexPath.section;
}



///**************************************        **************************************

/**
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        ZCScheduleDetailController *detailVC = segue.destinationViewController;
    
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
        detailVC.sectionNum = indexPath.section;
    
//        NSLog(@"%@", @(indexPath.section));
//    NSLog(@"%@", NSStringFromCGRect(detailVC.tabBarController.tabBar.frame));

}
*/

@end
