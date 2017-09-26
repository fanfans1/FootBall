//
//  CollectionVideoTableViewCell1.m
//  SoccerClub
//
//  Created by xalo on 16/1/13.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "CollectionVideoTableViewCell1.h"

@implementation CollectionVideoTableViewCell1
- (UIImageView *)videoImageView{
    if (!_videoImageView) {
        _videoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(6, 4, CGRectGetWidth(self.frame)/3*1, CGRectGetHeight(self.frame)-8)];
        [self addSubview:_videoImageView];
    }
    return _videoImageView;
}
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/3*1+10, 6, CGRectGetWidth(self.frame)/3*2-16, CGRectGetHeight(self.frame)/3*2)];
        _nameLabel.numberOfLines = 0;
        [self addSubview:_nameLabel];
    }
    return _nameLabel;
}
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/5*2+10, CGRectGetHeight(self.frame)/3*2-15, CGRectGetWidth(self.frame)/5*3-16, CGRectGetHeight(self.frame)/3*2)];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (void)awakeFromNib {
    // Initialization code
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
