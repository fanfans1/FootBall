//
//  M_fourthTableViewCell.m
//  SoccerClub
//
//  Created by GCCC on 16/1/13.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "M_fourthTableViewCell.h"

@implementation M_fourthTableViewCell


-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 40)];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
    
}


-(UILabel *)descLabel{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 300, 40)];
        [self.contentView addSubview:_descLabel];
    }
    return _descLabel;
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
