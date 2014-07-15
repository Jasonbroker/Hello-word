//
//  ZCTaskTableViewController.m
//  wordList
//
//  Created by Jason Zhou on 7/7/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCVocListTableViewController.h"
#import "ViewController.h"
#import "NSString+Path.h"
#import "ZCDetailViewController.h"
#import "ZCFilePathManager.h"


@interface ZCVocListTableViewController ()

@property (nonatomic, strong) NSMutableArray *unknownWords;

//@property (nonatomic, strong) ZCDataCenter *dataCenter;

//@property (nonatomic, strong) NSString *filePath;

@end

@implementation ZCVocListTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@" wordlist....%s", __func__);
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}


#pragma mark - load filepath

- (NSMutableArray *)unknownWords
{
//    if (_unknownWords) {
        _unknownWords = [NSMutableArray arrayWithContentsOfFile:[ZCFilePathManager unknownWordFilePath]];
        if (_unknownWords == nil) {
            _unknownWords = [NSMutableArray array];
//        }
    }
    return _unknownWords;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.unknownWords.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"wordCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.textLabel.text = self.unknownWords[indexPath.row];
    
    return cell;
}

#pragma mark - table view delegate method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end
