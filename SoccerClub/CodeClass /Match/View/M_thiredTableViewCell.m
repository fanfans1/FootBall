//
//  M_thiredTableViewCell.m
//  SoccerClub
//
//  Created by GCCC on 16/1/12.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "M_thiredTableViewCell.h"
#define FONT  [UIFont systemFontOfSize:15]
#define SFONT [UIFont systemFontOfSize:12]
@implementation M_thiredTableViewCell

//  背景图片
-(UIImageView *)backImage{
    if (!_backImage) {
        _backImage = [[UIImageView alloc] initWithFrame:CGRectMake(5,CGRectGetHeight(self.frame)/25, CGRectGetWidth(self.frame)-10, CGRectGetHeight(self.frame)-10)];
        [self.contentView addSubview:_backImage];
    }
    return _backImage;
}



// 足球比赛的名称
-(UILabel *)soccerName{
    if (!_soccerName) {
        _soccerName = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth(self.frame), 30)];
        _soccerName.font = FONT;
        _soccerName.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_soccerName];
    }
    return _soccerName;
}



//   足球联赛名称
-(UILabel *)soccerLeagueName{
    if (!_soccerLeagueName) {
        _soccerLeagueName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/20-10, 10, CGRectGetWidth(self.frame)/3, 20)];
        _soccerLeagueName.font = [UIFont systemFontOfSize:14];
        _soccerLeagueName.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_soccerLeagueName];
    }
    return _soccerLeagueName;
}

//  视频
-(UILabel *)source{
    if (!_source) {
        _source = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame )- 160, 10, 150, 20)];
        _source.font = SFONT;
        _source.textAlignment = NSTextAlignmentRight;
        UILabel *CuttingLine = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, CGRectGetWidth(self.frame)-30, 1)];
        CuttingLine.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:CuttingLine];
        [self.contentView addSubview:_source];
    }
    
    return _source;
}

-(UILabel *)guestInfo{
    if (!_guestInfo) {
        _guestInfo = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-130-10, CGRectGetHeight(self.frame)*2/3-10,130 , 30)];
        _guestInfo.font = FONT;
        _guestInfo.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_guestInfo];
    }
    return _guestInfo;
}
    
-(UIImageView *)guestLogo{
    if (!_guestLogo) {
        _guestLogo = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/2+20,CGRectGetHeight(self.frame)*2/3-5, 20, 20)];
        [self.contentView addSubview:_guestLogo];
    }
    
    return _guestLogo;
    
}
    
-(UILabel *)guestScore{
    if (!_guestScore) {
        _guestScore = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/2,CGRectGetHeight(self.frame)*2/3-5, 20, 20)];
        
        [self.contentView addSubview:_guestScore];
        
    }
    return _guestScore;
}

-(UILabel *)homeInfo{
    if (!_homeInfo) {
        _homeInfo = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/20-10, CGRectGetHeight(self.frame)*2/3-10,CGRectGetWidth(self.frame)/3, 30)];
        _homeInfo.font = FONT;
        _homeInfo.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_homeInfo];
    }
    return _homeInfo;
}

-(UIImageView *)homeLogo{
    if (!_homeLogo) {
        _homeLogo = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/2-50, CGRectGetHeight(self.frame)*2/3-5, 20, 20)];
      [self.contentView addSubview:_homeLogo];
    }
    return _homeLogo;
}

-(UILabel *)homeScore{
    if (!_homeScore) {
        _homeScore = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/2-22, CGRectGetHeight(self.frame)*2/3-5, 20, 20)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame)-20)/2, CGRectGetHeight(self.frame)*2/3-8, 20, 20)];
        label.text = @":";
        label.font = [UIFont systemFontOfSize:25];
        [self.contentView addSubview:_homeScore];
        [self.contentView addSubview:label];
    }
    return _homeScore;
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
