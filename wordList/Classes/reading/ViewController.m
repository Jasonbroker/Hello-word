//
//  ViewController.m
//  wordList
//
//  Created by Jason Zhou on 7/6/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ViewController.h"
#import "Common.h"
#import "ZCMessageSoundEffect.h"

#import "ZCDataCenter.h"

// shimmering
#import "FBShimmeringView.h"
//test
#import "ZCWord.h"


@interface ViewController ()


@property (nonatomic, strong)NSMutableArray *unknownWords;

@property (strong, nonatomic) UILabel *wordLabel;

@property (strong, nonatomic) FBShimmeringView *shimmeringView;

@property (nonatomic, strong)NSDictionary *wordsInSection;

@property (nonatomic, assign)BOOL isFirstLoaded;

@property (nonatomic, strong)ZCDataCenter *dataCenter;

@property (nonatomic, strong)NSArray *words;

@property (nonatomic, assign) NSInteger userPrograss;

@property (nonatomic, assign) int userMaxReadingCount;

- (IBAction)AddVList:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBtn;

//@property (nonatomic, strong)ZCRootController *rootVC;


@end

@implementation ViewController

#pragma mark - lifetime cycle
///**************************************    life circle    **************************************
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (iPhone4inch) {
        UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reading_bg_4"]];
        
        [self.view addSubview:bg];
//
    }else{
        UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reading_bg_3"]];
        
        [self.view addSubview:bg];
    }
    
//    autolayout
//wordLabel
    _wordLabel = [[UILabel alloc] init];
    _wordLabel.text = @"Slide to Start";
    _wordLabel.textColor = [UIColor whiteColor];
    //    _wordLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:18];
    _wordLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:35];
    _wordLabel.numberOfLines = 0;
    
    _wordLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _wordLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_wordLabel];
    //    self.wordLabel_
    
    // shimmering view
    _shimmeringView = [[FBShimmeringView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:_shimmeringView];
    
    _shimmeringView.contentView = _wordLabel;
    _shimmeringView.shimmeringOpacity = 0.5;
    _shimmeringView.shimmeringPauseDuration = 0.1;
    
    _shimmeringView.shimmeringSpeed = 160;
    
    _shimmeringView.shimmeringOpacity = 0.4;
    
    NSDictionary *dict = NSDictionaryOfVariableBindings(_wordLabel);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[_wordLabel]-50-|" options:0 metrics:nil views:dict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_wordLabel]-100-|" options:0 metrics:nil views:dict]];
    
//    [self.view setNeedsLayout];
    
//    NSString *path = [ZCFilePathManager userProgressPath];
    
//    self.count = [[userProgress valueForKeyPath:KUserReadingProgressMarkerKey] integerValue];
    
    self.isFirstLoaded = YES;
    
    
#warning test
//    NSLog(@"%@", [self.rootVC.dataCenter.words[1] spelling]);
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect shimmeringFrame = self.view.bounds;
    shimmeringFrame.origin.y = shimmeringFrame.size.height * 0.65;
    shimmeringFrame.size.height = shimmeringFrame.size.height * 0.32;
    _shimmeringView.frame = shimmeringFrame;
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self addSwipeGesture];
    [self addTapGesture];
// test
    [self addPinchGesture];
    
    //    hide bars
    if (self.isFirstLoaded) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  (int64_t)(0.5 * NSEC_PER_SEC)),dispatch_get_main_queue() , ^{
            
            [self.navigationController setNavigationBarHidden:YES animated:YES];
            
            [UIView animateWithDuration:0.2 animations:^{
                
                self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, 49);
            }];
            
        });
        
        self.isFirstLoaded = NO;
        
    }
    
    _shimmeringView.shimmering = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _shimmeringView.shimmering = NO;
    
    self.dataCenter.userReadingProgressMarker = _userPrograss;
}

////****************************************    getter   setter ****************************************
#pragma mark - setter getter
/**
- (ZCRootController *)rootVC
{
    if (_rootVC == nil) {
        _rootVC = (ZCRootController *)[[UIApplication sharedApplication].windows[0] rootViewController];
    }
    return _rootVC;
}
*/

- (ZCDataCenter *)dataCenter
{
    if (_dataCenter == nil) {
        _dataCenter = [ZCDataCenter sharedData];
    }
    
    return _dataCenter;
}

- (NSArray *)words
{
    if (_words == nil) {
        _words = _dataCenter.words;
    }
    return _words;
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
//      open interface
//    [self.view addGestureRecognizer:swipeDown];
}

#warning  all  the    massssssssssssssssssssssssssssssss massssma  mamsmmsmamsmamsamsmamsmamsamsmamsmamsmamsmamsamsmammsamm!!!!!!!!!!!!!!!!!!
///**************************************    swipe    **************************************

- (void)swipe:(UISwipeGestureRecognizer *)swipeRecognizer
{
    NSLog(@"%@", @(swipeRecognizer.direction));
    
#warning  not good enough ...considering to change this part to a more comfortable implementation
    UIAlertView *alertLeft = [[UIAlertView alloc] initWithTitle:@"warning" message:@"已到达起始点！" delegate:self cancelButtonTitle: @"OK" otherButtonTitles: nil];
    UIAlertView *alertRight = [[UIAlertView alloc] initWithTitle:@"warning" message:@"Task is finished!" delegate:self cancelButtonTitle: @"continue" otherButtonTitles: nil];
   
    
    if (swipeRecognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
//init the userProgress
        _userPrograss = self.dataCenter.userReadingProgressMarker;
    
        _userPrograss ++;
        
        //        to remember the max word index which the user read
        
        if (_userPrograss > _dataCenter.userMaxReadingProgressMarker) {

            _dataCenter.userMaxReadingProgressMarker = _userPrograss;
        }
        
        self.addBtn.enabled = YES;
//        self.wordLabel.text = [self.wordLines valueForKey:[NSString stringWithFormat:@"%d", self.count]];

        
#warning @@##if data is good enough, just add the data
        self.wordLabel.text = [self.words[self.userPrograss] spelling];
        
        [self.wordLabel sizeToFit];
        
//        NSLog(@"%@", self.wordLabel.text);
        
        if (_userPrograss%KwordInSection == 0 ) {
            self.addBtn.enabled = NO;
            [alertRight show];
            self.wordLabel.text = [NSString stringWithFormat:@"Day %@ \nSlide to start", @(_userPrograss/KwordInSection+1)];
        }
    }else if(swipeRecognizer.direction == UISwipeGestureRecognizerDirectionRight){
        if (_userPrograss == 0) {
            //            show alert here
            NSLog(@" right swipe...");
            
            [alertLeft show];
            
        }else{
            
            _userPrograss --;
//            NSString *word = [self.wordLines valueForKey:[NSString stringWithFormat:@"%d", self.userPrograss]];
            self.wordLabel.text = self.wordLabel.text = [self.words[self.userPrograss] spelling];
            [self.wordLabel sizeToFit];
//            self.wordLabel.text = word;
//            NSLog(@"%@", self.wordLabel.text);
        }
    }
    
    self.dataCenter.userReadingProgressMarker = _userPrograss;
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
    
    _userPrograss ++;
//    record the user progress.
    if (_userPrograss > _dataCenter.userMaxReadingProgressMarker) {
        _dataCenter.userMaxReadingProgressMarker = _userPrograss;
    }
        self.dataCenter.userReadingProgressMarker = _userPrograss;

    self.addBtn.enabled = YES;
    self.wordLabel.text = self.wordLabel.text = [self.words[self.userPrograss] spelling];
    [self.wordLabel sizeToFit];

//    NSLog(@"%@", self.wordLabel.text);
    if (_userPrograss%KwordInSection == 0 ) {
        self.addBtn.enabled = NO;
        [alertRight show];
        self.wordLabel.text = [NSString stringWithFormat:@"Day %@ \nClick to Start", @(_userPrograss/KwordInSection+1)];
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
    if (pinchRecognizer.scale > 1.2f) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, 49);
        }];
        
    }else if(pinchRecognizer.scale < 0.8f){
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
        [UIView animateWithDuration:0.2 animations:^{

            self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, 0);
        }];
        

    }
}

///**************************************   add btn clicked  - notification send to third view controller     **************************************
#pragma mark - click button to  add unknown words to the vocabulary list ^ _ ^

- (IBAction)AddVList:(UIBarButtonItem *)sender {
    
    if (![self.dataCenter.unknownWords containsObject:self.dataCenter.words[_userPrograss]]) {
        
        [ZCMessageSoundEffect playMessageSentSound];
        
        self.dataCenter.wordIsAdded = YES;
        
        [self.dataCenter.unknownWords addObject:self.dataCenter.words[_userPrograss]];
        
        NSLog(@"%@   hahhahhahaha", @(self.dataCenter.unknownWords.count));
        

    
    }else{
        //        alert
        [ZCMessageSoundEffect playAlertSound];
    }
    
    
}



@end
