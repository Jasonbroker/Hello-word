//
//  AppDelegate.m
//  wordList
//
//  Created by Jason Zhou on 7/6/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "AppDelegate.h"
#import "ZCRootController.h"
#import "ZCFilePathManager.h"
#import "Common.h"

@interface AppDelegate ()
            

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [application.windows[0] ba];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
//
//    ZCRootController *rootVC = (ZCRootController *)[application.windows[0] rootViewController];
//    NSLog(@"%@", application.windows);
//
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"root"]];
//    [rootVC.view addSubview:imageView];
//    [rootVC.view sendSubviewToBack:imageView];

    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
//    UIApplication *app = [UIApplication sharedApplication];
//    NSLog(@"%@", [application.windows[0] rootViewController]);
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
#warning 我了个去，死活写不进去。。。
    ZCRootController *rootVC = (ZCRootController *)[application.windows[0] rootViewController];
    NSUserDefaults *readingProgress = [NSUserDefaults standardUserDefaults];
    
    [readingProgress setObject:@(rootVC.userReadingProgressMarker) forKey:KUserReadingProgressMarkerKey];
    
    
    [readingProgress synchronize];
    
#warning anyway, 我是不想这么干的。。。
    
//    NSDictionary *wordCount = [NSDictionary dictionaryWithObject:@(rootVC.userReadingProgressMarker) forKey:KUserReadingProgressMarkerKey];
    
    NSDictionary *wordCount = [NSDictionary dictionaryWithObjectsAndKeys:@(rootVC.userReadingProgressMarker),KUserReadingProgressMarkerKey,@(rootVC.userMaxReadingProgressMarker), KUserMaxReadingProgressMarker, nil];
    
    [wordCount writeToFile:[ZCFilePathManager userProgressPath] atomically:YES];

    NSLog(@"%@。。。。。%d。。", @(rootVC.userReadingProgressMarker), rootVC.userMaxReadingProgressMarker);

    
}

@end
