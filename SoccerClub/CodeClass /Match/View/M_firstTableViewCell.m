//
//  firstTableViewCell.m
//  SoccerClub
//
//  Created by GCCC on 16/1/11.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "M_firstTableViewCell.h"
#define FONT [UIFont systemFontOfSize:15]
#define SFONT [UIFont systemFontOfSize:12]
@implementation M_firstTableViewCell

//  背景图片
-(UIImageView *)backImage{
    if (!_backImage) {
        _backImage = [[UIImageView alloc] initWithFrame:CGRectMake(5,CGRectGetHeight(self.frame)/25, CGRectGetWidth(self.frame)-10, CGRectGetHeight(self.frame)-10)];
        [self.contentView addSubview:_backImage];
    }
    return _backImage;
}



//  比赛开始的时间
-(UILabel *)timeLabel{
    
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/20, CGRectGetHeight(self.frame)/6, CGRectGetWidth(self.frame)/6, CGRectGetHeight(self.frame)/4)];
        _timeLabel.textColor = [UIColor redColor];
        _timeLabel.layer.cornerRadius = 10;
        _timeLabel.layer.borderWidth = 3;
        _timeLabel.layer.borderColor =[UIColor redColor].CGColor ;
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = FONT;
        [self.contentView addSubview:_timeLabel];
    }
    
    return _timeLabel;
}


////  点赞图标
//-(UIButton *)zanButton{
//    
//    if (!_zanButton) {
//        _zanButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _zanButton.frame = CGRectMake((CGRectGetWidth(self.frame))/20-3, CGRectGetHeight(self.frame)*2/3,20,20);
////        [_zanButton setImage:[UIImage imageNamed:@"M_dianzan.png"] forState:UIControlStateNormal];
//        [self.contentView addSubview:_zanButton];
//    }
//    return _zanButton;
//}


////  点赞人数
//-(UILabel *)zanNumber{
//    if (!_zanNumber) {
//        _zanNumber = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame))/10+6,CGRectGetHeight(self.frame)/3+10, CGRectGetWidth(self.frame)-10, CGRectGetHeight(self.frame)*2/3)];
//        [self.contentView addSubview:_zanNumber];
//        
//    }
//    return _zanNumber;
//}





//  视频来源
-(UILabel *)source{
    
    if (!_source) {
        _source = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame))/4 , CGRectGetHeight(self.frame)/6-5, CGRectGetWidth(self.frame)*3/4, CGRectGetHeight(self.frame)/4) ];
        _source.font = SFONT;
        [self.contentView addSubview:_source];
    }
    return _source;
}

//  足球联赛名称
-(UILabel *)soccerLeagueName{
    if (!_soccerLeagueName) {
        _soccerLeagueName = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame))/4 , CGRectGetHeight(self.frame)/3-2, CGRectGetWidth(self.frame)/4, CGRectGetHeight(self.frame)/4)];
        _soccerLeagueName.font = SFONT;
        [self.contentView addSubview:_soccerLeagueName];
    }
    return _soccerLeagueName;
}

//  足球比赛名称
-(UILabel *)soccerName{
    if (!_soccerName) {
        _soccerName = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame))/4 , CGRectGetHeight(self.frame)*2/3-5, CGRectGetWidth(self.frame)*3/4-5, CGRectGetHeight(self.frame)/4)];
        _soccerName.numberOfLines = 0;
        _soccerName.font = FONT;
        [self.contentView addSubview:_soccerName];
    }
    return _soccerName;
    
}

//  定时器图片
-(UIImageView *)TimerImage{
    if (!_TimerImage) {
        _TimerImage = [[UIImageView alloc] initWithFrame:CGRectMake(300, 50, 50, 50)];
        [self.contentView addSubview:_TimerImage];
    }
    return _TimerImage;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
