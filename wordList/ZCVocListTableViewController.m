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


@interface ZCVocListTableViewController ()<ZCViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *unknownWords;

@property (nonatomic, strong) NSString *filePath;

@end

@implementation ZCVocListTableViewController

#pragma mark - load filepath
- (NSString *)filePath
{
    if (!_filePath) {
        _filePath = [@"unKonwnWords.plist" appendDocumentPath];
    }
    return _filePath;
}

- (NSMutableArray *)unknownWords
{
    if (!_unknownWords) {
        _unknownWords = [NSMutableArray arrayWithContentsOfFile:self.filePath];
        if (_unknownWords == nil) {
            _unknownWords = [NSMutableArray array];
        }
    }
    return _unknownWords;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@" wordlist....%s", __func__);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addCell:) name:@"add" object:nil];
    
}

//  transfer
-(void)addCell:(NSNotification *)aNotification
{
    
//        NSNotification *anotification
    NSLog(@"recieved!!!!");
    
    NSDictionary *info = [aNotification userInfo];
    NSString *word = [info objectForKey:@"word"];
    if (![self.unknownWords containsObject:word]) {
        
        [self.unknownWords addObject:word];
        
        [self.tableView reloadData];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%d", self.unknownWords.count);
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


#pragma mark - implementation of delegate method
- (void)viewController:(ViewController *)viewController AddNewWord:(NSString *)word
{
    NSLog(@"list%@", word);
    if (![self.unknownWords containsObject:word]) {
        
        [self.unknownWords addObject:word];
        NSLog(@"%d",self.unknownWords.count);

        [self.tableView reloadData];
        
        [self.unknownWords writeToFile:self.filePath atomically:YES];
        
    }
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
