//
//  VideoSiftTableViewCell.m
//  SoccerClub
//
//  Created by xalo on 16/1/12.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "VideoSiftTableViewCell.h"

@implementation VideoSiftTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (UIImageView *)videoImageView{
    if (!_videoImageView) {
        
        _videoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(6, 4, CGRectGetWidth(self.bounds)/3*1, CGRectGetHeight(self.bounds)-12)];
        [self.contentView addSubview:_videoImageView];
    }
    return _videoImageView;
}
- (UILabel *)videoNameLabel{
    if (!_videoNameLabel) {
        _videoNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.bounds)/3*1+11, 8, CGRectGetWidth(self.bounds)/3*2-13, CGRectGetHeight(self.bounds)/2)];
        _videoNameLabel.font = [UIFont systemFontOfSize:15];
        _videoNameLabel.numberOfLines = 0;
        [self.contentView addSubview:_videoNameLabel];
    }
    return _videoNameLabel;
}
- (UILabel *)videoLengthLabel{
    if (!_videoLengthLabel) {
        _videoLengthLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(_videoImageView.bounds)-37, CGRectGetHeight(_videoImageView.bounds)-20, 35, 17)];
        _videoLengthLabel.font = [UIFont systemFontOfSize:12];
        _videoLengthLabel.backgroundColor = [UIColor blackColor];
        _videoLengthLabel.textColor = [UIColor whiteColor];
        _videoLengthLabel.textAlignment = NSTextAlignmentCenter;
        [self.videoImageView addSubview:_videoLengthLabel];
    }
    return _videoLengthLabel;
}
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.bounds)-55, CGRectGetHeight(self.bounds)-35, 50, 20)];
        _timeLabel.font = [UIFont systemFontOfSize:10];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.textColor = [UIColor redColor];
        _timeLabel.layer.borderWidth = 2;
        _timeLabel.layer.borderColor = [UIColor redColor].CGColor;
        _timeLabel.layer.cornerRadius = 10;
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
