//
//  AppDelegate.m
//  SoccerClub
//
//  Created by xalo on 16/1/11.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
//    Reachability *hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
//    [hostReach startNotifier];
    
    tabBarController *tabBar = [[tabBarController alloc]init];
//    UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:tabBar];
    self.window.rootViewController = tabBar;
    
    
    return YES;
}
//网络环境改变回调函数
- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    
//    switch (status)
//    {
//            
//        case NotReachable:
////            NSLog(@"====当前网络状态不可达=======");
//            //其他处理
//            break;
//            
//        case ReachableViaWiFi:
////            NSLog(@"====当前网络状态为Wifi=======");
//            //其他处理
//            break;
//        case ReachableViaWWAN:
////            NSLog(@"====当前网络状态为蜂窝=======");
//            //其他处理
//            break;
//            
//        default:
////            NSLog(@"你是外星来的吗？");
//            //其他处理
//            break;
//    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)applicationDidFinishLaunching:(UIApplication *)application{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    Reachability *hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [hostReach startNotifier];
}
@end
