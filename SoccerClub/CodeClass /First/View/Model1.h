//
//  Model1.h
//  SoccerClub
//
//  Created by xalo on 16/1/11.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model1 : NSObject

//+(Model1 *)defaultModel;

@property (nonatomic,retain) NSString *thumb;
@property (nonatomic,retain) NSString *scTitle;
@property (nonatomic,retain) NSString *type;
@property (nonatomic,retain) NSDictionary *touchEvent;
@property (nonatomic,retain) NSDictionary *thumbInfo;


// 初始化
-(instancetype)initWithDic:(NSDictionary *)dic;
@end
