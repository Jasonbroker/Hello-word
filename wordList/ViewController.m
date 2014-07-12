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
#import "ZCWords.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;

- (IBAction)AddVList:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBtn;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSDictionary *)wordLines
{
    if (!_wordLines) {

        NSString *dirpath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        NSString *path = [dirpath stringByAppendingPathComponent:@"words.plist"];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            
            NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
            _wordLines = dict;
        }else{
            NSLog(@"ERROR at %@.....", path);
        }
    }
    return _wordLines;
}

- (IBAction)leftAndRightClick:(UIButton *)sender {
    
    UIAlertView *alertLeft = [[UIAlertView alloc] initWithTitle:@"前方高能！" message:@"已到达起始点！" delegate:self cancelButtonTitle: @"cancel" otherButtonTitles: nil];
    UIAlertView *alertRight = [[UIAlertView alloc] initWithTitle:@"前方高能！" message:@"Task is finished!" delegate:self cancelButtonTitle: @"continue" otherButtonTitles: nil];
    

    if (sender.tag == 100) {
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
        
    }else{
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
    }
    
    alertLeft = nil;
    alertRight = nil;

}  // give up this code


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    
    CGPoint location = [touch locationInView:self.view];
    
    CGPoint preLocation = [touch previousLocationInView:self.view];
    
    CGFloat offsetX = location.x - preLocation.x;
    
    CGFloat offsetY  = location.y - preLocation.y;
    
    NSLog(@"%f", offsetX);
    
    UIAlertView *alertLeft = [[UIAlertView alloc] initWithTitle:@"前方高能！" message:@"已到达起始点！" delegate:self cancelButtonTitle: @"cancel" otherButtonTitles: nil];
    UIAlertView *alertRight = [[UIAlertView alloc] initWithTitle:@"前方高能！" message:@"Task is finished!" delegate:self cancelButtonTitle: @"continue" otherButtonTitles: nil];
    
    //    move right or down   ===> to next
    //    if (_count == 0 ) {
    //        if ((offsetX <20 && fabs(offsetY) < 5) || (offsetY > 20 && fabs(offsetX) <5 )) {
    //
    //        }
    //
    //    }
    
    if (offsetX >1 || offsetY >1 ) {
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
    }else if(offsetX<-1 || offsetY<-1){
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
#pragma mark - touch method


- (IBAction)AddVList:(UIBarButtonItem *)sender {
    
//    notification
    [[NSNotificationCenter defaultCenter] postNotificationName:@"add" object:nil userInfo:[NSDictionary dictionaryWithObject: self.wordLabel.text forKey:@"word"]];
    
    self.words = [[ZCWords alloc] init];
    
    [self.words.unknownWords addObject:self.wordLabel.text];
    
    
//    delegate
//    ZCVocListTableViewController *vocListVC = [[ZCVocListTableViewController alloc] init];
//    self.myDelete = vocListVC;
////    NSString *word = [self.wordLines valueForKey:[NSString stringWithFormat:@"%d", self.count]];
//    
//    if ([self.myDelete respondsToSelector:@selector(viewController:AddNewWord:)]) {
//        
//        NSString *unknownWord = self.wordLabel.text;
//
//        [self.myDelete viewController:self AddNewWord:unknownWord];
//    
//    }
//    
}













//  getter
//- (NSArray *)lineNumber
//{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"word.txt" ofType:nil];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
//
//        NSString *str =[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//        _lineNumber = [str componentsSeparatedByString:@"\n"];
//
//    }else{
//    NSLog(@"ERROR..........");
//    }
//        return _lineNumber;
//}
//
//-(NSArray *)randomLine
//{
//    self.lineNumber = [[NSArray alloc] init];
//    NSMutableArray *arrayM = [NSMutableArray arrayWithArray:self.lineNumber];
//
//    NSMutableArray *getArrayM = [NSMutableArray array];
//    int length = arrayM.count;
//    for (int i  = 0 ; i < length ; i++ ) {
//        int seed = arc4random_uniform(arrayM.count);
//        [getArrayM addObject:arrayM[seed]];
//        [arrayM removeObjectAtIndex:seed];
//    }
//    return getArrayM;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
