//
//  FirstTableViewCell.m
//  SoccerClub
//
//  Created by xalo on 16/1/11.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell

-(UIImageView *)imageView0{
    if (!_imageView0) {
        _imageView0 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.frame)/4*1, CGRectGetHeight(self.frame)-10)];
        // 照片交互
        _imageView0.userInteractionEnabled = YES;
        [self addSubview:_imageView0];
    }
    return _imageView0;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame)/4*1)+5+10, 5, (CGRectGetWidth(self.frame)/4*3)-20, 25)];
        _titleLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)fuTitleLabel{
    if (!_fuTitleLabel) {
        _fuTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame)/4*1)+5+10, 23,(CGRectGetWidth(self.frame)/4*3)-20, 50)];
        _fuTitleLabel.numberOfLines = 0;
        
        _fuTitleLabel.font = [UIFont systemFontOfSize:13];
//        _fuTitleLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
        [self addSubview:_fuTitleLabel];
        
    }
    return _fuTitleLabel;
}
//右下角btn
-(UIView *)xiaView{
    if (!_xiaView) {
        _xiaView = [[UIView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.frame)-30), 53, 23, 13)];
        _xiaView.backgroundColor = [UIColor redColor];
        [self addSubview:_xiaView];
    }
    return _xiaView;
}

-(UILabel *)xiaLabel{
    if (!_xiaLabel) {
        _xiaLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 23, 13)];
        _xiaLabel.font = [UIFont systemFontOfSize:10];
        _xiaLabel.textAlignment = NSTextAlignmentCenter;
        _xiaLabel.textColor = [UIColor whiteColor];
        [self.xiaView addSubview:_xiaLabel];
    }
    return _xiaLabel;
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
