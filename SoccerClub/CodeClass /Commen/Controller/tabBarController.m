//
//  tabBarController.m
//  SoccerClub
//
//  Created by xalo on 16/1/11.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "tabBarController.h"

@interface tabBarController ()

@end

@implementation tabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航条颜色
    UINavigationBar *bar = [UINavigationBar appearance] ;
    bar.barTintColor = BACKGROUNDCOLOR;
    
    //设置字体颜色
    bar.tintColor = [UIColor whiteColor];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UITabBar *bar1 = [UITabBar appearance];
//    bar1.barTintColor = [UIColor colorWithRed:169/255.0 green:169/255.0 blue:169/255.0 alpha:1.0];
    bar1.barTintColor = [UIColor whiteColor];
    //设置字体颜色
    bar1.tintColor = [UIColor blackColor];;
//    [bar1 setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];

    
    FirstRootViewController *firstVC = [[FirstRootViewController alloc]init];
    MatchRootViewController *matchVC = [[MatchRootViewController alloc]init];
    VideoRootViewController *videoVC = [[VideoRootViewController alloc]init];
    UINavigationController *firstNavC = [[UINavigationController alloc]initWithRootViewController:firstVC];
    UINavigationController *matchNavC = [[UINavigationController alloc]initWithRootViewController:matchVC];
    UINavigationController *videoNavC = [[UINavigationController alloc]initWithRootViewController:videoVC];
    
    [self addChildViewController:firstNavC];
    [self addChildViewController:matchNavC];
    [self addChildViewController:videoNavC];
    firstNavC.tabBarItem.title = @"首页";
    firstNavC.tabBarItem.image = [UIImage imageNamed:@"tabbar_home.png"];
    matchNavC.tabBarItem.title = @"比赛";
    matchNavC.tabBarItem.image = [UIImage imageNamed:@"tabbar_vs.png"];
    videoNavC.tabBarItem.title = @"视频";
    videoNavC.tabBarItem.image = [UIImage imageNamed:@"tabbar_video.png"];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
