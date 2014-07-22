//
//  ZCScheduleDetailController.m
//  wordList
//
//  Created by Jason Zhou on 7/14/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCScheduleDetailController.h"
#import "Common.h"
#import "ZCFilePathManager.h"
#import "ZCbBaiscViewController.h"
#import "ZCTableViewCell.h"
#import "ZCUIColor+Extension.h"

static NSString *scheduleDetailCellIdentifier = @"wordCell";

@interface ZCScheduleDetailController ()


@property (nonatomic, strong) NSDictionary *words;

@end

@implementation ZCScheduleDetailController
///**************************************    life circle    **************************************
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    NSLog(@"%@", NSStringFromCGRect(self.tabBarController.tabBar.frame));
    
    // self.clearsSelectionOnViewWillAppear = NO;

//    self.tabBarController.tabBar.hidden =YES;
    
    //    register the cell
    [self.tableView registerClass:[ZCTableViewCell class] forCellReuseIdentifier:scheduleDetailCellIdentifier];
}

///**************************************    getter setter    **************************************

- (NSDictionary *)words
{
    if (!_words) {
        NSString *path = [ZCFilePathManager wordsFilePath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            
            NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
            _words = dict;
        }else{
            NSLog(@"ERROR at %@.....", path);
        }
    }
    return _words;
}

///**************************************  table view data source      **************************************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section. defined in common.m
    return KwordInSection;
}

#if 0
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    NSString *key = [NSString stringWithFormat:@"%d", indexPath.row + self.sectionNum *KwordInSection ];
    cell.textLabel.text = [self.words valueForKey:key];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = KcellFontSize;
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    return cell;
}
#endif



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:scheduleDetailCellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[ZCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:scheduleDetailCellIdentifier];
    }
    NSString *key = [NSString stringWithFormat:@"%d", indexPath.row + self.sectionNum *KwordInSection];
    cell.textLabel.text = [self.words valueForKey:key];
    
    cell.textLabel.textColor = [UIColor cyclicColor4Index:indexPath.row];

    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KcellHeight;
}

///**************************************     delegate   **************************************

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", indexPath);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
