//
//  RealizeFirst_4ViewController.m
//  SoccerClub
//
//  Created by xalo on 16/1/15.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "RealizeFirst_4ViewController.h"
//#import "UIImageView+WebCache.h"
@interface RealizeFirst_4ViewController ()<UIScrollViewDelegate>
@property (nonatomic,retain) NSDictionary *receiveDic;

@property (nonatomic,retain)UIView *headerView;
@property (nonatomic,retain)UIView *bottomView;

@end

@implementation RealizeFirst_4ViewController
{
    UIImageView *imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 拼接
    NSString *string = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/photoShow/listjson/sid/%@",self.str];
    NSURL *url = [NSURL URLWithString:string];
    NSData *data = [NSData dataWithContentsOfURL:url];
    if (data) {
        
        _receiveDic = [NSDictionary dictionary];
        _receiveDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64)];
    _headerView.backgroundColor = [UIColor blackColor];
    _headerView.alpha = 0.7;
    
    
        self.view.backgroundColor = [UIColor blackColor];
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.0];
    
//    view.backgroundColor = [UIColor blackColor];
    //    view.alpha = 0.7;
    [self.view addSubview:view];
    
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeSystem];
    Btn.frame = CGRectMake(5, 20, 50, 50);
    Btn.titleLabel.font = [UIFont systemFontOfSize:17];
    Btn.tintColor = [UIColor whiteColor];
    [Btn setTitle:@"返回" forState:UIControlStateNormal];
    
    [Btn addTarget:self action:@selector(leftBtnItem) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:Btn];
    
    // title
    UILabel *label0 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 40)];
    label0.backgroundColor = [UIColor blackColor];
    label0.alpha = 0.7;
    if (data) {
        
        label0.text = [[_receiveDic objectForKey:@"album"] objectForKey:@"albumName"];
        label0.font = [UIFont systemFontOfSize:14];
        label0.textAlignment = NSTextAlignmentCenter;
        label0.textColor = [UIColor whiteColor];
//        [view addSubview:label0];
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        scrollView.pagingEnabled = YES;
        int a;
        if (data) {
            NSArray *arr = [_receiveDic objectForKey:@"imgs"];
            a = (int)arr.count;
//            NSLog(@"a = %d",a);
            scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame)*a, CGRectGetHeight(self.view.frame)/3*1 );
        }
        scrollView.delegate = self;
        [view addSubview:scrollView];
        
        // 第几页的那个label
        UILabel *dqylabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2, 25, 5, 40)];
        dqylabel.textColor = [UIColor whiteColor];
        dqylabel.text = @"/";
        [_headerView addSubview:dqylabel];
        UILabel *dqylabel1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2+10, 25, 23, 40)];
        dqylabel1.textColor = [UIColor whiteColor];
        dqylabel1.text = [NSString stringWithFormat:@"%d",a];
        [_headerView addSubview:dqylabel1];
        UILabel *dqylabel2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2-20, 25, 23, 40)];
        dqylabel2.textColor = [UIColor whiteColor];
        dqylabel2.tag = 1000;
        dqylabel2.text = @"1";
        dqylabel2.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        dqylabel1.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        dqylabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        [_headerView addSubview:dqylabel2];
        
        for (int i = 0; i < a; i++) {
            
            NSArray *arr = [_receiveDic objectForKey:@"imgs"];
            
            // 将请求放入子线程中
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[arr[i] objectForKey:@"url"]]]];
                CGFloat width = CGRectGetWidth(self.view.frame);
                CGSize size = image.size;
                CGFloat height = width * size.height / size.width;
                
                CGFloat y = CGRectGetHeight(scrollView.frame)/2-height/4*3;
                imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)*i, y, CGRectGetWidth(scrollView.frame), height)];
                imageView.image = [UIImage imageNamed:@"Placegolder.png"];
                [scrollView addSubview:imageView];
                if (y<0) {
                    y=0;
                }
                // 当请求到图片的时候，回主线程为cell添加照片
                dispatch_async(dispatch_get_main_queue(), ^{
                    imageView.image = image;
                });
            });
            
            UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)*i, CGRectGetHeight(self.view.frame)/5*4, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/10*1)];
            textView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.0];
            textView.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
            textView.userInteractionEnabled = YES;
            textView.editable = NO;
            textView.text = [[_receiveDic objectForKey:@"imgs"][i] objectForKey:@"description"];
            [scrollView addSubview:textView];
            [self.view addSubview:_headerView];
            [self.view addSubview:_bottomView];
            _bottomView.alpha = 0.5;
        }
    }else{
       
    }
//    self.view.backgroundColor = [UIColor blackColor];
    
}
-(void)leftBtnItem{
        [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popToRootViewControllerAnimated:YES];
}

// 视图结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 计算偏移量
    int b = scrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
    UILabel *label = [self.view viewWithTag:1000];
    label.text = [NSString stringWithFormat:@"%d",b+1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
