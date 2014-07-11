//
//  NSString+Path.h
//  02-沙盒演练
//
//  Created by 刘凡 on 14-7-9.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Path)

/** 文档目录 */
+ (NSString *)documentPath;
/** 缓存目录 */
+ (NSString *)cachePath;
/** 临时目录 */
+ (NSString *)tempPath;

/**
 *  添加文档路径
 */
- (NSString *)appendDocumentPath;
/**
 *  添加缓存路径
 */
- (NSString *)appendCachePath;
/**
 *  添加临时路径
 */
- (NSString *)appendTempPath;

@end
