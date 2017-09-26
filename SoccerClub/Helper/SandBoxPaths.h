//
//  SandBoxPaths.h
//  Class_18_SandBox
//
//  Created by xalo on 15/12/16.
//  Copyright (c) 2015年 程龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SandBoxPaths : NSObject
+ (NSString *)homePath;  // 返回沙盒主路径
+ (NSString *)documentsPath;   // 返回沙盒中documents文件夹路径
+ (NSString *)libraryPath;   // 返回沙盒中library文件夹路径
+ (NSString *)cachesPath;   // libraryCaches文件夹路径
@end
