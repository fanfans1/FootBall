//
//  SandBoxPaths.m
//  Class_18_SandBox
//
//  Created by xalo on 15/12/16.
//  Copyright (c) 2015年 程龙. All rights reserved.
//

#import "SandBoxPaths.h"

@implementation SandBoxPaths

// 得到沙盒主目录
+ (NSString *)homePath{
    return NSHomeDirectory();
}
// 得到Documents文件夹目录
+ (NSString *)documentsPath{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
}
// 得到library文件夹目录
+ (NSString *)libraryPath{
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
}
// 得到caches文件件目录
+ (NSString *)cachesPath{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
}


@end
