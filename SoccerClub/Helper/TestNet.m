//
//  TestNet.m
//  SoccerClub
//
//  Created by xalo on 16/1/18.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "TestNet.h"
#import "Reachability.h"
@implementation TestNet

+(BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    if (!isExistenceNetwork) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请检查网络设置" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [NSTimer scheduledTimerWithTimeInterval:2.0
                                         target:self
                                       selector:@selector(timerFireMethod:)
                                       userInfo:alertView
                                        repeats:YES];
        [alertView show];
        return NO;
    }
    return isExistenceNetwork;
}
+ (void)timerFireMethod:(NSTimer*)theTimer
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}@end
