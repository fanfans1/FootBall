//
//  photoTableViewCell.m
//  SoccerClub
//
//  Created by xalo on 16/1/21.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "photoTableViewCell.h"

@implementation photoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (UIImageView *)myImageView{
    if (!_myImageView) {
        _myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.frame)-10, CGRectGetHeight(self.frame)-32-15)];
        [self addSubview:_myImageView];
    }
    _myImageView.frame = CGRectMake(5, 5, CGRectGetWidth(self.frame)-10, CGRectGetHeight(self.frame)-32-15);
    return _myImageView;
}
-(UILabel *)myLabel{
    if (!_myLabel) {
        _myLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetHeight(self.frame)-5-32, CGRectGetWidth(self.frame)-10, 32)];
        [self addSubview:_myLabel];
    }
    _myLabel.frame = CGRectMake(5, CGRectGetHeight(self.frame)-5-32, CGRectGetWidth(self.frame)-10, 32);
    return _myLabel;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
