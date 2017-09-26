//
//  FirstRootViewController.m
//  SoccerClub
//
//  Created by xalo on 16/1/11.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "FirstRootViewController.h"
//#import "First_0ViewController.h"
#import "First_0TableViewController.h"
#import "First_1TableViewController.h"
#import "First_2TableViewController.h"
#import "First_3TableViewController.h"
#import "First_4TableViewController.h"
@interface FirstRootViewController ()<UIScrollViewDelegate>

@property (nonatomic,retain) UIScrollView *myScrollView;
@property (nonatomic,retain) CustomSegmentControl *customSegmentControl;
//@property (nonatomic,retain) First_0ViewController *first_0ViewController;
@property (nonatomic,retain) First_0TableViewController *first_0TableViewController;
@property (nonatomic,retain) First_1TableViewController *first_1TableViewController;
@property (nonatomic,retain) First_2TableViewController *first_2TableViewController;
@property (nonatomic,retain) First_3TableViewController *first_3TableViewController;
@property (nonatomic,retain) First_4TableViewController *first_4TableViewController;

@end
@implementation FirstRootViewController
{
    NSArray *arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent]; // 改变状态栏字体
//    self.navigationController.view.backgroundColor = [UIColor blueColor];
    
    UIBarButtonItem *search = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchAction)];
    self.navigationItem.rightBarButtonItem = search;
    
    
    _customSegmentControl = [[CustomSegmentControl alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 30)];
    arr = @[@"推荐",@"新闻",@"专栏",@"热榜",@"图集"];
    [self.view addSubview:_customSegmentControl];
    [_customSegmentControl drawItemWithArr:arr];
    
    
    _myScrollView  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 94, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    _myScrollView.pagingEnabled = YES;
    _myScrollView.delegate = self;
    _myScrollView.bounces = NO;
    _myScrollView.showsHorizontalScrollIndicator = NO;
    _myScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame)*5, CGRectGetHeight(self.view.frame)-139);
    
//    for (int i = 0; i < 6; i++) {
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)*i, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
//        view.tag = 1000;
//        [_myScrollView addSubview:view];
//    }
    
    // 推荐页面
    _first_0TableViewController = [[First_0TableViewController alloc] init];
    _first_0TableViewController.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-30-49-64);
//    NSLog(@"%@",NSStringFromCGRect(_first_0TableViewController.view.frame));
    
    [self addChildViewController:_first_0TableViewController];   //跳转子视图需要用。
    [_myScrollView addSubview:_first_0TableViewController.view];
    // 新闻页面
    _first_1TableViewController = [[First_1TableViewController alloc] init];
    _first_1TableViewController.view.frame = CGRectMake(CGRectGetWidth(self.view.frame), 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-94-49);
    [self addChildViewController:_first_1TableViewController];
    [_myScrollView addSubview:_first_1TableViewController.view];
    // 专栏页面
    _first_2TableViewController = [[First_2TableViewController alloc] init];
    _first_2TableViewController.view.frame = CGRectMake(CGRectGetWidth(self.view.frame)*2, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-94-49);
    [self addChildViewController:_first_2TableViewController];
    [_myScrollView addSubview:_first_2TableViewController.view];
    // 热榜页面
    _first_3TableViewController = [[First_3TableViewController alloc] init];
    _first_3TableViewController.view.frame = CGRectMake(CGRectGetWidth(self.view.frame)*3, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-94-49);
    [self addChildViewController:_first_3TableViewController];  // 给父view加导航控制器
    [_myScrollView addSubview:_first_3TableViewController.view];
    // 图集页面
    _first_4TableViewController = [[First_4TableViewController alloc] init];
    _first_4TableViewController.view.frame = CGRectMake(CGRectGetWidth(self.view.frame)*4, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-94-49);
    [self addChildViewController:_first_4TableViewController];
    [_myScrollView addSubview:_first_4TableViewController.view];
//    // 数据页面
//    _first_5TableViewController = [[First_5TableViewController alloc] init];
//    _first_5TableViewController.view.frame = CGRectMake(CGRectGetWidth(self.view.frame)*5, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-94-49);
//    [self addChildViewController:_first_5TableViewController];
//    [_myScrollView addSubview:_first_5TableViewController.view];
    
    
    // 接受通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notice:) name:@"btnAction" object:nil];
    
    [self.view addSubview:_myScrollView];
//    int page = _myScrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
//    [_customSegmentControl animationWithIndex:page];
    
}

- (void)searchAction{
    if ([TestNet isConnectionAvailable]) {
        SearchViewController *searchViewController = [[SearchViewController alloc]init];
        [self.navigationController presentViewController:searchViewController animated:YES completion:^{
            
        }];
    };
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    int page = _myScrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
    [_customSegmentControl animationWithIndex:page];
}

// 接收通知的方法
-(void)notice:(id)sender{
    
    NSNotification *notice = sender;
    NSString * str = notice.object;
    for (int i = 0; i < arr.count; i++) {
        if ([arr[i] isEqualToString:str]) {
            
            [_myScrollView setContentOffset:CGPointMake(i*CGRectGetWidth(self.view.frame), 0) animated:YES];
        }
    }
}

// scrollView静止时回调方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
    [_customSegmentControl animationWithIndex:page];
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
