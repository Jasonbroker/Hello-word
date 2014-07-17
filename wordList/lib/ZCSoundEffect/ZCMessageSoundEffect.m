//
//  ZCMessageSoundEffect.m
//  QQ
//
//  Created by Jason Zhou on 7/3/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import "ZCMessageSoundEffect.h"
#import "SoundEffects.h"

@implementation ZCMessageSoundEffect

+(void)playMessageSentSound
{
    [SoundEffects playSoundEffectWithFileName:@"messageReceived" type:@"aiff"];
    
}

+ (void)playMessageReceivedSound
{
    [SoundEffects playSoundEffectWithFileName:@"messageSent" type:@"aiff"];
}

+ (void)playAlertSound
{
    [SoundEffects playSoundEffectWithFileName:@"alert" type:@"aiff"];
}



@end
