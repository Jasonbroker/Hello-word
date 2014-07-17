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
#import "ZCFilePathManager.h"
#import "ZCMessageSoundEffect.h"
// shimmering
#import "FBShimmeringView.h"

@interface ViewController ()

//  data model:

@property (nonatomic, strong)NSMutableArray *unknownWords;

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;

- (IBAction)AddVList:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBtn;

@end

@implementation ViewController

#pragma mark - lifetime cycle
///**************************************    life circle    **************************************
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // shimmering view
    FBShimmeringView *shimmeringView = [[FBShimmeringView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:shimmeringView];
    
    [self.wordLabel removeFromSuperview];
    [shimmeringView addSubview:_wordLabel];
    
    _wordLabel.textAlignment = NSTextAlignmentCenter;
    shimmeringView.contentView = _wordLabel;
    shimmeringView.shimmeringOpacity = 0.5;
    
    shimmeringView.shimmering = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [self addSwipeGesture];
    [self addTapGesture];
}

////****************************************    getter   setter ****************************************
#pragma mark - setter getter
- (NSMutableArray *)unknownWords
{
    if (_unknownWords == nil) {
        
        _unknownWords = [[NSMutableArray alloc] init];
        
        NSString *path = [ZCFilePathManager unknownWordFilePath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            
            NSMutableArray *arrayM = [NSMutableArray arrayWithContentsOfFile:[ZCFilePathManager unknownWordFilePath]];
            
            _unknownWords = arrayM;
            
        }else{
            // create the file  22222222 :(
            NSLog(@"no file~ ~");
            [_unknownWords writeToFile:path atomically:YES];
        
        }
    }
    
    return _unknownWords;
}

- (NSDictionary *)wordLines
{
    if (!_wordLines) {
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

///**************************************    gestures    **************************************
#pragma mark - gestures swipe  left anf right ... tap to move forward
- (void)addSwipeGesture
{
    
    /** swipe */
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionRight;
    /**  swip down to reveal words meaning */
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown2Reveal:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;

    
    [self.view addGestureRecognizer:swipeLeft];
    [self.view addGestureRecognizer:swipeRight];
    [self.view addGestureRecognizer:swipeDown];
}

- (void)swipe:(UISwipeGestureRecognizer *)swipeRecognizer
{
    NSLog(@"%d", swipeRecognizer.direction);
    
#warning  not good enough ...considering to change this part to a more comfortable implementation
    UIAlertView *alertLeft = [[UIAlertView alloc] initWithTitle:@"warning" message:@"已到达起始点！" delegate:self cancelButtonTitle: @"OK" otherButtonTitles: nil];
    UIAlertView *alertRight = [[UIAlertView alloc] initWithTitle:@"warning" message:@"Task is finished!" delegate:self cancelButtonTitle: @"continue" otherButtonTitles: nil];
    
    if (swipeRecognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        _count ++;
        self.addBtn.enabled = YES;
        self.wordLabel.text = [self.wordLines valueForKey:[NSString stringWithFormat:@"%d", self.count]];
        [self.wordLabel sizeToFit];
        self.wordLabel.text = [self.wordLines valueForKey:[NSString stringWithFormat:@"%d", self.count]];
        
        NSLog(@"%@", self.wordLabel.text);
        
        if (_count%KwordInSection == 0 ) {
            self.addBtn.enabled = NO;
            [alertRight show];
            self.wordLabel.text = [NSString stringWithFormat:@"Day %d \nClick to Start", _count/KwordInSection+1];
        }
    }else if(swipeRecognizer.direction == UISwipeGestureRecognizerDirectionRight){
        if (_count == 0) {
            //            show alert here
            NSLog(@" right swipe...");
            
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

#warning  ZZC - reserve for updating the new dict!

- (void)swipeDown2Reveal:(UIGestureRecognizer *)swipeDownRecognizer
{
    
}


/** tap */
- (void)addTapGesture
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    
    [self.view addGestureRecognizer:tapGesture];
    
}

- (void)tap:(UITapGestureRecognizer *)recognier
{
    UIAlertView *alertRight = [[UIAlertView alloc] initWithTitle:@"warning" message:@"Task is finished!" delegate:self cancelButtonTitle: @"continue" otherButtonTitles: nil];
    
    _count ++;
    self.addBtn.enabled = YES;
    self.wordLabel.text = [self.wordLines valueForKey:[NSString stringWithFormat:@"%d", self.count]];
    [self.wordLabel sizeToFit];
    self.wordLabel.text = [self.wordLines valueForKey:[NSString stringWithFormat:@"%d", self.count]];

    NSLog(@"%@", self.wordLabel.text);
    if (_count%KwordInSection == 0 ) {
        self.addBtn.enabled = NO;
        [alertRight show];
        self.wordLabel.text = [NSString stringWithFormat:@"Day %d \nClick to Start", _count/KwordInSection+1];
    }
}

#pragma mark - touch method ---------- Deprecated
/**
  if right move, words back.  left move or tap, word move forword.
 */
/**
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
        if (_count%KwordInSection == 0 ) {
            self.addBtn.enabled = NO;
            [alertRight show];
            self.wordLabel.text = [NSString stringWithFormat:@"Day %d \nClick to Start", _count/KwordInSection+1];
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

*/

#pragma mark - click button to  add unknown words to the vocabulary list ^ _ ^
- (IBAction)AddVList:(UIBarButtonItem *)sender {
  
    if (![self.unknownWords containsObject:self.wordLabel.text]) {
        
        [ZCMessageSoundEffect playMessageSentSound];
        
        [self.unknownWords addObject:self.wordLabel.text];
        
        [self.unknownWords writeToFile:[ZCFilePathManager unknownWordFilePath] atomically:YES];
        
        //    send notification
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"click" object:nil];
        
//        NSLog(@"%@", self.unknownWords);
        
    }else{
        [ZCMessageSoundEffect playAlertSound];
    }
    

}




@end
