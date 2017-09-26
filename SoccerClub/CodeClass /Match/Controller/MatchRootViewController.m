//
//  MatchRootViewController.m
//  SoccerClub
//
//  Created by xalo on 16/1/11.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "MatchRootViewController.h"
#import "M_firstTableViewController.h"
#import "M_firstTableViewCell.h"
#import "M_secondTableViewController.h"
#import "M_thiredTableViewController.h"
#import "M_fourthTableViewController.h"
#import "CustomSegmentControl.h"

@interface MatchRootViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) M_firstTableViewController *importantTableView;// 第一个界面
@property (nonatomic,retain)M_secondTableViewController * secondTableView;

@property (nonatomic,retain)M_thiredTableViewController * thiredTableView;

@property (nonatomic,retain)M_fourthTableViewController * fourthTableView;

@property (nonatomic,retain)CustomSegmentControl *custom;

@property (nonatomic,retain)UIScrollView * bottomScrollView;

@end
@implementation MatchRootViewController
{
    NSArray *array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"比赛";

    
    
    //  添加scrollView
    _bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64+30,[UIScreen mainScreen].bounds.size.width ,[UIScreen mainScreen].bounds.size.height-64-30-49)];
        self.automaticallyAdjustsScrollViewInsets = NO;
    _bottomScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame)*4, CGRectGetHeight(self.view.frame)-64-30-49);
    _bottomScrollView.pagingEnabled = YES;
    _bottomScrollView.showsHorizontalScrollIndicator = NO;
    _bottomScrollView.bounces = NO;
    [_bottomScrollView setContentOffset:CGPointMake(0, 0)];



    //  添加代理方法
    _bottomScrollView.delegate = self;
    [self.view addSubview:_bottomScrollView];



    //  添加第一个tableView
     _importantTableView = [[M_firstTableViewController alloc] initWithStyle:(UITableViewStylePlain)];

     _importantTableView.view.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width ,[UIScreen mainScreen].bounds.size.height-64-30-49);
    [self addChildViewController:_importantTableView];
    [_bottomScrollView addSubview: _importantTableView.view];


    //  添加第二个tableView
    _secondTableView = [[M_secondTableViewController alloc] initWithStyle:UITableViewStylePlain];
    _secondTableView.view.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds), 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-30-49);

    [self addChildViewController:_secondTableView];
    [_bottomScrollView addSubview:_secondTableView.view];

    //  添加第三个tableView
    _thiredTableView = [[M_thiredTableViewController alloc] initWithStyle:UITableViewStylePlain];
    _thiredTableView.view.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*2, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-30-49);

    [self addChildViewController:_thiredTableView];
    [_bottomScrollView addSubview:_thiredTableView.view];


    //  添加第四个tableView
    _fourthTableView = [[M_fourthTableViewController alloc]initWithStyle:UITableViewStylePlain];
    _fourthTableView.view.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*3, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-30-49);

    [self addChildViewController:_fourthTableView];
    [_bottomScrollView addSubview:_fourthTableView.view];

    array = [NSArray array];
    array = @[@"重要",@"未结",@"已结",@"数据"];

    _custom = [[CustomSegmentControl alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 30)];

    [_custom drawItemWithArr:array];
    [self.view addSubview:_custom];


    // 添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notic:) name:@"btnAction" object:nil];

    int page = _bottomScrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
    [_custom animationWithIndex:page];
    
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)searchAction{
    if ([TestNet isConnectionAvailable]) {
        SearchViewController *searchViewController = [[SearchViewController alloc]init];
        [self.navigationController presentViewController:searchViewController animated:YES completion:^{
        }];
    };
}

//  scrollView的代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int wid = _bottomScrollView.contentOffset.x / self.view.frame.size.width;
    [_custom animationWithIndex:wid];
    
}


//  监听的实现方法
-(void)notic:(id)sender{
    
    NSNotification *notice = sender;
    NSString * str = notice.object;
    for (int i = 0; i < array.count; i++) {
        if ([array[i] isEqualToString:str]) {
            
            [_bottomScrollView setContentOffset:CGPointMake(i*CGRectGetWidth(self.view.frame), 0) animated:YES];
        }
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
