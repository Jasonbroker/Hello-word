//
//  ViewController.m
//  wordList
//
//  Created by Jason Zhou on 7/6/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//
#import "ZCRootController.h"
#import "ViewController.h"
#import "ZCScheduleTableViewController.h"
#import "ZCVocListTableViewController.h"
#import "Common.h"
#import "ZCFilePathManager.h"
#import "ZCMessageSoundEffect.h"

// shimmering
#import "FBShimmeringView.h"
//test
#import "UIERealTimeBlurView.h"

@interface ViewController ()


@property (nonatomic, strong)NSMutableArray *unknownWords;

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;

@property (nonatomic, strong)NSDictionary *wordsInSection;

- (IBAction)AddVList:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBtn;

@property (nonatomic, strong)ZCRootController *rootVC;

@property (nonatomic, assign)BOOL isFirstLoaded;

@end

@implementation ViewController

#pragma mark - lifetime cycle
///**************************************    life circle    **************************************
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"%@", [ZCFilePathManager unknownWordFilePath]);
//    NSLog(@"%@", NSStringFromCGRect([UIScreen mainScreen].bounds));
//    background image
    if (iPhone4inch) {
        UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reading_bg_4"]];
        
        [self.view addSubview:bg];
//
    }else{
        UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reading_bg_3"]];
        
        [self.view addSubview:bg];
    }
    
    
    // shimmering view
    FBShimmeringView *shimmeringView = [[FBShimmeringView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:shimmeringView];
    
    [self.wordLabel removeFromSuperview];
    [shimmeringView addSubview:_wordLabel];
    
    _wordLabel.textAlignment = NSTextAlignmentCenter;
    shimmeringView.contentView = _wordLabel;
    shimmeringView.shimmeringOpacity = 0.5;
    
    shimmeringView.shimmering = YES;
    
    NSString *path = [ZCFilePathManager userProgressPath];
    
    NSDictionary *userProgress = [NSDictionary dictionaryWithContentsOfFile:path];
    
    self.count = [[userProgress valueForKeyPath:KUserReadingProgressMarkerKey] integerValue];
    
    self.isFirstLoaded = YES;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [self addSwipeGesture];
    [self addTapGesture];
// test
    [self addPinchGesture];
    
    //    hide bars
    if (self.isFirstLoaded) {
        sleep(0.5);
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, 49);
        }];
        
        self.isFirstLoaded = NO;
    }

    
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

- (ZCRootController *)rootVC
{
    if (_rootVC == nil) {
        _rootVC = (ZCRootController *)[[UIApplication sharedApplication].windows[0] rootViewController];
    }
    return _rootVC;
}

///**************************************    gestures    **************************************
#pragma mark - gestures swipe  left anf right ... tap to move forward
- (void)addSwipeGesture
{
    
    /** swipe */
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    /**  swip down to reveal words meaning */
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown2Reveal:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;

    
    [self.view addGestureRecognizer:swipeLeft];
    [self.view addGestureRecognizer:swipeRight];
    
//    [self.view addGestureRecognizer:swipeDown];
}

#warning  all  the    massssssssssssssssssssssssssssssss massssma  mamsmmsmamsmamsamsmamsmamsamsmamsmamsmamsmamsamsmammsamm!!!!!!!!!!!!!!!!!!
/**  swipe  */

//- (void)swipe:(UISwipeGestureRecognizer *)swipeRecognizer
//{
//    NSLog(@"%d", swipeRecognizer.direction);
//    
//#warning  not good enough ...considering to change this part to a more comfortable implementation
//    UIAlertView *alertLeft = [[UIAlertView alloc] initWithTitle:@"warning" message:@"已到达起始点！" delegate:self cancelButtonTitle: @"OK" otherButtonTitles: nil];
//    UIAlertView *alertRight = [[UIAlertView alloc] initWithTitle:@"warning" message:@"Task is finished!" delegate:self cancelButtonTitle: @"continue" otherButtonTitles: nil];
//    
//    if (swipeRecognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
//        _count ++;
//        self.addBtn.enabled = YES;
//        self.wordLabel.text = [self.wordLines valueForKey:[NSString stringWithFormat:@"%d", self.count]];
//        [self.wordLabel sizeToFit];
//        self.wordLabel.text = [self.wordLines valueForKey:[NSString stringWithFormat:@"%d", self.count]];
//        
//        NSLog(@"%@", self.wordLabel.text);
//        
//        if ((_count + 1)%KwordInSection == 0) {
//            
//            self.addBtn.enabled = NO;
//            self.wordLabel.text = [NSString stringWithFormat:@"Day %d \nSlide to Start", _count/KwordInSection+1];
//            }
//        }else if(swipeRecognizer.direction == UISwipeGestureRecognizerDirectionRight){
//            
//            if (_count == 0) {
//            //            show alert here
//            NSLog(@" right swipe...");
//            
//            [alertLeft show];
//            
//            }else{
//            
//            _count --;
//            NSString *word = [self.wordLines valueForKey:[NSString stringWithFormat:@"%d", self.count]];
//            self.wordLabel.text = word;
//            [self.wordLabel sizeToFit];
//            self.wordLabel.text = word;
//            NSLog(@"%@", self.wordLabel.text);
//            NSLog(@"%d", _count);
//        }
//    }
//    
//    
//}
///**************************************    swipe    **************************************

- (void)swipe:(UISwipeGestureRecognizer *)swipeRecognizer
{
    NSLog(@"%d", swipeRecognizer.direction);
    
#warning  not good enough ...considering to change this part to a more comfortable implementation
    UIAlertView *alertLeft = [[UIAlertView alloc] initWithTitle:@"warning" message:@"已到达起始点！" delegate:self cancelButtonTitle: @"OK" otherButtonTitles: nil];
    UIAlertView *alertRight = [[UIAlertView alloc] initWithTitle:@"warning" message:@"Task is finished!" delegate:self cancelButtonTitle: @"continue" otherButtonTitles: nil];
    
    if (swipeRecognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        _count ++;
        
        //        to remember the max word index which the user read
        
        if (_count > _rootVC.userMaxReadingProgressMarker) {
            _rootVC.userMaxReadingProgressMarker = _count;
        }
        
        self.addBtn.enabled = YES;
        self.wordLabel.text = [self.wordLines valueForKey:[NSString stringWithFormat:@"%d", self.count]];
        [self.wordLabel sizeToFit];
        
//        NSLog(@"%@", self.wordLabel.text);
        
        if (_count%KwordInSection == 0 ) {
            self.addBtn.enabled = NO;
            [alertRight show];
            self.wordLabel.text = [NSString stringWithFormat:@"Day %d \nSlide to start", _count/KwordInSection+1];
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
//            NSLog(@"%@", self.wordLabel.text);
        }
    }
    
    self.rootVC.userReadingProgressMarker = _count;
}

#warning  ZZC - reserve for updating the new dict!

- (void)swipeDown2Reveal:(UIGestureRecognizer *)swipeDownRecognizer
{
    /// for feature to come.
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
//    record the user progress.
    if (_count > _rootVC.userMaxReadingProgressMarker) {
        _rootVC.userMaxReadingProgressMarker = _count;
    }
        self.rootVC.userReadingProgressMarker = _count;

    self.addBtn.enabled = YES;
    self.wordLabel.text = [self.wordLines valueForKey:[NSString stringWithFormat:@"%d", self.count]];
    [self.wordLabel sizeToFit];
    self.wordLabel.text = [self.wordLines valueForKey:[NSString stringWithFormat:@"%d", self.count]];

//    NSLog(@"%@", self.wordLabel.text);
    if (_count%KwordInSection == 0 ) {
        self.addBtn.enabled = NO;
        [alertRight show];
        self.wordLabel.text = [NSString stringWithFormat:@"Day %d \nClick to Start", _count/KwordInSection+1];
    }
}

/// test..... pinch

- (void)addPinchGesture
{
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action: @selector(pinch:)];
    
    [self.view addGestureRecognizer:pinchGesture];
}

- (void)pinch:(UIPinchGestureRecognizer *)pinchRecognizer
{
    if (pinchRecognizer.scale > 1.3f) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, 49);
        }];
        
    }else if(pinchRecognizer.scale < 0.7f){
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
        [UIView animateWithDuration:0.2 animations:^{

            self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, 0);
        }];
        

    }
}

///**************************************   add btn clicked  - notification send to third view controller     **************************************
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
//        alert
        [ZCMessageSoundEffect playAlertSound];
    }
    

}




@end
