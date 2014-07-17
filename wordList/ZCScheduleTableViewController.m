//
//  ZCScheduleTableViewController.m
//  wordList
//
//  Created by Jason Zhou on 7/7/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCScheduleTableViewController.h"
#import "ZCScheduleDetailController.h"
#import "ZCFilePathManager.h"
#import "Common.h"


@interface ZCScheduleTableViewController ()

@property (nonatomic, strong)NSDictionary *wordLines;

@end

@implementation ZCScheduleTableViewController

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

    
}

- (void)viewDidDisappear:(BOOL)animated
{
    
//    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - lazy~
- (NSDictionary *)wordLines
{
    if (!_wordLines) {
                NSLog(@"%s.....", __func__);
        NSString *path = [ZCFilePathManager wordsFilePath];

        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            
            NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
            _wordLines = dict;
        }else{
            NSLog(@"ERROR at %@.....", path);
        }
    }

    return _wordLines;
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
    return self.wordLines.count/KwordInSection + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"scheduleCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.textLabel.text = @"Section";
    
    cell.detailTextLabel.text = [NSString stringWithFormat: @"No: %d", indexPath.section +1];
    // Configure the cell...
    return cell;
}

///**************************************        **************************************
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
        ZCScheduleDetailController *detailVC = segue.destinationViewController;
    
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
        detailVC.sectionNum = indexPath.section;
    
        NSLog(@"%@", @(indexPath.section));

}


@end
