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
#import "ZCRootController.h"

@interface ZCVocListTableViewController ()

@property (nonatomic, strong) NSMutableArray *unknownWords;

@property (nonatomic, strong) ZCRootController *rootVC;

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
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(add) name:@"click" object:nil];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationItem.title = @"unknown words";

//    self.unknownWords = self.rootVC.dataCenter.unknownWords;
//    first load the data..
//    [self unknownWords];
    
//    [self.tableView reloadData];
}


- (void)viewWillAppear:(BOOL)animated
{
//    NSLog(@"%d~~~~%d", _rootVC.dataCenter.unknownWords.count, _unknownWords.count);
    
    if (self.rootVC.dataCenter.wordIsAdded) {
        
        [self.tableView reloadData];
        
        NSLog(@"reload data");
        
        self.rootVC.dataCenter.wordIsAdded = NO;
    }


}

//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}

///**************************************   notification     **************************************///

//- (void)add
//{
//    NSLog(@"recieved!!!!");
////    self.unknownWords = [NSMutableArray arrayWithContentsOfFile:[ZCFilePathManager unknownWordFilePath]];
//    
//    [self.tableView reloadData];
//}

///**************************************    getter    **************************************
#pragma mark - load filepath

- (ZCRootController *)rootVC   /**datacenter*/
{
    if (_rootVC == nil) {
        _rootVC = (ZCRootController *)[[UIApplication sharedApplication].windows[0] rootViewController];
    }
    return _rootVC;
}


- (NSMutableArray *)unknownWords
{
    
    if (_unknownWords == nil) {
        
//        _unknownWords = [NSMutableArray arrayWithContentsOfFile:[ZCFilePathManager unknownWordFilePath]];
        _unknownWords = self.rootVC.dataCenter.unknownWords;
        
        NSLog(@"%d .....", _unknownWords.count);
        
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
    cell.textLabel.text = [self.unknownWords[indexPath.row] spelling];

    
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
    
    _rootVC.dataCenter.unknownWords = _unknownWords;
    
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
//    [self.unknownWords writeToFile:[ZCFilePathManager unknownWordFilePath] atomically:YES];
    
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZCDetailViewController *detailVC = [[ZCDetailViewController alloc] init];
    
//    detailVC.view.backgroundColor = [UIColor whiteColor];

    //  load view--- view did load
//    when push view controller it will lay out subviews
    
    detailVC.word = [self.unknownWords[indexPath.row] spelling];
    
//    detailVC.wordLabel.text
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark - controller will push
///********************************   push    *******************************//

/**
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ZCDetailViewController *detailVC = segue.destinationViewController;
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    // at this time the view has not been created yet.
//    detailVC.wordLabel.text = self.unknownWords[indexPath.row];
    
    detailVC.word = self.unknownWords[indexPath.row];
    
}
*/

@end










