
//
//  First_0TableViewController.m
//  SoccerClub
//
//  Created by xalo on 16/1/21.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "First_0TableViewController.h"
#import "FirstTableViewCell.h"
#import "Model.h"
#import "Model1.h"
#import "Model2.h"
//#import "UIImageView+WebCache.h"  // 照片第三方
#import "KongViewController.h"   // 没有btn的页面
//#import "MJRefresh.h"  // 下拉刷新
#import "M2_thiredViewController.h"
#import "M2_firstViewController.h"
#import "RealizeFirst_4ViewController.h"

@interface First_0TableViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,retain) NSDictionary *dataDic;
@property (nonatomic,retain) NSDictionary *ModelDic;
@property (nonatomic,retain) NSMutableArray *mutableArr;
@property (nonatomic,retain) NSMutableArray *mutableArr1;
@property (nonatomic,retain) NSMutableArray *mutableArr2;
//@property (nonatomic,retain) UITableView *tableView;

@property (nonatomic,retain) NSData *data;   // 更新数据用
@property (nonatomic,retain) NSTimer *myTimer;
@property (nonatomic,retain) UIScrollView *scrollView;

@property (nonatomic,retain) UIView *touView; //     添加头视图

@end

@implementation First_0TableViewController
// 下拉刷新 上拉加载
-(void)renovateAndEvenMany{
    // 1、使用系统默认的刷新提示
    __block First_0TableViewController *vc = self;
    
    // 添加下拉刷新
    [self.tableView addHeaderWithCallback:^{
        [TestNet isConnectionAvailable];   // 判断网络
        NSString *stringUrl = @"http://zhiboba.3b2o.com//recommend/listJson/limit/20/category/soccer?1452062165";
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSURL *url = [NSURL URLWithString:stringUrl];
            _data = [NSData dataWithContentsOfURL:url];
            if (vc.data) {
                [CacheHelper writeCacheWithData:vc.data name:@"First_0ViewController"];  // 缓存
                [vc jiexi];
            }
            
            // 当请求到图片的时候，回主线程为cell添加照片
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // 数据重载
                [vc.tableView reloadData];
                
            });
        });
        // 结束刷新
        [vc.tableView headerEndRefreshing];
//        NSLog(@"结束刷新");
    }];
    
    // 添加上拉加载
    [self.tableView addFooterWithCallback:^{
        [TestNet isConnectionAvailable];
        // 判断网络
        Model *model = [vc.mutableArr lastObject];
        NSString *stringUrl = [NSString stringWithFormat:@"http://zhiboba.3b2o.com//recommend/listJson/start/%@/limit/20/category/soccer?1452915091",model.next];
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSURL *url = [NSURL URLWithString:stringUrl];
            _data = [NSData dataWithContentsOfURL:url];
            if (vc.data) {
                NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:vc.data options:NSJSONReadingAllowFragments error:nil];
                for (NSDictionary *item in [receiveDic objectForKey:@"items"]) {
                    Model *model = [[Model alloc] initWithDic:item];
                    [vc.mutableArr addObject:model];
                }
            }
            
            // 当请求到图片的时候，回主线程为cell添加照片
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // 数据重载
                [vc.tableView reloadData];
            });
        });
        
        // 结束刷新
        [vc.tableView footerEndRefreshing];
//        NSLog(@"结束刷新");
    }];
    
}

-(void)jiexi{
    NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
    _mutableArr = [NSMutableArray array];
    for (NSDictionary *item in [receiveDic objectForKey:@"items"]) {
        Model *model = [[Model alloc] initWithDic:item];
        //        NSLog(@"model1 -- %@",model);
        [_mutableArr addObject:model];
    }
    self.dataDic = receiveDic;
    
    _mutableArr1 = [NSMutableArray array];
    for (NSDictionary *item in [receiveDic objectForKey:@"recommends"]) {
        Model1 *model1 = [[Model1 alloc] initWithDic:item];
        //        NSLog(@"model2 -- %@",model1);
        [_mutableArr1 addObject:model1];
    }
    
    _mutableArr2 = [NSMutableArray array];
    for (NSDictionary *item in [receiveDic objectForKey:@"programs"]) {
        Model2 *model2 = [[Model2 alloc] initWithDic:item];
        [_mutableArr2 addObject:model2];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    // 添加控制器
    UINavigationController *navC = [[UINavigationController alloc] init];
    [self addChildViewController:navC];
    
    // 解析
    NSString *stringUrl = @"http://zhiboba.3b2o.com//recommend/listJson/limit/20/category/soccer?1452062165";
    NSURL *url = [NSURL URLWithString:stringUrl];
        _data = [NSData dataWithContentsOfURL:url];
            if (self.data) {
                [CacheHelper writeCacheWithData:self.data name:@"First_0ViewController"];
                [self jiexi];
            }else{
                _data = [CacheHelper readCacheWithName:@"First_0ViewController"];  // 如果没有网络从缓存中读取
                [self jiexi];
            }
  
//        NSLog(@"%@",NSHomeDirectory());
    
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.rowHeight = 70;
//    self.tableView.tag = 1000;
    
    // 创建单元格
    [self.tableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"CELL"];
    
//    [self.view addSubview:_tableView];
    
    // 添加UIScrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/4*1)];
//    _scrollView.backgroundColor = [UIColor redColor];
    // 设置滚动区域
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame)*4,CGRectGetHeight(_scrollView.frame));
    _scrollView.tag = 2000;
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    [_scrollView setContentOffset:CGPointMake(0, 0)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(imageViewAction) userInfo:nil repeats:YES];
   
//    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(imageViewAction) userInfo:nil repeats:YES];
    
        //     添加头视图
        _touView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), (CGRectGetHeight(self.view.frame)/4)+10)];
        //        view.backgroundColor = [UIColor redColor];
        // 关键一步；怎样让UITableView的表头随着tableView一起滚动？ // http://zhidao.baidu.com/link?url=9hrJAP0zn_WNkpGWYnUNcWG2Uo3vZPTmVoBTsvsEhwibx6blHYXQt4qPrxyKclcdbDgLY9VwvWGu7x4Hs-WtiMu5vISExCpOnsEWn2XnMlK
        self.tableView.tableHeaderView = _touView;
        // 添加到View上
        [_touView addSubview:_scrollView];
    
    
//        for (int i = 0; i < _mutableArr2.count; i++) {
//            Model2 *model2 = [_mutableArr2 objectAtIndex:i];
//            // 创建俩view
//            UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(((CGRectGetWidth(self.view.frame)/2*1+5))*i+5, CGRectGetHeight(_scrollView.frame)+10, (CGRectGetWidth(self.view.frame)/2*1)-15, CGRectGetHeight(_scrollView.frame)/2*1)];
//            view1.tag = 9000+i;
////            view1.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
//            view1.backgroundColor = [UIColor colorWithRed:95/255.0 green:158/255.0 blue:160/255.0 alpha:1.0];
//            [_touView addSubview:view1];
//            // 联赛名；
//            UILabel *viewLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 55, 20)];
//            viewLabel1.text = model2.leagueDesc;
//            viewLabel1.font = [UIFont systemFontOfSize:13];
//            [view1 addSubview:viewLabel1];
//            // 比赛进程
//            UILabel *viewLabel2 = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(view1.frame)/7*4)-15, 7, 70, 20)];
//            viewLabel2.text = model2.timeName;
//            viewLabel2.textAlignment = NSTextAlignmentRight;
//            viewLabel2.font = [UIFont systemFontOfSize:13];
//            [view1 addSubview:viewLabel2];
//            // 线 label
//            UIView *xianView = [[UIView alloc]  initWithFrame:CGRectMake(13, 27, CGRectGetWidth(view1.frame)-40, 1)];
//
//            xianView.backgroundColor = [UIColor whiteColor];
//            [view1 addSubview:xianView];
//            // 主场 标志
//            UIImageView *zhuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (CGRectGetHeight(view1.frame)/7*3)+1, 15, 15)];
//            [zhuImageView sd_setImageWithURL:[NSURL URLWithString:[model2.guestInfo valueForKey:@"logo"]]placeholderImage:[UIImage imageNamed:@"logoPlace.jpg"]];
//
//            [view1 addSubview:zhuImageView];
//            // 客场 标志
//            UIImageView *keImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (CGRectGetHeight(view1.frame)/7*5)+1, 15, 15)];
//            [keImageView sd_setImageWithURL:[NSURL URLWithString:[model2.homeInfo valueForKey:@"logo"]]placeholderImage:[UIImage imageNamed:@"logoPlace.jpg"]];
//            [view1 addSubview:keImageView];
//            // 主 队名
//            UILabel *zhumLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, (CGRectGetHeight(view1.frame)/7*2)+4, 100, 30)];
//            zhumLabel.text = [model2.guestInfo valueForKey:@"name"];
//            zhumLabel.font = [UIFont systemFontOfSize:13];
//            [view1 addSubview:zhumLabel];
//            // 客 队名
//            UILabel *kemLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, (CGRectGetHeight(view1.frame)/7*4)+4, 100, 30)];
//            kemLabel.text = [model2.homeInfo valueForKey:@"name"];
//            kemLabel.font = [UIFont systemFontOfSize:13];
//            [view1 addSubview:kemLabel];
//            // 主 进球数
//            UILabel *zhuLabel = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(view1.frame)/7*6), (CGRectGetHeight(view1.frame)/7*3)-1, 20, 20)];
//            zhuLabel.text = [model2.guestInfo valueForKey:@"score"];
//            [view1 addSubview:zhuLabel];
//            // 客 进球数
//            UILabel *keLabel = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(view1.frame)/7*6), (CGRectGetHeight(view1.frame)/7*5)-1, 20, 20)];
//            keLabel.text = [model2.homeInfo valueForKey:@"score"];
//            [view1 addSubview:keLabel];
//
//            // 创建手势
//            UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction2:)];
//            [tapGR setNumberOfTouchesRequired:1];   // 触控对象的最小数量
//            [tapGR setNumberOfTapsRequired:1];   // 设置轻拍次数
//            [view1 addGestureRecognizer:tapGR];
//        }
    
        // 给scrollView 上添加透明的view承接UIPageControl（页面进度条）
        UIView *scView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_scrollView.frame)-30, CGRectGetWidth(self.view.frame), 30)];
        //        scView.backgroundColor = [UIColor redColor];
        scView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        //scrollView下的View
        [_touView  addSubview:scView];
    
    
        //添加子视图
        for (int i = 0; i < 4; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)*i, 0, CGRectGetWidth(self.view.frame),CGRectGetHeight(_scrollView.frame))];
            Model1 *model1 = [_mutableArr1 objectAtIndex:i];
            [imageView setUserInteractionEnabled:YES];
            imageView.tag = 1000+i;
            
                NSURL *url = [NSURL URLWithString:model1.thumb];
                [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Placegolder.png"]];
            

            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetHeight(_scrollView.frame)-30, CGRectGetWidth(self.view.frame)-70, 30)];
            label.text = model1.scTitle;
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:13];
            //  NSLog(@"label--%@",label.text);
            [imageView addSubview:label];
            [_scrollView addSubview:imageView];
            // 创建手势
            UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [tapGR setNumberOfTouchesRequired:1];   // 触控对象的最小数量
            [tapGR setNumberOfTapsRequired:1];   // 设置轻拍次数
            [imageView addGestureRecognizer:tapGR];
        }
        
        
        // 添加UIPageControl （页面进度条）
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/4*3, 0, 100, 30)];
        pageControl.tag = 3000;
        //改变被选中的颜色
        pageControl.pageIndicatorTintColor = [UIColor orangeColor];
        // 设置页面
        pageControl.numberOfPages = 4;
        //设置当前页面
        pageControl.currentPage = 0;
        // 添加触发事件
        //    [pageControl addTarget:self action:@selector(pageActiton:) forControlEvents:UIControlEventValueChanged];
        [scView addSubview:pageControl];
        
    
    
    
    // 上下拉取
    [self renovateAndEvenMany];

}


// 定时器实现方法
-(void)imageViewAction{
    UIScrollView *scrollView = [self.view viewWithTag:2000];
    CGPoint offSet = scrollView.contentOffset;
    if (offSet.x < CGRectGetWidth(self.view.bounds)*3) {
        offSet.x += self.view.bounds.size.width;
        // 改变UIPageControl
        UIPageControl *pageControl = [self.view viewWithTag:3000];
        // 根据当前是第几页来改变pageControl
        int pageNum = offSet.x/self.view.bounds.size.width;
        pageControl.currentPage = pageNum;
        [scrollView setContentOffset:offSet animated:YES];
    }else{
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        // 改变UIPageControl
        UIPageControl *pageControl = [self.view viewWithTag:3000];
        // 得到pageControl
        pageControl.currentPage = 0;
    }

}




// 手势实现scrollView.
-(void)tapAction:(UITapGestureRecognizer *)sender{
    if ([TestNet isConnectionAvailable]) {
        
    

    UIImageView *imageView = (UIImageView *)sender.view;
    Model1 *model1 = [_mutableArr1 objectAtIndex:imageView.tag-1000];
    if ([model1.type isEqualToString:@"match"]) {
        M2_thiredViewController *m2_thired = [[M2_thiredViewController alloc] init];
        m2_thired.sid = [[model1.touchEvent objectForKey:@"detail"] objectForKey:@"sid"];
//        [self.navigationController pushViewController:m2_thired animated:YES];
        [self presentViewController:m2_thired animated:YES completion:nil];
    }else if ([model1.type isEqualToString:@"image"]){
        RealizeFirst_4ViewController *kongVC = [[RealizeFirst_4ViewController alloc] init];
        kongVC.str = [[model1.touchEvent objectForKey:@"detail"] objectForKey:@"sid"];
//        NSLog(@"%@",kongVC.str);
        [self presentViewController:kongVC animated:YES completion:nil];  // 模态
    }else{
        KongViewController *kongVC = [[KongViewController alloc] init];
        NSString *str = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/article/showForMobile/%@",[[model1.touchEvent objectForKey:@"detail"] objectForKey:@"sid"]];
        kongVC.str = str;
//        NSLog(@"%@",kongVC.str);
        [self presentViewController:kongVC animated:YES completion:nil];  // 模态
     }
    }
}

// 手势实现俩view.
-(void)tapAction2:(UITapGestureRecognizer *)sender{
    if ([TestNet isConnectionAvailable]) {
        
    UIImageView *imageView = (UIImageView *)sender.view;
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            Model2 *model2 = [_mutableArr2 objectAtIndex:imageView.tag-9000];
            M2_thiredViewController *m2_thired = [[M2_thiredViewController alloc] init];
            m2_thired.sid = model2.sid;
            
            // 当请求到图片的时候，回主线程为cell添加照片
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //    [self.navigationController pushViewController:m2_thired animated:YES];
                [self presentViewController:m2_thired animated:YES completion:nil];
            });
        });
    }
}

#pragma mark -- scrollView 代理方法
// 开始拖拽 （手指触碰屏幕，并且移动）
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}
// 已经开始滚动 （只要是scrollView是滚动状态就会调用此方法）
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}
// 停止拖动，当手指离开，正在滚动的视图减速
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}
//视图真正静止
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 根据scrollView的偏移量来计算当前的页数
    int page = (int)scrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
    // 得到pageCroll
    UIPageControl *pageControl = [self.view viewWithTag:3000];
    [pageControl setCurrentPage:page];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _mutableArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    Model *model = [_mutableArr objectAtIndex:indexPath.item];
    NSString *str0 = @"http://in.3b2o.com/img/show/sid/";
    NSString *str1 = model.imgSid;
    NSString *str2 = @"/w/240/h/160/t/1/show.jpg";
    NSString *str = [NSString stringWithFormat:@"%@%@%@",str0,str1,str2];
    
//  废弃
    // 将请求放入子线程中
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]];

        // 当请求到图片的时候，回主线程为cell添加照片
        dispatch_async(dispatch_get_main_queue(), ^{

            cell.imageView0.image = image;

        });
    });

    
    
    cell.titleLabel.text = model.title;
    cell.fuTitleLabel.text = model.digest;
    if ([model.button isEqual: @"专题"] || [model.button isEqual: @"深度"]||[model.button isEqual: @"直播"]) {
        cell.xiaLabel.text = model.button;
        cell.xiaView.backgroundColor = [UIColor blueColor];
    }else if ([model.button isEqual: @"图集"] || [model.button isEqual: @"视频"]||[model.button isEqual: @"比赛"]){
        cell.xiaLabel.text = model.button;
        cell.xiaView.backgroundColor = [UIColor redColor];
    }else if ([model.button  isEqual: @"推广"] || [model.button  isEqual: @"推荐"]){
        cell.xiaLabel.text = model.button;
        cell.xiaView.backgroundColor = [UIColor greenColor];
    }else{
        cell.xiaLabel.text = nil;
        cell.xiaView.backgroundColor = [UIColor whiteColor];
    }
    
    
    return cell;
}

// 点击cell 的代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([TestNet isConnectionAvailable]) {
        
    Model *model = [_mutableArr objectAtIndex:indexPath.item];
    if ([model.button isEqual: @"比赛"]) {
        // 调用组员写的。
        M2_thiredViewController *m2_thired = [[M2_thiredViewController alloc] init];
        m2_thired.sid = [model.target objectForKey:@"sid"];
        //        NSString *str = [NSString stringWithFormat:@"http://www.zhiboba.com/article/show/%@",m2_thired.sid];
        //        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
        if ([[model.target objectForKey:@"source"] isEqualToString:@"article"]) {
            KongViewController *kongVC = [[KongViewController alloc] init];
            kongVC.str = [model.web objectForKey:@"url"];
              [self.navigationController pushViewController:kongVC animated:YES];
//            [self presentViewController:kongVC animated:YES completion:nil];  // 模态
        }else{
            
                    [self.navigationController pushViewController:m2_thired animated:YES];
//            [self presentViewController:m2_thired animated:YES completion:nil];
        }
        
    }else if ([model.button isEqual: @"视频"]){
        KongViewController *kongVC = [[KongViewController alloc] init];
        NSString *sid = [model.target objectForKey:@"sid"];
//        NSLog(@"%@",sid);
        NSString *videoPath = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/v/infoJson/%@?1453290284",sid];
        
        // 将请求放入子线程中
        //        dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:videoPath]];
        if (data) {
            NSDictionary *videoDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSDictionary *videoPathDic = [videoDic objectForKey:@"defaultPlayer"];
            kongVC.str = [videoPathDic objectForKey:@"url"];
            [self.navigationController pushViewController:kongVC animated:YES];
//            [self presentViewController:kongVC animated:YES completion:nil];
        }else{
            M2_thiredViewController *m2_thired = [[M2_thiredViewController alloc] init];
            m2_thired.sid = sid;
//            [self.navigationController pushViewController:m2_thired animated:YES];
            [self presentViewController:m2_thired animated:YES completion:nil];
        }
        
    }else if ([model.button isEqual: @"直播"]){
        M2_firstViewController *m2_first = [[M2_firstViewController alloc] init];
        m2_first.sid = [model.target objectForKey:@"sid"];
        [self.navigationController pushViewController:m2_first animated:YES];
        //        [self presentViewController:m2_first animated:YES completion:nil];
    }else if ([model.button isEqual: @"图集"]){
        RealizeFirst_4ViewController *kongVC = [[RealizeFirst_4ViewController alloc] init];
        kongVC.str = [model.target objectForKey:@"sid"];
        //        NSLog(@"%@",kongVC.str);
//        [self presentViewController:kongVC animated:YES completion:nil];  // 模态
        [self.navigationController pushViewController:kongVC animated:YES];
    }else{
        KongViewController *kongVC = [[KongViewController alloc] init];
        NSString *str = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/article/showForMobile/%@",[model.target objectForKey:@"sid"]];
        kongVC.str = str;
//        NSLog(@"%@",kongVC.str);
//        [self presentViewController:kongVC animated:YES completion:nil];  // 模态
                [self.navigationController pushViewController:kongVC animated:YES];
    }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80*SCREEN_WIDTH/414;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
