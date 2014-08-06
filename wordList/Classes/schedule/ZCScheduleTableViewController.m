//
//  ZCScheduleTableViewController.m
//  wordList
//
//  Created by Jason Zhou on 7/7/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCScheduleTableViewController.h"
#import "ZCScheduleDetailController.h"
#import "Common.h"
#import "ZCTableViewCell.h"
#import "ZCDataCenter.h"
#import "ZCWord.h"

static NSString *identifier = @"scheduleCell";

@interface ZCScheduleTableViewController ()

//@property (nonatomic, strong)NSDictionary *wordLines;

@property (nonatomic, strong)ZCDataCenter *dataCenter;

@property (nonatomic, assign)NSInteger userMaxReadProgressNum;

@end

@implementation ZCScheduleTableViewController

///**************************************   life cricle     **************************************
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//NSLog(@"%@", [self.dataCenter.words[0] spelling]);
    
    
    _userMaxReadProgressNum = self.dataCenter.userMaxReadingProgressMarker;
    
    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    
//    UIERealTimeBlurView *blurView = [[UIERealTimeBlurView alloc] initWithFrame:CGRectMake(0, 110, 200, 200)];
//    
//    [self.navigationController.view addSubview:blurView];
    [self.tableView registerClass:[ZCTableViewCell class] forCellReuseIdentifier:identifier];
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
////    NSLog(@"%s", __func__);
//}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    self.tabBarController.tabBar.hidden = NO;
    
    if (_userMaxReadProgressNum != self.dataCenter.userMaxReadingProgressMarker) {
        _userMaxReadProgressNum = self.dataCenter.userMaxReadingProgressMarker;
        ZCLog(@"reload data");
        [self.tableView reloadData];
    }
    
}


///**************************************   getter     **************************************


- (ZCDataCenter *)dataCenter
{
    if (_dataCenter == nil) {
        _dataCenter = [ZCDataCenter sharedData];
    }
    return _dataCenter;
}

///**************************************   data source     **************************************
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    
//    NSLog(@"%@", @(self.dataCenter.words.count));
    
    return self.dataCenter.words.count/KwordInSection + 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    ZCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat: @"Section %@", @(indexPath.section +1)];;
    
    // Configure the cell...
    if(self.dataCenter.userMaxReadingProgressMarker/KwordInSection < indexPath.section)
    {
        
        cell.detailTextLabel.text = @"未读";
        
    }else if(self.dataCenter.userMaxReadingProgressMarker/KwordInSection == indexPath.section){
        
        cell.detailTextLabel.text = @"Reading";
        
    }else{
        
        cell.detailTextLabel.text = @"已读";

    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


///**************************************    delegate    **************************************

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZCScheduleDetailController *scheduleDetailVC = [[ZCScheduleDetailController alloc] init];
    
    NSMutableArray *arrayM4CellDatasource = [NSMutableArray arrayWithCapacity:0];

    NSInteger allWordsCount = self.dataCenter.words.count;
    
    int count;
    
    if ((indexPath.section + 1 )*KwordInSection-allWordsCount > 0) {
        count = allWordsCount % KwordInSection;
    }else{
        count = KwordInSection;
    }
    for (int i = 0 ; i < count ; i++) {
        
        ZCLog(@"%@", [self.dataCenter.words[indexPath.section * KwordInSection + i] spelling]);
        ZCWord *word = self.dataCenter.words[indexPath.section*KwordInSection + i];

        [arrayM4CellDatasource addObject:word];
    }

    scheduleDetailVC.wordsInSection = (NSArray *)arrayM4CellDatasource;
    
    [self.navigationController pushViewController:scheduleDetailVC animated:YES];
    
    
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
