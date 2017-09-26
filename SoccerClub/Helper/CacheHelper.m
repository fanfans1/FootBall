//
//  CacheHelper.m
//  SoccerClub
//
//  Created by xalo on 16/1/18.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "CacheHelper.h"
#import "SandBoxPaths.h"
@implementation CacheHelper

+(void)writeCacheWithData:(NSData *)data name:(NSString *)name{
    NSString *pathString = [[SandBoxPaths documentsPath]stringByAppendingString:[NSString stringWithFormat:@"/%@.data",name]];
    [data writeToFile:pathString atomically:YES];
//  NSLog(@"FDSFDSF----%d",[data writeToFile:pathString atomically:YES]);
//    NSLog(@"%@",pathString);
}
+(NSData *)readCacheWithName:(NSString *)name{
    NSString *pathString = [[SandBoxPaths documentsPath]stringByAppendingString:[NSString stringWithFormat:@"/%@.data",name]];
    NSData *data = [NSData dataWithContentsOfFile:pathString];
    return data;
}
@end
