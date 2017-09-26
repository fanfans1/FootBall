//
//  HttpManager.h
//  SoccerClub
//
//  Created by tyj on 2017/9/26.
//  Copyright © 2017年 程龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpManager : NSObject

/**
 *  GET网络请求
 *
 *  @param urlStr     url
 *  @param parameters 参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
+ (void)getUrl:(NSString *)urlStr
    Parameters:(id)parameters
       success:(void (^)(id responseData))success
       failure:(void (^)(NSError *error))failure;

@end
