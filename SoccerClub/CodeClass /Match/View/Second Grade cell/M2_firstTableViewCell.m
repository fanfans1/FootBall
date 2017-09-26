//
//  M2_firstTableViewCell.m
//  SoccerClub
//
//  Created by GCCC on 16/1/13.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "M2_firstTableViewCell.h"

@implementation M2_firstTableViewCell

//  每日
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 80, 30)];
        [self.contentView addSubview:_timeLabel];
    }
    
    return _timeLabel;
}

-(UILabel *)titlLabel{
    if (!_titlLabel) {
        _titlLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 30, 100, 30)];
        [self.contentView addSubview:_titlLabel];
    }
    
    return _titlLabel;
}



//  比赛

-(UILabel *)homeInfo{
    if (!_homeInfo) {
        _homeInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 80, 30)];
        [self.contentView addSubview:_homeInfo];
    }
    return _homeInfo;
    
}

-(UILabel *)guestInfo{
    if (!_guestInfo) {
        _guestInfo = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-20, 60, 80, 30)];
        [self.contentView addSubview:_guestInfo];
    }
    return _guestInfo;
    
}

-(UILabel *)homeScore{
    if (!_homeScore) {
        _homeScore = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 60, 30)];
        [self.contentView addSubview:_homeScore];
    }
    return _homeScore;
    
}


-(UILabel *)guestScore{
    if (!_guestScore) {
        _guestScore = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-60, 30, 80, 30)];
        [self.contentView addSubview:_guestScore];
    }
    return _guestScore;
    
}



-(UIImageView *)homeLoge{
    if (!_homeLoge) {
        _homeLoge = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 30, 30)];
        [self.contentView addSubview:_homeLoge];
    }
    return _homeLoge;
    
}


-(UIImageView  *)guestLoge{
    if (!_guestLoge) {
        _guestLoge = [[UIImageView  alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-10, 30, 30, 30)];
        [self.contentView addSubview:_guestLoge];
    }
    return _guestLoge;
    
}


-(UILabel *)matchTime{
    if (!_matchTime) {
        _matchTime = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame)-60)/2, 60, 80, 30)];
        [self.contentView addSubview:_matchTime];
    }
    return _matchTime;
    
}

-(UILabel *)leagueDesc{
    if (!_leagueDesc) {
        _leagueDesc = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame)-40)/2, 30, 60, 30)];
        [self.contentView addSubview:_leagueDesc];
    }
    return _leagueDesc;
    
}

-(UILabel *)matchCase{
    if (!_matchCase) {
        _matchCase = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame)-40)/2, 30, 60, 30)];
        [self.contentView addSubview:_matchCase];
    }
    return _matchCase;
    
}


- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
