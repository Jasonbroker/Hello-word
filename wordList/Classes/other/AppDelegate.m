//
//  AppDelegate.m
//  wordList
//
//  Created by Jason Zhou on 7/6/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "AppDelegate.h"
#import "ZCTabBarController.h"
#import "ZCFilePathManager.h"
#import "Common.h"
//  data center
#import "ZCDataCenter.h"
#import "ZCWord.h"

@interface AppDelegate ()


@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [application.windows[0] ba];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    ZCTabBarController *tabBarVC = [[ZCTabBarController alloc] init];
    
    self.window.rootViewController = tabBarVC;
    
    [self.window makeKeyAndVisible];
    
    
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    ZCDataCenter *dataCenter = [ZCDataCenter sharedData];
    
    NSUserDefaults *readingProgress = [NSUserDefaults standardUserDefaults];
    
    [readingProgress setInteger:dataCenter.userReadingProgressMarker forKey:KUserReadingProgressMarkerKey];
    [readingProgress setInteger:dataCenter.userMaxReadingProgressMarker forKey:KUserMaxReadingProgressMarkerKey];
    
    [readingProgress synchronize];
#warning  use core data to revise here!
//    [dataCenter.unknownWords writeToFile:[ZCFilePathManager unknownWordFilePath] atomically:YES];
//   NSLog(@"~~~~~~~~~%d", [[NSFileManager defaultManager] fileExistsAtPath:[ZCFilePathManager unknownWordFilePath]]);
//    NSLog(@"%@", [ZCFilePathManager unknownWordFilePath]);
    [NSKeyedArchiver archiveRootObject: dataCenter.unknownWords toFile: [ZCFilePathManager unknownWordFilePath]];
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
       
}

@end
