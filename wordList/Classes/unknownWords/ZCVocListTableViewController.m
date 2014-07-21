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
#import "ZCTableViewCell.h"


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


///**************************************    life circle    **************************************
#pragma mark - life cycle
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(add) name:@"click" object:nil];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}


- (void)viewWillAppear:(BOOL)animated
{

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

///**************************************   notification     **************************************///

- (void)add
{
    NSLog(@"recieved!!!!");
    self.unknownWords = [NSMutableArray arrayWithContentsOfFile:[ZCFilePathManager unknownWordFilePath]];
    
    [self.tableView reloadData];
}

///**************************************    getter    **************************************
#pragma mark - load filepath

- (NSMutableArray *)unknownWords
{
    
    if (!_unknownWords) {
        
        _unknownWords = [NSMutableArray arrayWithContentsOfFile:[ZCFilePathManager unknownWordFilePath]];
        NSLog(@"111111");
    }

    return _unknownWords;
}

///**************************************    data source    **************************************
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
    static NSString *ID = @"unknownWordsCell";
    
    ZCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
//    if (cell == nil) {
//        cell = [[ZCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
    cell.textLabel.text = self.unknownWords[indexPath.row];

    
    return cell;
}
///**************************************    delegate    **************************************

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
    
       NSLog(@"delete .. %d", indexPath.row);
    
    [self.unknownWords removeObjectAtIndex:indexPath.row];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [self.unknownWords writeToFile:[ZCFilePathManager unknownWordFilePath] atomically:YES];
    
//    }
}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleDelete;
//}

#pragma mark - controller will push
///********************************   push    *******************************//
#warning Frankly, I do not like this kind of push. user only want to know a little bit detail of the word, however poping to another controller will make them think that the word is really a big case. I will try to fix this part by adding a pull detail view instead, which takes more time to design.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ZCDetailViewController *detailVC = segue.destinationViewController;
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    // at this time the view has not been created yet.
//    detailVC.wordLabel.text = self.unknownWords[indexPath.row];
    
    detailVC.word = self.unknownWords[indexPath.row];
    
}


@end










