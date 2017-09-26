//
//  Model.m
//  SoccerClub
//
//  Created by xalo on 16/1/11.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "Model.h"

@implementation Model

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.title = [dic objectForKey:@"title"];
        self.digest = [dic objectForKey:@"digest"];
        self.imgSid = [dic objectForKey:@"imgSid"];
        self.button = [dic objectForKey:@"button"];
        self.buttonColor = [dic objectForKey:@"buttonColor"];
        self.target = [dic objectForKey:@"target"];
        self.web = [dic objectForKey:@"web"];
        self.next = [dic objectForKey:@"next"];
    }
    return self;
}


@end
