//
//  Model2.m
//  SoccerClub
//
//  Created by xalo on 16/1/12.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "Model2.h"

@implementation Model2
-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.leagueDesc = [dic objectForKey:@"leagueDesc"];
        self.timeName = [dic objectForKey:@"timeName"];
        self.guestInfo = [dic valueForKey:@"guestInfo"];
        self.homeInfo = [dic objectForKey:@"homeInfo"];
        self.sid = [dic objectForKey:@"sid"];
    }
    return self;
}
@end
