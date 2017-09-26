//
//  M2_firstTableViewCell.h
//  SoccerClub
//
//  Created by GCCC on 16/1/13.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface M2_firstTableViewCell : UITableViewCell


//  每日
@property (nonatomic,retain)UILabel * timeLabel;
@property (nonatomic,retain)UILabel * titlLabel;



//  比赛
@property (nonatomic,retain)UIImageView * homeLoge;
@property (nonatomic,retain)UIImageView * guestLoge;

@property (nonatomic,retain)UILabel * homeScore;
@property (nonatomic,retain)UILabel * guestScore;

@property (nonatomic,retain)UILabel * leagueDesc;// 赛事

@property (nonatomic,retain)UILabel * matchTime;//  比赛开始时间 是个时间戳

@property (nonatomic,retain)UILabel * matchCase;//  比赛情况 开始还是未开始

@property (nonatomic,retain)UILabel * homeInfo;
@property (nonatomic,retain)UILabel * guestInfo;

@end
