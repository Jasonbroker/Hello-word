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
#import "ZCDataCenter.h"

@interface ZCVocListTableViewController ()

@property (nonatomic, strong) NSMutableArray *unknownWords;

@property (nonatomic, strong) ZCDataCenter *dataCenter;
//@property (nonatomic, strong) NSString *filePath;

@end

@implementation ZCVocListTableViewController

#pragma mark - load filepath

- (NSMutableArray *)unknownWords
{
//    if (!_unknownWords) {
//        _unknownWords = [NSMutableArray arrayWithContentsOfFile:[ZCFilePathManager unknownWordFilePath]];
//        if (_unknownWords == nil) {
//            _unknownWords = [NSMutableArray array];
//        }
//    }
    
    if (!_unknownWords) {
        _unknownWords = self.dataCenter.unknownWords;
    }
    return _unknownWords;
}


- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@" wordlist....%s", __func__);
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addCell:) name:@"add" object:nil];

}

//#pragma mark - method for notification
//-(void)addCell:(NSNotification *)aNotification
//{
//    
////        NSNotification *anotification
//    NSLog(@"recieved!!!!");
//    
//    NSDictionary *info = [aNotification userInfo];
//    NSString *word = [info objectForKey:@"word"];
//    if (![self.unknownWords containsObject:word]) {
//        
//        [self.unknownWords addObject:word];
//        
//        [self.unknownWords writeToFile:[ZCFilePathManager unknownWordFilePath] atomically:YES];
//        
//        [self.tableView reloadData];
//    }
//    
//}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%d_________viewdidappear", self.unknownWords.count);
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)dealloc
{
    NSLog(@"%s", __func__);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
