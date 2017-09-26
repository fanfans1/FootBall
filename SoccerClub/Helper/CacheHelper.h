//
//  CacheHelper.h
//  SoccerClub
//
//  Created by xalo on 16/1/18.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheHelper : NSObject
// 写入缓存
+ (void)writeCacheWithData:(NSData *)data
                      name:(NSString *)name;
// 读取缓存
+ (NSData *)readCacheWithName:(NSString *)name;
@end
