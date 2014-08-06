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
#import "ZCTabBarController.h"
// shimmering
#import "FBShimmeringView.h"

#import "ZCWordsView.h"
//test
#import "ZCWord.h"
#import "ZCWelcomeView.h"

#import <POPSpringAnimation.h>
#import <pop/POPBasicAnimation.h>
#import "CALayer+Animation.h"

#define ScreenWidth [UIScreen mainScreen].bounds


@interface ViewController ()<ZCWordViewDelegate>

{
    
    CGRect viewFrame;
    CGRect rightViewFrame;
    
    
}


@property (nonatomic, strong)NSMutableArray *unknownWords;

@property (nonatomic, strong) ZCWordsView *wordsView;

@property (nonatomic, strong) ZCWelcomeView *welcomeView;

@property (nonatomic, strong)NSDictionary *wordsInSection;

@property (nonatomic, assign)BOOL isFirstLoaded;

@property (nonatomic, assign)BOOL isWelcomeViewShow;

@property (nonatomic, strong)ZCDataCenter *dataCenter;

@property (nonatomic, assign)CGPoint distinationPoint;

@property (nonatomic, strong)NSArray *words;

@property (nonatomic, assign) NSInteger userPrograss;

@property (nonatomic, assign) int userMaxReadingCount;

@property (nonatomic, strong) UIImageView *bg;


@end

@implementation ViewController

#pragma mark - lifetime cycle
///**************************************    life circle    **************************************

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addAllGestures];
    
    
// frame
    viewFrame = self.view.frame;
    rightViewFrame = CGRectMake(viewFrame.size.width, 0, viewFrame.size.width, viewFrame.size.height);
    
    if (iPhone4inch) {
//        self.bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reading_bg_4"]];
//        self.bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2.jpg"]];
//                self.bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_4"]];  // for the all whole pic  bgOption_4
        self.bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgOption_4"]];
        
        [self.view addSubview:_bg];
        //
    }else{
//        self.bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reading_bg_3"]];
                self.bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_3"]];
        
        [self.view addSubview:_bg];
    }
    
    [self.view addSubview:self.wordsView];
    
    [self.view addSubview:self.welcomeView];
    
    self.wordsView.alpha = 0;
//    self.wordsView.alpha = 0;
//    test
    
//    self.welcomeView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1f];
    self.isFirstLoaded = YES;
    
//    self.wordsView.translatesAutoresizingMaskIntoConstraints = NO;
//    
//    NSDictionary *dict = NSDictionaryOfVariableBindings(_wordsView);
//    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_wordsView]-20-|" options:0 metrics:nil views:dict]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-60-[_wordsView]" options:0 metrics:nil views:dict]];

    
}

#pragma mark - barstyle
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - lay out subview
- (void)viewWillLayoutSubviews
{
    ZCLog(@"%s", __func__);
    [super viewWillLayoutSubviews];
    
    self.wordsView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *dict = NSDictionaryOfVariableBindings(_wordsView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_wordsView]-20-|" options:0 metrics:nil views:dict]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[_wordsView(450)]" options:0 metrics:nil views:dict]];

}

#pragma mark - view did appear
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //    hide bars
    if (self.isFirstLoaded) {
        
        [self hideTabBar];
        
        self.isFirstLoaded = NO;
        
    }
    
    self.welcomeView.slideView.shimmering =YES;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.dataCenter.userReadingProgressMarker = _userPrograss;
}

////****************************************    getter   setter ****************************************
#pragma mark - setter getter

- (ZCWordsView *)wordsView
{
    if (_wordsView == nil) {
//        _wordsView = [ZCWordsView wordsView];
//
        _wordsView = [[ZCWordsView alloc] init];
//                _wordsView = [[ZCWordsView alloc] initWithFrame:<#(CGRect)#>];
        self.wordsView.spellingView.text = [self.words[0] spelling];
//
        self.wordsView.detailsView.text = [NSString stringWithFormat:@"%@\n%@",[self.words[0] meaning], [self.words[0] usage]];
        
        _wordsView.myDelegate = self;
        
    }
    return  _wordsView;
}

- (ZCWelcomeView *)welcomeView
{
    if (_welcomeView == nil) {
        
        _welcomeView = [[ZCWelcomeView alloc] initWithFrame:self.view.bounds];
    }
    
    return _welcomeView;
}

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
        _words = self.dataCenter.words;
    }
    return _words;
}

///**************************************    gestures    **************************************
- (void)addAllGestures
{
    [self addWelcomeGestures];
    
    [self addSwipeGesture];
    //    [self addTapGesture];
    // test
    [self addPinchGesture];
    
    [self addSideGesture];
}
#pragma mark - gestures swipe  left anf right ... tap to move forward
- (void)addSwipeGesture
{
    
    /** swipe */
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeWord:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeWord:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    /** api for update:  swip down to reveal words meaning */
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown2Reveal:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUp2ShowTabBar:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    
    
    [self.view addGestureRecognizer:swipeLeft];
    [self.view addGestureRecognizer:swipeRight];
    //      open interface
        [self.view addGestureRecognizer:swipeDown];
    [self.view addGestureRecognizer:swipeUp];
}

#pragma mark - guestures
///**************************************   add welcome  gestures     ***********************************
///     add pan gesture
#pragma mark add welcome gestures
- (void)addWelcomeGestures
{
    [self addWelcomeSwipeGesture];
    
    [self addWelcomePanGesture];
    
//    [self addWelcomeTapGesture];
    
}

#warning not working right now!!!
- (void)addWelcomeSwipeGesture
{

    ZCLog(@"haha");
    UISwipeGestureRecognizer *welcomeSwipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown2Reveal:)];
        welcomeSwipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    
    UISwipeGestureRecognizer *welcomeSwipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUp2ShowTabBar:)];
    welcomeSwipeDown.direction = UISwipeGestureRecognizerDirectionUp;
    
    [self.welcomeView addGestureRecognizer:welcomeSwipeUp];
    [self.welcomeView addGestureRecognizer:welcomeSwipeDown];
    
}


- (void)addWelcomePanGesture
{
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.welcomeView addGestureRecognizer:panGesture];
}

- (void)pan:(UIPanGestureRecognizer *)panGestureRecongnizer
{
    CGPoint translation = [panGestureRecongnizer translationInView:self.welcomeView];
//    if slide to right  spring back.
    if (self.welcomeView.frame.origin.x < 0){
        [UIView animateWithDuration:0.3 delay:0.2f usingSpringWithDamping:10.0f initialSpringVelocity:10.0f options:0 animations:^{
            self.welcomeView.frame = self.view.frame;
        } completion:nil];
        return;
    }
    
    ZCLog(@"%s x = %f", __func__, self.welcomeView.frame.origin.x);
//     move
    panGestureRecongnizer.view.transform = CGAffineTransformTranslate(panGestureRecongnizer.view.transform, translation.x, 0);
    panGestureRecongnizer.view.alpha -= 1.5f * (CGFloat)translation.x/self.view.bounds.size.width;
    self.wordsView.alpha = 1- panGestureRecongnizer.view.alpha;
    
    [panGestureRecongnizer setTranslation:CGPointZero inView:self.welcomeView];
    
    if(panGestureRecongnizer.state == UIGestureRecognizerStateEnded){
        ZCLog(@"pan ended");
//        spring back
        if (self.welcomeView.frame.origin.x < 0.3f * viewFrame.size.width) {
            [UIView animateWithDuration:0.3f animations:^{
                self.welcomeView.frame = viewFrame;
                self.welcomeView.alpha = 1.0f;
                self.wordsView.alpha = 0.0f;
            }];
        }else{
            
            [UIView animateWithDuration:0.25f animations:^{
//
                
                self.welcomeView.frame = rightViewFrame;
                
                self.welcomeView.alpha = 0;
                
                self.welcomeView.hidden = YES;
 
                [self showWordView];
                
            } completion:^(BOOL finished) {
                
//                [self showWordView];
                self.welcomeView.frame = rightViewFrame;

        ZCLog(@"after show word view welcom view frame = %@", NSStringFromCGRect(self.welcomeView.frame));
         ZCLog(@"after show word view word view frame = %@", NSStringFromCGRect(self.welcomeView.frame));
        

#warning comfirm the wordview.hidden == No;
                
//                self.wordsView.hidden = NO;
                
            }];
        }
    }
    
}

///  for kidding
- (void)addWelcomeTapGesture
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(welcomeTap:)];
    [self.welcomeView addGestureRecognizer:tapGesture];
    
}

- (void)welcomeTap:(UITapGestureRecognizer *)taprecognizer
{
    CATransition *animation = [[CATransition alloc] init];
    
    animation.type = @"rippleEffect";
    
    ZCLog(@"nimei..");
    
    animation.subtype = kCATransition;
    
    [self.bg.layer addAnimation:animation forKey:nil];
}


///**************************************    swipe    **************************************

- (void)swipeWord:(UISwipeGestureRecognizer *)swipeRecognizer
{
    
    if (!self.welcomeView.hidden) return;
    if (self.welcomeView.dashboardView.testModeBtn.state == UIControlStateSelected) {
        self.wordsView.detailsView.hidden = YES;
    }
    
    
    CATransition *transition = [[CATransition alloc] init];
    
    transition.type = @"reveal";  //good.
//        transition.type = @"push";  //
//            transition.type = @"moveIn";  //
    
    if (swipeRecognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        transition.subtype = kCATransitionFromRight;
        _userPrograss ++;
    }else if(swipeRecognizer.direction == UISwipeGestureRecognizerDirectionRight){

        transition.subtype = kCATransitionFromLeft;
        _userPrograss --;

    }
    
    
    
    
#pragma mark hide the bar again
    
    [self hideTabBar];
    
#warning need tract it out ...    use pop herererererererere
    
    if (_userPrograss < 0) {
        
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(_distinationPoint.x - 30,  _distinationPoint.y)];
        
        animation.toValue = [NSValue valueWithCGPoint:_distinationPoint];
        
        animation.springBounciness = 20.0;
        
        animation.springSpeed = 20.0;
        
        [self.wordsView pop_addAnimation:animation forKey:@"changeposition"];

        _userPrograss = 0;
        
        UILabel *popView = [[UILabel alloc] initWithFrame:CGRectMake(0, viewFrame.size.height *0.77f, viewFrame.size.width , 80)];
        popView.text = @"Slide forward";
//        popView.backgroundColor = [UIColor colorWithWhite: 0.0f alpha: 0.1f];
        
        
        popView.textColor = [UIColor whiteColor];
        popView.textAlignment = NSTextAlignmentCenter;
        popView.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:40.0f];
        
        [self.view addSubview:popView];
        
        FBShimmeringView *indicator = [[FBShimmeringView alloc] initWithFrame:popView.frame];
        [self.view addSubview:indicator];
        
        indicator.contentView = popView;
        indicator.shimmeringOpacity = 0.55f;
        indicator.shimmeringSpeed = 200.0f;
        indicator.shimmeringDirection = FBShimmerDirectionLeft;
        indicator.shimmeringHighlightLength = 0.5f;
        indicator.shimmering = YES;
        
            [UIView animateWithDuration:1.0f delay:3.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
                popView.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [popView removeFromSuperview];
                [indicator removeFromSuperview];
            }];
        return;
    }
    
    ///   judge if to hidr btn!
    if ([self.dataCenter.unknownWords containsObject:self.dataCenter.words[_userPrograss]]) {
        self.wordsView.addBtn.hidden = YES;
    }else {self.wordsView.addBtn.hidden = NO;}
    
    self.wordsView.spellingView.text = [self.words[_userPrograss] spelling];
    
     NSString *meaning= [NSString stringWithFormat:@"%@\n%@",[self.words[_userPrograss] meaning], [self.words[_userPrograss] usage]];
    self.wordsView.detailsView.text = meaning;
//    judge if the line is one one..
    
//    NSDictionary *dict = [n]
//    ZCLogObj(@(meaning.length));
//    ZCLog(@"...%d", meaning.length);
//    if (meaning.length > 10) {self.wordsView.detailsView.textAlignment = NSTextAlignmentLeft;}
    
    transition.duration = .5f;
    [self.wordsView.layer addAnimation:transition forKey:nil];
    
    self.dataCenter.userReadingProgressMarker = _userPrograss;
    
}

 - (void)swipeDown2Reveal:(UIGestureRecognizer *)swipeDownRecognizer
 {

     
     [self hideTabBar];
//         [UIView animateWithDuration:0.25 animations:^{
//             
//             self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, 49);
//             
//         }];
     if (self.wordsView.detailsView.hidden == NO ) return;
//         show words
     self.wordsView.detailsView.alpha = 0;
     self.wordsView.detailsView.hidden = NO;
     [UIView animateWithDuration:0.25f animations:^{
         self.wordsView.detailsView.alpha = 1;
     }];
     
     ZCLog(@"%s", __func__);
 }


- (void)swipeUp2ShowTabBar:(UIGestureRecognizer *)swipeUpRecognier
{
    [self showTabBar];
}


/** tap */
/**
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
    //    self.wordLabel.text = self.wordLabel.text = [self.words[self.userPrograss] spelling];
    //    [self.wordLabel sizeToFit];
    
    //    ZCLog(@"%@", self.wordLabel.text);
    if (_userPrograss%KwordInSection == 0 ) {
        self.addBtn.enabled = NO;
        [alertRight show];
        //        self.wordLabel.text = [NSString stringWithFormat:@"Day %@ \nClick to Start", @(_userPrograss/KwordInSection+1)];
    }
}
*/

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
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, 0);
        }];

    }
}

- (void)addSideGesture
{
    UIScreenEdgePanGestureRecognizer *rightSideGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(showRightSideWelcome:)];
    rightSideGesture.edges = UIRectEdgeRight;
    
//    ZCLog(@"...%@", NSStringFromCGRect(self.welcomeView.frame));
    
    [self.view addGestureRecognizer:rightSideGesture];
}
- (void)showRightSideWelcome:(UIScreenEdgePanGestureRecognizer *)edgePanGestureRecognier
{
    
    ZCLog(@"%s",__func__);
    
    CGRect slideWecomeFrame = CGRectMake(self.view.frame.size.width - 50, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.welcomeView.hidden = NO;   //now word view will hide??
    
    if (edgePanGestureRecognier.state == UIGestureRecognizerStateBegan) {
        

        self.welcomeView.frame = slideWecomeFrame;
    }
    
    CGPoint translation = [edgePanGestureRecognier translationInView:self.welcomeView];
    
    self.welcomeView.transform = CGAffineTransformTranslate(self.welcomeView.transform, translation.x, 0);
    
    self.welcomeView.alpha += - 1.5f * translation.x/self.view.bounds.size.width;
    self.wordsView.alpha = 1.0f - self.welcomeView.alpha;
    
    ZCLog(@"..%@", NSStringFromCGRect(self.welcomeView.frame));
    
    [edgePanGestureRecognier setTranslation:CGPointZero inView:self.welcomeView];
    
    if (edgePanGestureRecognier.state == UIGestureRecognizerStateEnded) {
        
        ZCLog(@" heheheh");

        if (self.welcomeView.frame.origin.x < viewFrame.size.width * 0.5) {
            
            [UIView animateWithDuration:0.25f animations:^{
                
                self.welcomeView.frame = viewFrame;
                self.welcomeView.alpha = 1.0f;
                self.wordsView.alpha = 0;
                
            } completion:^(BOOL finished) {
                
                
            }];
        }else{
        
            [UIView animateWithDuration:1.0f animations:^{
                
                self.welcomeView.frame = slideWecomeFrame;
                self.welcomeView.alpha = 0;
                self.welcomeView.hidden = YES;
                
                [self showWordView];
            } completion:nil];
        }
        ZCLog(@"slide after welcom view frame = %@", NSStringFromCGRect(self.welcomeView.frame));
    }

}



///**************************************   add btn clicked  - notification send to third view controller     **************************************
#pragma mark - click button to  add unknown words to the vocabulary list ^ _ ^
- (void)add2WordList
{
    ZCLog(@"added");
//    if (![self.dataCenter.unknownWords containsObject:self.dataCenter.words[_userPrograss]]) {
    
        [ZCMessageSoundEffect playMessageSentSound];
        
        self.dataCenter.wordIsAdded = YES;
        
        [self.dataCenter.unknownWords addObject:self.dataCenter.words[_userPrograss]];
        
//        ZCLog(@"%@   hahhahhahaha", @(self.dataCenter.unknownWords.count));
        
//        dosome thing
//        [self.wordsView.layer shake];
        
#pragma mark - test
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
        
        CGSize size = self.wordsView.frame.size;
        anim.toValue = [NSValue valueWithCGSize:size];
        
        [self.wordsView.layer pop_addAnimation:anim forKey:@"changesize"];
        /////
        ZCTabBarController *rootVC = (ZCTabBarController *)[[UIApplication sharedApplication].windows[0] rootViewController];
        
        ZCNoHighLightBtn *shaker = (ZCNoHighLightBtn *)rootVC.customTabBar.subviews[2];
        
        [self showTabBar];
        [shaker.layer shake];
        shaker.selected = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideTabBar];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.25f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            shaker.selected = NO;
        });
    
    
//        [self hideTabBar];
        
        
//    }else{
        //        alert
//        [ZCMessageSoundEffect playAlertSound];
//    }
    
}

- (void)showWordView
{
    
    ZCLog(@"show wordView");
//    animations first
    _distinationPoint = self.wordsView.center;
    self.wordsView.hidden = NO;
    
    [UIView animateWithDuration:0.1f animations:^{self.wordsView.alpha = 1.0f;}];
    
    
    
//    self.wordsView.center = CGPointMake(_distinationPoint.x, -200);
/**  pop bump
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(_distinationPoint.x, _distinationPoint.y-30)];
    
    animation.toValue = [NSValue valueWithCGPoint:_distinationPoint];
    
    animation.springBounciness = 20.0;

    animation.springSpeed = 20.0;
    
    [self.wordsView pop_addAnimation:animation forKey:@"changeposition"];
    
    if (self.welcomeView.dashboardView.testModeBtn.state == UIControlStateSelected) {
        self.wordsView.detailsView.hidden = YES;
    }
*/
    ZCLog(@"show word view welcom view frame = %@", NSStringFromCGRect(self.welcomeView.frame));
//    self.welcomeView.frame = rightViewFrame;
}

- (void)showTabBar
{
    ZCLog(@"%s", __func__);
    ZCLog(@"%@", NSStringFromCGPoint(self.tabBarController.tabBar.center));
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}


- (void)hideTabBar
{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  (int64_t)(0.5 * NSEC_PER_SEC)),dispatch_get_main_queue() , ^{
    
        //            [self.navigationController setNavigationBarHidden:YES animated:YES];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0, self.tabBarController.tabBar.bounds.size.height);
        }];
        
//    });

}










@end
