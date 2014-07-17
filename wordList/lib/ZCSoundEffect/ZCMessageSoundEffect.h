//
//  ZCMessageSoundEffect.h
//  QQ
//
//  Created by Jason Zhou on 7/3/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCMessageSoundEffect : NSObject


/** unknown word added  */
+(void)playMessageSentSound;

+ (void)playMessageReceivedSound;

/** if there is a unknownword exist */
+(void)playAlertSound;

@end
