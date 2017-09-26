//
//  M_thiredTableViewCell.h
//  SoccerClub
//
//  Created by GCCC on 16/1/12.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface M_thiredTableViewCell : UITableViewCell
@property (nonatomic,retain)UIImageView * backImage;//  背景图片

@property (nonatomic,retain)UILabel * soccerLeagueName;//   足球联赛名称

@property (nonatomic,retain)UILabel * soccerName;// 足球比赛的名称

@property (nonatomic,retain)UILabel * source;//  视频

//@property (nonatomic,retain)UILabel * CuttingLine;//    分割线

@property (nonatomic,retain)UILabel * guestInfo;//  客场队

@property (nonatomic,retain)UIImageView * guestLogo;//  客场队的logo

@property (nonatomic,retain)UILabel * guestScore;//  客场分数

@property (nonatomic,retain)UILabel * homeInfo;//   主场队

@property (nonatomic,retain)UIImageView * homeLogo;//   主场对的logo

@property (nonatomic,retain)UILabel * homeScore;//  主场对的比分

@property (nonatomic,retain)UILabel * fenHao;// 分号



@end
