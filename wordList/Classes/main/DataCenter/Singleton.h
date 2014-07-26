//
//  Singleton.h
//  wordList
//
//  Created by Jason Zhou on 7/26/14.
//  Copyright (c) 2014 Jason Zhou. All rights reserved.
//

#ifndef wordList_Singleton_h
#define wordList_Singleton_h

#define single_h(className) + (id)shared##className;

#define single_m(className) static id _instance; \
+ (id)allocWithZone:(struct _NSZone *)zone{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{    \
NSLog(@"%s", __FUNCTION__); \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
}   \
+ (id)shared##className{  \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{    \
if (!_instance ) {  \
_instance = [[self alloc ] init];   \
}   \
}); \
return _instance;   \
}

#endif

