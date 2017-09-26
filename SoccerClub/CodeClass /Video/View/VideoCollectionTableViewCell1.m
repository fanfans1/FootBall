//
//  VideoCollectionTableViewCell1.m
//  SoccerClub
//
//  Created by xalo on 16/1/18.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "VideoCollectionTableViewCell1.h"

@implementation VideoCollectionTableViewCell1

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)/3*2)];
        _nameLabel.numberOfLines = 0;
        [self addSubview:_nameLabel];
    }
    return _nameLabel;
}
- (UILabel *)matchTimeLabel{
    if (!_matchTimeLabel) {
        _matchTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(5+CGRectGetWidth(self.frame)/6, CGRectGetHeight(self.bounds)/3*2+10, CGRectGetWidth(self.frame)/3, CGRectGetHeight(self.bounds)/3-10)];
        _matchTimeLabel.font = [UIFont systemFontOfSize:12];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetHeight(self.bounds)/3*2+10, CGRectGetWidth(self.frame)/6, CGRectGetHeight(self.bounds)/3-10)];
        label.text = @"比赛时间:";
        label.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:_matchTimeLabel];
        [self addSubview:label];
    }
    return _matchTimeLabel;
}

- (UITextField *)tag1TextField{
    if (!_tag1TextField) {
        _tag1TextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-37,CGRectGetHeight(self.bounds)/3*2+8 , 33, CGRectGetHeight(self.bounds)/3-10)];
        _tag1TextField.font = [UIFont systemFontOfSize:8];
        _tag1TextField.borderStyle = UITextBorderStyleRoundedRect;
        _tag1TextField.textAlignment = NSTextAlignmentCenter;
        _tag1TextField.layer.cornerRadius = 8;
        _tag1TextField.userInteractionEnabled = NO;
        _tag1TextField.layer.borderWidth = 1;
        [self addSubview:_tag1TextField];
    }
    return _tag1TextField;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
