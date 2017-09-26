//
//  UserCenterMainVC.h
//  SoccerClub
//
//  Created by tyj on 2017/9/26.
//  Copyright © 2017年 程龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCenterMainVC : UIViewController
//  用户头像
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;

//  用户名称
@property (weak, nonatomic) IBOutlet UILabel *userNameL;

//  显示页面
@property (weak, nonatomic) IBOutlet UITableView *showView;


@end
