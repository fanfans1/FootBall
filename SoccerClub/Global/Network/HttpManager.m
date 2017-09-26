//
//  HttpManager.m
//  SoccerClub
//
//  Created by tyj on 2017/9/26.
//  Copyright © 2017年 程龙. All rights reserved.
//

#import "HttpManager.h"

#define RequestTimeOut 30

@implementation HttpManager

+ (AFHTTPSessionManager *)httpManager{
    //获取请求对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置返回类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //设置超市
    manager.requestSerializer.timeoutInterval = RequestTimeOut;
    return manager;
}

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
       failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *manager = [self httpManager];
    
    //加载的时候有小菊花
    
    //
    [manager GET: urlStr parameters: parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id responseData = [responseObject mj_JSONObject];
        success(responseData);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}



@end
