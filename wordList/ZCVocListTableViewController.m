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

/**
 
 reminder:
 ===========================================
 life cycle:
 
 blank app:
 
 when new word btn pressed:
 
 the word will be added to the documents. At this time, view for voc list havnt init yet;
 
 
 
 
 
 
 the view did load
 
 getter will be called and load the file data;
 
 and the user come back to the first page to learn more words 
 
 
 if  click the add btn:
        
            when the voca list view appears, it should load the new data now.

 else do nothing and come back to this view:
            
            the view comtroller need to do nothing.
 
 As a result:

 another tippppp:    while in this time the delegate can be used now.
 
 use
 
 */

#pragma mark - life cycle
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(add) name:@"click" object:nil];
    
}

- (void)add
{
    NSLog(@"recieved!!!!");
    self.unknownWords = [NSMutableArray arrayWithContentsOfFile:[ZCFilePathManager unknownWordFilePath]];
    
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

///**************************************        **************************************
#pragma mark - load filepath

- (NSMutableArray *)unknownWords
{
    
    if (!_unknownWords) {
        
        _unknownWords = [NSMutableArray arrayWithContentsOfFile:[ZCFilePathManager unknownWordFilePath]];
        NSLog(@"111111");
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
