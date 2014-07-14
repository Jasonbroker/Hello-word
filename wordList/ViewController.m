//
//  ViewController.m
//  wordList
//
//  Created by Jason Zhou on 7/6/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ViewController.h"
#import "ZCScheduleTableViewController.h"
#import "ZCVocListTableViewController.h"
#import "Common.h"
#import "ZCDataCenter.h"

@interface ViewController ()

//  data model:

@property (nonatomic, strong) ZCDataCenter *dataCenter;

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;

- (IBAction)AddVList:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBtn;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataCenter = [[ZCDataCenter alloc] init];
}

- (NSDictionary *)wordLines
{
    if (!_wordLines) {

        NSString *path = [[NSBundle mainBundle] pathForResource:@"words.plist" ofType:nil];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            
            NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
            _wordLines = dict;
        }else{
            NSLog(@"ERROR at %@.....", path);
        }
    }
    return _wordLines;
}


#pragma mark - touch method
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    
    CGPoint location = [touch locationInView:self.view];
    
    CGPoint preLocation = [touch previousLocationInView:self.view];
    
    CGFloat offsetX = location.x - preLocation.x;
    
    CGFloat offsetY  = location.y - preLocation.y;
    
    NSLog(@"%f", offsetX);
    
    UIAlertView *alertLeft = [[UIAlertView alloc] initWithTitle:@"warning" message:@"已到达起始点！" delegate:self cancelButtonTitle: @"cancel" otherButtonTitles: nil];
    UIAlertView *alertRight = [[UIAlertView alloc] initWithTitle:@"warning" message:@"Task is finished!" delegate:self cancelButtonTitle: @"continue" otherButtonTitles: nil];
    
    
    if (offsetX < - 1 || offsetY < - 1 || (offsetX == 0 && offsetY == 0 )) {
        self.addBtn.enabled = YES;
        self.wordLabel.text = [self.wordLines valueForKey:[NSString stringWithFormat:@"%d", self.count]];
        [self.wordLabel sizeToFit];
        self.wordLabel.text = [self.wordLines valueForKey:[NSString stringWithFormat:@"%d", self.count]];
        
        NSLog(@"%@", self.wordLabel.text);
        _count ++;
        if (_count%15 == 0 ) {
            self.addBtn.enabled = NO;
            [alertRight show];
            self.wordLabel.text = [NSString stringWithFormat:@"Day %d \nClick to Start", _count/15+1];
        }
    }else if(offsetX> 1 || offsetY > 1){
        if (_count == 0) {
            //            show alert here
            [alertLeft show];
            
        }else{
            
            _count --;
            NSString *word = [self.wordLines valueForKey:[NSString stringWithFormat:@"%d", self.count]];
            self.wordLabel.text = word;
            [self.wordLabel sizeToFit];
            self.wordLabel.text = word;
            NSLog(@"%@", self.wordLabel.text);
        }
    }

    
}


- (IBAction)AddVList:(UIBarButtonItem *)sender {
    
//    notification
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"add" object:nil userInfo:[NSDictionary dictionaryWithObject: self.wordLabel.text forKey:@"word"]];
    
    [self.dataCenter.unknownWords addObject:self.wordLabel.text];
    
    NSLog(@"%d", self.dataCenter.unknownWords.count);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
