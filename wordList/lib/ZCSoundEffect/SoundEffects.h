//
//  SoundEffects.h
//  QQ
//
//  Created by Jason Zhou on 7/3/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface SoundEffects : NSObject

+ (void)playSoundEffectWithFileName:(NSString *)name type:(NSString *)type;

@end
