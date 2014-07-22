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

static NSString *ID = @"wordCell";

@interface ZCScheduleDetailController ()


@property (nonatomic, strong) NSDictionary *words;

@end

@implementation ZCScheduleDetailController
///**************************************        **************************************
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    NSLog(@"%@", NSStringFromCGRect(self.tabBarController.tabBar.frame));
    
    // self.clearsSelectionOnViewWillAppear = NO;

//    self.tabBarController.tabBar.hidden =YES;
    
    //    register the cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

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

#pragma mark - controller will pop
///********************************   pop    *******************************//
#warning Frankly, I do not like this. Wont pop again this time..
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    ZCDetailViewController *detailVC = segue.destinationViewController;
//    
//    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//    
//    // at this time the view has not been created yet.
//    //    detailVC.wordLabel.text = self.unknownWords[indexPath.row];
//    
//    detailVC.word = self.wordsInSection[indexPath.row];
    
}


@end
