//
//  M2_firstViewController.h
//  SoccerClub
//
//  Created by GCCC on 16/1/13.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface M2_firstViewController : UIViewController

@property (nonatomic,retain)NSMutableDictionary * homeInfoDic;


@property (nonatomic,retain)NSString * sid;
@property (nonatomic,retain)NSString * time;
@property (nonatomic,retain)NSString * match;
//@property (nonatomic,retain)UIImage * guestImage;
//@property (nonatomic,retain)UIImage * homeImage;

//  每日
@property (nonatomic,retain)UILabel * timeLabel;
@property (nonatomic,retain)UILabel * titlLabel;
@property (nonatomic,retain)UILabel * projectTitle;


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


@property (nonatomic,retain)UIImageView * backImage;//  背景图片

@property (nonatomic,retain)UILabel * PromptLabel;//    没有福利时的提示

@end
