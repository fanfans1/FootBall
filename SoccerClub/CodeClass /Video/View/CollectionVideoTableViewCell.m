//
//  CollectionVideoTableViewCell.m
//  SoccerClub
//
//  Created by xalo on 16/1/13.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "CollectionVideoTableViewCell.h"

@implementation CollectionVideoTableViewCell

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 8, CGRectGetWidth(self.frame)-10, CGRectGetHeight(self.frame)/3*2)];
        _nameLabel.numberOfLines = 2;
        [self addSubview:_nameLabel];
    }
    return _nameLabel;
}
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetHeight(self.frame)/3*2+4, CGRectGetWidth(self.frame)-20, CGRectGetHeight(self.frame)/3-12)];
        _timeLabel.textAlignment = NSTextAlignmentRight;
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
