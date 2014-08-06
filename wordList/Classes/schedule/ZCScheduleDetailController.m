//
//  ZCScheduleDetailController.m
//  wordList
//
//  Created by Jason Zhou on 7/14/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCScheduleDetailController.h"
#import "Common.h"

#import "ZCTableViewCell.h"
#import "ZCUIColor+Extension.h"
#import "ZCWord.h"

static NSString *scheduleDetailCellIdentifier = @"wordCell";

@interface ZCScheduleDetailController ()


@end

@implementation ZCScheduleDetailController
///**************************************    life circle    **************************************
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //    register the cell
    [self.tableView registerClass:[ZCTableViewCell class] forCellReuseIdentifier:scheduleDetailCellIdentifier];
#warning
//    self.view.layer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reading_bg_3"]].CGColor;
//    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reading_bg_3"]];
}

///**************************************    getter setter    **************************************




///**************************************  table view data source      **************************************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section. defined in common.m
//    return KwordInSection;
    return self.wordsInSection.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:scheduleDetailCellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[ZCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:scheduleDetailCellIdentifier];
    }
    
    cell.textLabel.text = [self.wordsInSection[indexPath.row] spelling];
    cell.backgroundColor = [UIColor clearColor];
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
    ZCLog(@"%@", indexPath);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
