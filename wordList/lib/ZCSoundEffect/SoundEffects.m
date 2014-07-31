//
//  SoundEffects.m
//  QQ
//
//  Created by Jason Zhou on 7/3/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "SoundEffects.h"

@implementation SoundEffects

+ (void)playSoundEffectWithFileName:(NSString *)name type:(NSString *)type
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        SystemSoundID sound;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &sound);
//        AudioServicesPlaySystemSound(sound);
        AudioServicesPlayAlertSound(sound);
        
    }else{
        NSLog(@"Error: audio file not found at path: %@", path);
    }
}

@end
