//
//  firstTableViewCell.h
//  SoccerClub
//
//  Created by GCCC on 16/1/11.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface M_firstTableViewCell : UITableViewCell
@property (nonatomic,retain)UIImageView * backImage;//  背景图片
@property (nonatomic,retain)UILabel * timeLabel;//  时间Label
//@property (nonatomic,retain)UIButton * zanButton;//   点赞图标
//@property (nonatomic,retain)UILabel * zanNumber;//  点赞的人数
@property (nonatomic,retain)UILabel * source;//  视频来源
@property (nonatomic,retain)UILabel * soccerLeagueName;//   足球联赛名称
@property (nonatomic,retain)UILabel * soccerName;// 足球比赛的名称
@property (nonatomic,retain)UIImageView * TimerImage;// 定时器图片

@end
