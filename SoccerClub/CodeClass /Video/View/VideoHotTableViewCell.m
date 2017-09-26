//
//  VideoHotTableViewCell.m
//  SoccerClub
//
//  Created by xalo on 16/1/13.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "VideoHotTableViewCell.h"

@implementation VideoHotTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (UIImageView *)videoImageView{
    if (!_videoImageView) {
        
        _videoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(6, 4, CGRectGetWidth(self.bounds)/5*2, CGRectGetHeight(self.bounds)-12)];
        [self.contentView addSubview:_videoImageView];
    }
    return _videoImageView;
}
- (UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.bounds)/5*2+8, 15, 19, 13)];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_numberLabel];
    }
    return _numberLabel;
}
- (UILabel *)videoNameLabel{
    if (!_videoNameLabel) {
        _videoNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.bounds)/5*2+26, 15, CGRectGetWidth(self.bounds)/5*3-30, CGRectGetHeight(self.bounds)/2)];
//        _videoNameLabel.textAlignment = NSTextAlignmentCenter;
        _videoNameLabel.font = [UIFont systemFontOfSize:15];
        _videoNameLabel.numberOfLines = 0;
        [self.contentView addSubview:_videoNameLabel];
    }
    return _videoNameLabel;
}
- (UILabel *)videoLengthLabel{
    if (!_videoLengthLabel) {
        _videoLengthLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(_videoImageView.bounds)-40, CGRectGetHeight(_videoImageView.bounds)-20, 40, 17)];
        _videoLengthLabel.font = [UIFont systemFontOfSize:10];
        _videoLengthLabel.backgroundColor = [UIColor blackColor];
        _videoLengthLabel.textColor = [UIColor whiteColor];
        _videoLengthLabel.textAlignment = NSTextAlignmentCenter;
        [self.videoImageView addSubview:_videoLengthLabel];
    }
    return _videoLengthLabel;
}
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.bounds)-92, CGRectGetHeight(self.bounds)-35, 70, 27)];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.textColor = [UIColor redColor];
        _timeLabel.layer.borderWidth = 2;
        _timeLabel.layer.borderColor = [UIColor redColor].CGColor;
        _timeLabel.layer.cornerRadius = 12;
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
