//
//  ZCMessageSoundEffect.h
//  QQ
//
//  Created by Jason Zhou on 7/3/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCMessageSoundEffect : NSObject

+(void)playMessageSentSound;

+ (void)playMessageReceivedSound;

+(void)playAlertSound;

@end
