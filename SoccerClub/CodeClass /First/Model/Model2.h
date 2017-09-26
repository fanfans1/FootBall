//
//  Model2.h
//  SoccerClub
//
//  Created by xalo on 16/1/12.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model2 : NSObject

@property (nonatomic,retain) NSString *leagueDesc;
@property (nonatomic,retain) NSString *timeName;
@property (nonatomic,retain) NSDictionary *guestInfo;
@property (nonatomic,retain) NSDictionary *homeInfo;
@property (nonatomic,retain) NSString *sid;

// 初始化
-(instancetype)initWithDic:(NSDictionary *)dic;
@end
