//
//  VideoCollectionTableViewCell.m
//  SoccerClub
//
//  Created by xalo on 16/1/12.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "VideoCollectionTableViewCell.h"

@implementation VideoCollectionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)/3*2)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.numberOfLines = 0;
        [self addSubview:_nameLabel];
    }
    return _nameLabel;
}
- (UILabel *)matchTimeLabel{
    if (!_matchTimeLabel) {
        _matchTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(5+CGRectGetWidth(self.frame)/6, CGRectGetHeight(self.bounds)/3*2+5, CGRectGetWidth(self.frame)/3, CGRectGetHeight(self.bounds)/3-10)];
        _matchTimeLabel.font = [UIFont systemFontOfSize:12];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetHeight(self.bounds)/3*2+5, CGRectGetWidth(self.frame)/6, CGRectGetHeight(self.bounds)/3-10)];
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

- (UITextField *)tag2TextField{
    if (!_tag2TextField) {
        _tag2TextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-74, CGRectGetHeight(self.bounds)/3*2+8, 33, CGRectGetHeight(self.bounds)/3-10)];
        _tag2TextField.font = [UIFont systemFontOfSize:8];
        _tag2TextField.borderStyle = UITextBorderStyleRoundedRect;
        _tag2TextField.textAlignment = NSTextAlignmentCenter;
        _tag2TextField.layer.cornerRadius = 8;
        _tag2TextField.userInteractionEnabled = NO;
        _tag2TextField.layer.borderWidth = 1;
        [self addSubview:_tag2TextField];
    }
    return _tag2TextField;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
