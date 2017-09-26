//
//  UserCenterMainVC.m
//  SoccerClub
//
//  Created by tyj on 2017/9/26.
//  Copyright © 2017年 程龙. All rights reserved.
//

#import "UserCenterMainVC.h"

@interface UserCenterMainVC ()

@end

@implementation UserCenterMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self defaultSet];
    
    
    [self setData];
    
    
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -默认设置
- (void)defaultSet{
    self.title = @"我的";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.iconIV.layer.masksToBounds = YES;
    self.iconIV.layer.cornerRadius = 30;
}


#pragma mark -数据填充
- (void)setData{
    
    //
    self.iconIV.backgroundColor = [UIColor cyanColor];
    
    self.userNameL.text = @"塞尼奥尔-杰";
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
