//
//  Model.h
//  SoccerClub
//
//  Created by xalo on 16/1/11.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *digest;
@property (nonatomic,retain) NSString *imgSid;
@property (nonatomic,retain) NSString *button;
@property (nonatomic,retain) NSString *buttonColor;
@property (nonatomic,retain) NSDictionary *target;
@property (nonatomic,retain) NSDictionary *web;
@property (nonatomic,retain) NSString *next;

// 初始化
-(instancetype)initWithDic:(NSDictionary *)dic;

@end
