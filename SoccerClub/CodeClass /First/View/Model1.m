//
//  Model1.m
//  SoccerClub
//
//  Created by xalo on 16/1/11.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "Model1.h"

@implementation Model1

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.thumb = [dic objectForKey:@"thumb"];
        self.scTitle = [dic objectForKey:@"title"];
        self.type = [dic objectForKey:@"type"];
        self.touchEvent = [dic objectForKey:@"touchEvent"];
        self.thumbInfo = [dic objectForKey:@"thumbInfo"];
    }
    return self;
}


//static Model1 *model1 = nil;
//+(Model1 *)defaultModel{
//    @synchronized(self) {
//        if (model1 == nil) {
//            model1 = [[Model1 alloc] init];
//        }
//        return model1;
//    }
//}




@end
