//
//  CustomSegmentControl.m
//  SoccerClub
//
//  Created by xalo on 16/1/11.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "CustomSegmentControl.h"

@interface CustomSegmentControl ()

@property (nonatomic,retain)UIButton *itemBtn;
@property (nonatomic,retain)UIView *bottomView;

@end
/*
 
 
 当点击btn时，需要使用监听让外界知道我点击了btn
 
 */

@implementation CustomSegmentControl

//- (instancetype)initWithFrame:(CGRect)frame{
//    self = [super init];
//    if (self) {
//        
//    }
//}

- (UIButton *)itemBtn{
    if (!_itemBtn) {
        _itemBtn = [[UIButton alloc]init];
        [self addSubview:_itemBtn];
    }
    return _itemBtn;
}


- (void)drawItemWithArr:(NSArray *)arr{
    // 一共几个item
    int j = (int)arr.count;
    // 一个item的宽度
    CGFloat itemWidth = (CGRectGetWidth(self.frame)-20)/j;
    // 添加item
    for (int i = 0; i<j; i++) {
        self.itemBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.backgroundColor = [UIColor whiteColor];
        [_itemBtn setFrame:CGRectMake(10+i*itemWidth, 0, itemWidth, 25)];
//        _itemBtn.textAlignment = NSTextAlignmentCenter;
        [_itemBtn setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        _itemBtn.tag = 1000+i;
        [_itemBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
//        [_itemBtn setTintColor:[UIColor redColor]];
        [self addSubview:_itemBtn];
    }
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(10, 25, itemWidth, 5)];
    _bottomView.backgroundColor = [UIColor blueColor];
    [self addSubview:_bottomView];
//    NSLog(@"%@",self.subviews);
}

- (void)action:(UIButton *)sender{
    int i = (sender.frame.origin.x)/sender.frame.size.width;
    [self animationWithIndex:i];
//    NSString *str = [NSString stringWithFormat:@"%d",i];
    
    UIButton *btn = (UIButton *)sender;
//    NSLog(@"%@",btn.titleLabel.text);
    // 发送通知
    NSNotification *notice = [NSNotification notificationWithName:@"btnAction" object:btn.titleLabel.text];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"btnAction" object:str];
    
    
}
- (NSInteger)animationWithIndex:(NSInteger)index{
    // 恢复其他按钮上的颜色
    for (UIButton *btn in self.subviews) {
//        NSLog(@"%f",btn.frame.origin.x-10);
//        NSLog(@"%f",_itemBtn.bounds.size.width);
//        NSLog(@"%d",abs((btn.frame.origin.x)/_itemBtn.bounds.size.width));
        if (abs((btn.frame.origin.x)/_itemBtn.bounds.size.width) == index) {
            btn.tintColor = [UIColor blueColor];
        }else{
            btn.tintColor = [UIColor grayColor];
        }
    }
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:_bottomView];
    _bottomView.frame = CGRectMake(index*self.itemBtn.frame.size.width+10, 25, _itemBtn.bounds.size.width, 5);
    [UIView commitAnimations];
    return index;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
