//
//  VideoRootViewController.m
//  SoccerClub
//
//  Created by xalo on 16/1/11.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "VideoRootViewController.h"
#import "VideoSiftTableViewController.h"
#import "VideoCollectionTableViewController.h"
#import "VideoHotTableViewController.h"
#import "VideotapeTableViewController.h"

@interface VideoRootViewController ()<UIScrollViewDelegate>
@property (nonatomic,retain)UIScrollView *myScrollView;

@property (nonatomic,retain)CustomSegmentControl *customSegmentControl;

@property (nonatomic,retain)VideoSiftTableViewController *videoSiftTableViewController;
@property (nonatomic,retain)VideoCollectionTableViewController *videoCollectionTableViewController;
@property (nonatomic,retain)VideoHotTableViewController *videoHotTableViewController;
@property (nonatomic,retain)VideotapeTableViewController *videotapeTableViewController;

@end

@implementation VideoRootViewController
{
    NSArray *arr;
}
- (void)searchAction{
    if ([TestNet isConnectionAvailable]) {
        SearchViewController *searchViewController = [[SearchViewController alloc]init];
        [self.navigationController presentViewController:searchViewController animated:YES completion:^{
        }];
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *search = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchAction)];
    self.navigationItem.rightBarButtonItem = search;
    
    
    self.navigationItem.title = @"视频";
    
    _customSegmentControl = [[CustomSegmentControl alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 30)];
//    [_customSegmentControl setFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
    arr = @[@"精选",@"集锦",@"热榜",@"录像"];
    [self.view addSubview:_customSegmentControl];
    [_customSegmentControl drawItemWithArr:arr];
    
//    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"精选",@"集锦",@"热榜",@"录像"]];
//    [segmentedControl  setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
//    segmentedControl
//    self.view
    
    _myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 94, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-104-49)];
    _myScrollView.pagingEnabled = YES;
    _myScrollView.delegate = self;
    _myScrollView.showsHorizontalScrollIndicator = NO;
    _myScrollView.bounces = NO;
//    _myScrollView.backgroundColor = [UIColor greenColor];
//    _myScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame)*4, CGRectGetHeight(self.view.frame)-149);
    _myScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame)*4, 0);
    [_myScrollView setContentOffset:CGPointMake(0, 0)];
    
    
    
    
    UIView *videoSiftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-149-49)];
    _videoSiftTableViewController = [[VideoSiftTableViewController alloc]init];
    [self addChildViewController:_videoSiftTableViewController];
    _videoSiftTableViewController.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.myScrollView.frame));
    videoSiftView = _videoSiftTableViewController.view;
//    videoSiftView.backgroundColor = [UIColor redColor];
    [_myScrollView addSubview:videoSiftView];
    
    
    
    
//    self.navigationController.navigationBar.hidden = YES;
    UIView *videoCollectionView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame), 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-149-49)];
    _videoCollectionTableViewController = [[VideoCollectionTableViewController alloc]init];
    
//    UINavigationController *secondNavC = [[UINavigationController alloc]initWithRootViewController:_videoCollectionTableViewController];
    
    _videoCollectionTableViewController.view.frame = CGRectMake(CGRectGetWidth(self.view.frame), 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.myScrollView.frame));
    videoCollectionView = _videoCollectionTableViewController.view;
    [self addChildViewController:_videoCollectionTableViewController];
//    [self addChildViewController:secondNavC];

//    videoCollectionView.backgroundColor = [UIColor blueColor];
    [_myScrollView addSubview:videoCollectionView];
    
    
    
    
    
    UIView *videoHotView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)*2, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
//    videoHotView.backgroundColor = [UIColor blackColor];
    _videoHotTableViewController = [[VideoHotTableViewController alloc]init];
    _videoHotTableViewController.view.frame = CGRectMake(CGRectGetWidth(self.view.frame)*2, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.myScrollView.frame));
    videoHotView = _videoHotTableViewController.view;
    [self addChildViewController:_videoHotTableViewController];
    [_myScrollView addSubview:videoHotView];
    
    
    
    
    UIView *videotapeView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)*3, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
//    videotapeView.backgroundColor = [UIColor yellowColor];
    _videotapeTableViewController = [[VideotapeTableViewController alloc]init];
    _videotapeTableViewController.view.frame = CGRectMake(CGRectGetWidth(self.view.frame)*3, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.myScrollView.frame));
    videotapeView = _videotapeTableViewController.view;
    [self addChildViewController:_videotapeTableViewController];
    [_myScrollView addSubview:videotapeView];
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notice:) name:@"btnAction" object:nil];
    
    
    
//    VideoSiftTableViewController *videoTableView = [[VideoSiftTableViewController alloc]init];
    
    
    
    // Do any additional setup after loading the view.
    
    
    [self.view addSubview:_myScrollView];
    
    int page = _myScrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
    [_customSegmentControl animationWithIndex:page];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    int page = _myScrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
    [_customSegmentControl animationWithIndex:page];
}

- (void)notice:(id)sender{
    NSNotification *notice = sender;
    NSString * str = notice.object;
    for (int i = 0; i < arr.count; i++) {
        if ([arr[i] isEqualToString:str]) {
            
            [_myScrollView setContentOffset:CGPointMake(i*CGRectGetWidth(self.view.frame), 0) animated:YES];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    CustomSegmentControl *customSegmentControl = [[CustomSegmentControl alloc]init];
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
