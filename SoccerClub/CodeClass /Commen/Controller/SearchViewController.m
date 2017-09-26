//
//  SearchViewController.m
//  SoccerClub
//
//  Created by xalo on 16/1/19.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "SearchViewController.h"
#import "FirstTableViewCell.h"
#import "First_1TableViewCell.h"
#import "First_4TableViewCell.h"
#import "CustomWebViewController.h"
#import "RealizeFirst_4ViewController.h"
#import "M2_thiredViewController.h"
#import "Model.h"
#import "KongViewController.h"
#import "M2_firstViewController.h"

@interface SearchViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)NSString *searchText;
@property (nonatomic,retain)UIScrollView *myScrollView;
@property (nonatomic,retain)CustomSegmentControl *customSegmentControl;
@property (nonatomic,retain)NSData *recommendData;
@property (nonatomic,retain)NSData *videoData;
@property (nonatomic,retain)NSData *photoData;
@property (nonatomic,retain)NSData *articleData;

@property (nonatomic,retain)NSArray *loadArray;


@property (nonatomic,retain)NSMutableArray *recommendArray;
@property (nonatomic,retain)NSMutableArray *videoArray;
@property (nonatomic,retain)NSMutableArray *photoArray;
@property (nonatomic,retain)NSMutableArray *articleArray;

@property (nonatomic,retain)UITableView *recommendTableView;
@property (nonatomic,retain)UITableView *videoTableView;
@property (nonatomic,retain)UITableView *photoTableView;
@property (nonatomic,retain)UITableView *articleTableView;


@property (nonatomic,retain)UITableView *myTableView;

@end

@implementation SearchViewController

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadData{
    // 使用系统默认的刷新提示
    __block SearchViewController *vc = self;
    // 添加推荐的下拉刷新
    [self.recommendTableView addHeaderWithCallback:^{
        [TestNet isConnectionAvailable];
        NSString *urlStr = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/recommend/listJson/limit/20/category/%@?1453205177",vc.searchText];
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            _recommendData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
            if (vc.recommendData) {
                [TestNet isConnectionAvailable];
                //            [vc jiexi];
                
                [vc showProgressJuHua];
            }else{
            }
            
            // 当请求到图片的时候，回主线程为cell添加照片
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // 数据重载
                [vc.recommendTableView reloadData];
            });
        });
        // 结束刷新
        [vc.recommendTableView headerEndRefreshing];
    }];
    // 添加推荐的上拉刷新
    [self.recommendTableView addFooterWithCallback:^{
        [TestNet isConnectionAvailable];
        NSDictionary *lastDatedic = [vc.recommendArray lastObject];
        NSString *str = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/recommend/listJson/start/%@/limit/20/category/%@?1453278092",[lastDatedic objectForKey:@"next"],vc.searchText];
        NSURL *urlStr = [NSURL URLWithString:str];
        dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(globalQueue, ^{
            _recommendData = [NSData dataWithContentsOfURL:urlStr];
            if (vc.recommendData) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:vc.recommendData options:NSJSONReadingAllowFragments error:nil];
                _loadArray = [dic objectForKey:@"items"];
                [vc.recommendArray addObjectsFromArray:vc.loadArray];
            }
            // 耗时操作完成之后回主线程更新UI，GCD回主线程的方式
            // 要得到主队列，和operationQueue中的mainQueue是一样的概念
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                // 数据重载
                [vc.recommendTableView reloadData];
            });
            
        });        // 结束刷新
        [vc.recommendTableView footerEndRefreshing];
    }];
    // 添加视频的下拉刷新
    [self.videoTableView addHeaderWithCallback:^{
        [TestNet isConnectionAvailable];
        NSString *urlStr = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/videoTag/listJson/k/%@/limit/10?1453205288",vc.searchText];
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            _videoData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
            if (vc.videoData) {
                //            [vc jiexi];
                
                [vc showProgressJuHua];
            }else{
            }
            
            // 当请求到图片的时候，回主线程为cell添加照片
            dispatch_async(dispatch_get_main_queue(), ^{
                // 数据重载
                [vc.videoTableView reloadData];
                
            });
        });
        // 结束刷新
        [vc.videoTableView headerEndRefreshing];
    }];
    // 添加视频的上拉刷新
    [self.videoTableView addFooterWithCallback:^{
        [TestNet isConnectionAvailable];
        NSString *str = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/videoTag/listJson/k/%@/limit/10/offset/%@?1453279377",vc.searchText,[NSString stringWithFormat:@"%lu",(unsigned long)vc.videoArray.count]];
        NSURL *urlStr = [NSURL URLWithString:str];
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            _videoData = [NSData dataWithContentsOfURL:urlStr];
            if (vc.videoData) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:vc.videoData options:NSJSONReadingAllowFragments error:nil];
                _loadArray = [dic objectForKey:@"videos"];
                [vc.videoArray addObjectsFromArray:vc.loadArray];
            }
            // 当请求到图片的时候，回主线程为cell添加照片
            dispatch_async(dispatch_get_main_queue(), ^{
                // 数据重载
                [vc.videoTableView reloadData];
            });
        });
        // 结束刷新
        [vc.videoTableView footerEndRefreshing];
    }];
    // 添加新闻的下拉刷新
    [self.articleTableView addHeaderWithCallback:^{
        [TestNet isConnectionAvailable];
        NSString *urlStr = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/article/listJson/category/%@?1453205303",vc.searchText];
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            _articleData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
            if (vc.articleData) {
                //            [vc jiexi];
                [vc showProgressJuHua];
            }else{
            }
            
            // 当请求到图片的时候，回主线程为cell添加照片
            dispatch_async(dispatch_get_main_queue(), ^{
                // 数据重载
                [vc.articleTableView reloadData];
                
            });
        });
        // 结束刷新
        [vc.articleTableView headerEndRefreshing];
    }];
    // 添加新闻的上拉刷新
    [self.articleTableView addFooterWithCallback:^{
        [TestNet isConnectionAvailable];
        NSDictionary *lastDic = [vc.articleArray lastObject];
        NSString *str = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/article/listJson/?category=%@&modtime=%@&on=0&1453280340",vc.searchText,[lastDic objectForKey:@"modtime"]];
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSURL *urlStr = [NSURL URLWithString:str];
            _articleData = [NSData dataWithContentsOfURL:urlStr];
            if (vc.articleData) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:vc.articleData options:NSJSONReadingAllowFragments error:nil];
                _loadArray = [dic objectForKey:@"articles"];
                [vc.articleArray addObjectsFromArray:vc.loadArray];
            }
            
            // 当请求到图片的时候，回主线程为cell添加照片
            dispatch_async(dispatch_get_main_queue(), ^{
                // 数据重载
                [vc.articleTableView reloadData];
                
            });
        });
        // 结束刷新
        [vc.articleTableView footerEndRefreshing];
    }];
    // 添加图集的下拉刷新
    [self.photoTableView addHeaderWithCallback:^{
        [TestNet isConnectionAvailable];
        NSString *urlStr = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/article/listJson/category/%@?1453205303",vc.searchText];
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            _photoData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
            if (vc.photoData) {
                //            [vc jiexi];
                [vc showProgressJuHua];
            }else{
            }
            
            // 当请求到图片的时候，回主线程为cell添加照片
            dispatch_async(dispatch_get_main_queue(), ^{
                // 数据重载
                [vc.photoTableView reloadData];
                
            });
        });
        // 结束刷新
        [vc.photoTableView headerEndRefreshing];
    }];
    // 添加图集的上拉刷新
    [self.photoTableView addFooterWithCallback:^{
        [TestNet isConnectionAvailable];
        NSDictionary *lastDic = [vc.photoArray lastObject];
        NSString *str = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/photoIndex/listJson/?category=%@&modtime=%@&on=0&1453280914",vc.searchText,[lastDic objectForKey:@"modtime"]];
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSURL *urlStr = [NSURL URLWithString:str];
            _photoData = [NSData dataWithContentsOfURL:urlStr];
            if (vc.photoData) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:vc.photoData options:NSJSONReadingAllowFragments error:nil];
                _loadArray = [dic objectForKey:@"album"];
                [vc.photoArray addObjectsFromArray:vc.loadArray];
            }
            
            // 当请求到图片的时候，回主线程为cell添加照片
            dispatch_async(dispatch_get_main_queue(), ^{
                // 数据重载
                [vc.photoTableView reloadData];
                
            });
        });
        // 结束刷新
        [vc.photoTableView footerEndRefreshing];
    }];

}
// 菊花状提示
- (void)showProgressJuHua{
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"正在加载";
    HUD.mode = MBProgressHUDModeIndeterminate;
    [HUD showAnimated:YES whileExecutingBlock:^{
        [self jiexi];
    } completionBlock:^{
        [_recommendTableView reloadData];
        [_videoTableView reloadData];
        [_articleTableView reloadData];
        [_photoTableView reloadData];
        [HUD removeFromSuperview];
        HUD = nil;
    }];
    
}
- (void)jiexi{
    NSString *recommendPathStr = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/recommend/listJson/limit/20/category/%@?1453205177",_searchText];
    NSString *videoPathStr = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/videoTag/listJson/k/%@/limit/10?1453205288",_searchText];
    NSString *photoPathStr = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/photoIndex/listJson/category/%@?1453205282",_searchText];
    NSString *articlePathStr = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/article/listJson/category/%@?1453205303",_searchText];
//    dispatch_queue_t queue = dispatch_queue_create("custom", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue, ^{
        // 在子线程中请求解析数据
    _recommendData = [NSData dataWithContentsOfURL:[NSURL URLWithString:recommendPathStr]];
    _videoData = [NSData dataWithContentsOfURL:[NSURL URLWithString:videoPathStr]];
    _articleData = [NSData dataWithContentsOfURL:[NSURL URLWithString:articlePathStr]];
    _photoData = [NSData dataWithContentsOfURL:[NSURL URLWithString:photoPathStr]];
    if ((!_recommendData)||(!_videoData)||(!_articleData)||(!_videoData)) {
        [TestNet isConnectionAvailable];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        NSArray *array1 = [[NSJSONSerialization JSONObjectWithData:_recommendData options:NSJSONReadingAllowFragments error:nil] objectForKey:@"items"];
        _recommendArray = [NSMutableArray arrayWithArray:array1];
        
        NSArray *array3 = [[NSJSONSerialization JSONObjectWithData:_videoData options:NSJSONReadingAllowFragments error:nil] objectForKey:@"videos"];
        _videoArray = [NSMutableArray arrayWithArray:array3];
        NSArray *array2 = [[NSJSONSerialization JSONObjectWithData:_photoData options:NSJSONReadingAllowFragments error:nil] objectForKey:@"album"];;
        _photoArray = [NSMutableArray arrayWithArray:array2];
        
        NSArray *array4 = [[NSJSONSerialization JSONObjectWithData:_articleData options:NSJSONReadingAllowFragments error:nil] objectForKey:@"articles"];
        _articleArray = [NSMutableArray arrayWithArray:array4];
    }
        // 数据解析完成之后就刷新UI
//        dispatch_async(dispatch_get_main_queue(), ^{
            //            [tableView reloadData];
//            [_recommendTableView reloadData];
//            [_videoTableView reloadData];
//            [_articleTableView reloadData];
//            [_photoTableView reloadData];
//        });
//    });
    
}

-(void)edgeGR{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//
    UIScreenEdgePanGestureRecognizer *edgeGR = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgeGR)];
    [self.view addGestureRecognizer:edgeGR];
    
//    UINavigationController *navC = [[UINavigationController alloc]init];
//    [navC addChildViewController:self];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64)];
    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:245/255.0 blue:255/255.0 alpha:1.0];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame = CGRectMake(0, 20, 50, 50);
    [backBtn setImage:[[UIImage imageNamed:@"11.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backBtn];
    [self.view addSubview:view];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 30)];
    textField.delegate = self;
    //    textField.keyboardType = UIKeyboardTypeSearch;
    textField.returnKeyType  = UIReturnKeySearch;
    textField.placeholder = @"🔍";
    //    textField.placeholder
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textField];
    
    
    // 添加手势
    
    //    UITapGestureRecognizer *tapCG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCGAction)];
    //
    //    [self.view addGestureRecognizer:tapCG];
    
    _customSegmentControl = [[CustomSegmentControl alloc]initWithFrame:CGRectMake(0, 94, self.view.frame.size.width, 30)];
    NSArray *arr = @[@"推荐",@"视频",@"新闻",@"图集"];
    [self.view addSubview:_customSegmentControl];
    [_customSegmentControl drawItemWithArr:arr];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notice:) name:@"btnAction" object:nil];
    int page = _myScrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
    [_customSegmentControl animationWithIndex:page];
    
    _myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 124, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-124)];
    _myScrollView.pagingEnabled = YES;
    _myScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame)*4, 0);
    _myScrollView.delegate = self;
    [self.view addSubview:_myScrollView];
    
    
    
    
    
    
    
    _recommendTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-124)];
    _recommendTableView.delegate = self;
    _recommendTableView.dataSource = self;
    _recommendTableView.userInteractionEnabled = YES;
    _recommendTableView.tag = 1000;
    [_recommendTableView registerClass:[FirstTableViewCell class] forCellReuseIdentifier:@"recommendCell"];
    [_myScrollView addSubview:_recommendTableView];
    
    _videoTableView = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame), 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-124)];
    _videoTableView.delegate = self;
    _videoTableView.dataSource = self;
    
    _videoTableView.tag = 1001;
    [_videoTableView registerClass:[VideoSiftTableViewCell class] forCellReuseIdentifier:@"videoCell"];
    [_myScrollView addSubview:_videoTableView];
    
    _articleTableView = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)*2, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-124)];
    _articleTableView.delegate = self;
    _articleTableView.dataSource = self;
    _articleTableView.tag = 1002;
    
    [_myScrollView addSubview:_articleTableView];
    
    
    _photoTableView = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)*3, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-124)];
    _photoTableView.delegate = self;
    _photoTableView.dataSource = self;
    _photoTableView.tag = 1003;
    [_photoTableView registerClass:[photoTableViewCell class] forCellReuseIdentifier:@"CELL"];
    [_myScrollView addSubview:_photoTableView];
    
    
    [self loadData];
    // Do any additional setup after loading the view.
}
- (void)notice:(id)sender{
    NSNotification *notice = sender;
    int i = [notice.object intValue];
    [_myScrollView setContentOffset:CGPointMake(i*CGRectGetWidth(self.view.frame), 0) animated:YES];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //    CustomSegmentControl *customSegmentControl = [[CustomSegmentControl alloc]init];
    int page = _myScrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
    [_customSegmentControl animationWithIndex:page];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([TestNet isConnectionAvailable]) {
//        if([_searchText isEqualToString:@""]){
//            
//        }else{
        
            _searchText = [textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];;
            [self showProgressJuHua];
//        }
        
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
//    [self jiexi];
    
//    [_recommendTableView reloadData];
//    [_videoTableView reloadData];
//    [_articleTableView reloadData];
//    [_photoTableView reloadData];
    
    [self.view endEditing:YES];
    return YES;
}
 //手势
-(void)tapCGAction{
    [self.view endEditing:YES];
}

#pragma mark tableview的代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (tableView.tag) {
        case 1000:
            return _recommendArray.count;
            break;
        case 1001:
            return _videoArray.count;
            break;
        case 1002:
            return _articleArray.count;
            break;
        case 1003:
            return _photoArray.count;
            break;
        default:
            return 0;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    int i = (int)tableView.tag;
    switch (i) {
        case 1000:{
            FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recommendCell" forIndexPath:indexPath];
            NSDictionary *detailDic = [_recommendArray objectAtIndex:indexPath.row];
            NSString *imgUrl = [NSString stringWithFormat:@"http://in.3b2o.com/img/show/sid/%@/w//h//t/1/show.jpg",[detailDic objectForKey:@"imgSid"]];
//            [cell.imageView0 sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"Placegolder.png"]];
            cell.titleLabel.text = [detailDic objectForKey:@"title"];
            cell.fuTitleLabel.text = [detailDic objectForKey:@"digest"];
            NSString *button = [detailDic objectForKey:@"button"];
            if ([button isEqual: @"专题"] || [button isEqual: @"深度"] || [button isEqual: @"直播"]) {
                cell.xiaLabel.text = button;
                cell.xiaView.backgroundColor = [UIColor blueColor];
            }else if ([button isEqual: @"图集"] || [button isEqual: @"视频"]||[button isEqual: @"比赛"]){
                cell.xiaLabel.text = button;
                cell.xiaView.backgroundColor = [UIColor redColor];
            }else if ([button  isEqual: @"推广"] || [button  isEqual: @"推荐"]){
                cell.xiaLabel.text = button;
                cell.xiaView.backgroundColor = [UIColor greenColor];
            }else{
                cell.xiaLabel.text = nil;
                cell.xiaView.backgroundColor = [UIColor whiteColor];
            }
            return cell;
        }
            break;
        case 1001:{
            VideoSiftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell" forIndexPath:indexPath];
            NSDictionary *detailDic = [_videoArray objectAtIndex:indexPath.row];
//            [cell.videoImageView sd_setImageWithURL:[NSURL URLWithString:[detailDic objectForKey:@"imgUrl"]] placeholderImage:[UIImage imageNamed:@"Placegolder.png"]];
            cell.videoNameLabel.text = [detailDic objectForKey:@"name"];
            cell.timeLabel.text = [detailDic objectForKey:@"modtime"];
            cell.videoLengthLabel.text = [detailDic objectForKey:@"blength"];
            
            return cell;
        }
            break;
        case 1002:{
            static NSString *cellIdentifiter = @"cell";
            First_1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifiter];
            if (cell == nil) {
                // 通过xib的名称加载自定义的cell
                cell = [[[NSBundle mainBundle] loadNibNamed:@"First_1TableViewCell" owner:nil options:nil]firstObject];
            }
            NSDictionary *detailDic = [_articleArray objectAtIndex:indexPath.row];
            NSString *title = [detailDic objectForKey:@"title"];
            cell.title.text = title;
            cell.shuzi.text = [detailDic objectForKey:@"comm_count"];
            cell.shijian.text = [detailDic objectForKey:@"modtime_desc"];
            NSString *imgUrl = [NSString stringWithFormat:@"http://in.3b2o.com/img/show/sid/%@/w//h//t/1/show.jpg",[detailDic objectForKey:@"thumb_id"]];
//            [cell.zhaopian sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"Placegolder.png"]];
            return cell;
        }
            break;
        case 1003:{
            photoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
            cell.myImageView.image = [UIImage imageNamed:@"Placegolder.png"];
            NSDictionary *dic = [_photoArray objectAtIndex:indexPath.row];
            // 将请求放入子线程中
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dic objectForKey:@"firstImg"]]]];
                CGSize size = CGSizeMake(CGRectGetWidth(self.view.frame)-20, 200);
                UIImage *myImage = [self cutImage:image rect:size];
                
                // 当请求到图片的时候，回主线程为cell添加照片
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [cell.myImageView setImage:myImage];
                    cell.myLabel.text = [dic objectForKey:@"bname"];
                });
            });
            
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }

}

//裁剪图片
- (UIImage *)cutImage:(UIImage*)image
                 rect:(CGSize)size;
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < (size.width / size.height)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * size.height / size.width;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * size.width / size.height;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    
    return [UIImage imageWithCGImage:imageRef];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (tableView.tag) {
        case 1000:
            return 80;
            break;
        case 1001:
            return 80;
            break;
        case 1002:
            return 80;
            break;
        case 1003:
//            {UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[_photoArray objectAtIndex:indexPath.row] objectForKey:@"firstImg"]]]];
//            CGFloat width = CGRectGetWidth(self.view.frame)-40;
//            CGSize size = image.size;
//            CGFloat height = width * size.height / size.width;
//            return height+32+10;}
            return 247;
            break;
        default:
            return 0;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([TestNet isConnectionAvailable]) {
        
    
    switch (tableView.tag) {
        case 1000:{
            NSDictionary *dic = [_recommendArray objectAtIndex:indexPath.row];
            if ([[dic objectForKey:@"button"] isEqual: @"比赛"]) {
                // 调用组员写的。
                M2_thiredViewController *m2_thired = [[M2_thiredViewController alloc] init];
                m2_thired.sid = [[dic objectForKey:@"target"] objectForKey:@"sid"];
                //        NSString *str = [NSString stringWithFormat:@"http://www.zhiboba.com/article/show/%@",m2_thired.sid];
                //        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
                if ([[[dic objectForKey:@"target"] objectForKey:@"source"] isEqualToString:@"article"]) {
                    KongViewController *kongVC = [[KongViewController alloc] init];
                    kongVC.str = [[dic objectForKey:@"web"] objectForKey:@"url"];
                    [self presentViewController:kongVC animated:YES completion:nil];  // 模态
                }else{
                    
                    //        [self.navigationController pushViewController:m2_thired animated:YES];
                    [self presentViewController:m2_thired animated:YES completion:nil];
                }
                
            }else if ([[dic objectForKey:@"button"] isEqual: @"视频"]){
                KongViewController *kongVC = [[KongViewController alloc] init];
                NSString *sid = [[dic objectForKey:@"target"] objectForKey:@"sid"];
//                NSLog(@"%@",sid);
                NSString *videoPath = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/v/infoJson/%@?1453290284",sid];
                
                
                
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:videoPath]];
                if (data) {  // 如果这个参数里包含这个字符串，那么就执行。
                    NSDictionary *videoDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                    NSDictionary *videoPathDic = [videoDic objectForKey:@"defaultPlayer"];
                    kongVC.str = [videoPathDic objectForKey:@"url"];
                    [self presentViewController:kongVC animated:YES completion:nil];
                    //                    [self.navigationController pushViewController:kongVC animated:YES];
                }else{
                    M2_thiredViewController *m2_thired = [[M2_thiredViewController alloc] init];
                    m2_thired.sid = sid;
                    //                    [self.navigationController pushViewController:m2_thired animated:YES];
                    //                    kongVC.str = [model.web objectForKey:@"url"];
                    [self presentViewController:m2_thired animated:YES completion:nil];
                    //        kongVC.str = videoPathDic;
                }
            }else if ([[dic objectForKey:@"button"] isEqual: @"直播"]){
                M2_firstViewController *m2_first = [[M2_firstViewController alloc] init];
                m2_first.sid = [[dic objectForKey:@"target"] objectForKey:@"sid"];
                [self.navigationController pushViewController:m2_first animated:YES];
                //        [self presentViewController:m2_first animated:YES completion:nil];
            }else{
                KongViewController *kongVC = [[KongViewController alloc] init];
                NSString *str = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/article/showForMobile/%@",[[dic objectForKey:@"target"] objectForKey:@"sid"]];
                kongVC.str = str;
//                NSLog(@"%@",kongVC.str);
                [self presentViewController:kongVC animated:YES completion:nil];  // 模态
                //        [self.navigationController pushViewController:kongVC animated:YES];
            }

        }
            
            break;
        case 1001:{
            NSDictionary *dic = [_videoArray objectAtIndex:indexPath.row];
            NSArray *videoArr = [dic objectForKey:@"defaultMobileUrl"];
            CustomWebViewController *customWebViewController = [[CustomWebViewController alloc]init];
            customWebViewController.urlString = [videoArr objectAtIndex:1];
            [self presentViewController:customWebViewController animated:YES completion:nil];
        }
            break;
        case 1002:{
            NSDictionary *dic = [_articleArray objectAtIndex:indexPath.row];
            CustomWebViewController *customWebViewController = [[CustomWebViewController alloc]init];
             NSString *str = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/article/showForMobile/%@",[dic objectForKey:@"sid"]];
            customWebViewController.urlString = str;
//            customWebViewController.urlString = [dic objectForKey:@"origin_url"];
            [self presentViewController:customWebViewController animated:YES completion:nil];
        }
            break;
        case 1003:{
            NSDictionary *dic = [_photoArray objectAtIndex:indexPath.row];
            RealizeFirst_4ViewController *realizeFirst_4 = [[RealizeFirst_4ViewController alloc]init];
            realizeFirst_4.str = [dic objectForKey:@"sid"];
            [self presentViewController:realizeFirst_4 animated:YES completion:nil];
        }
            break;
        default:
            
            break;
    }
    }
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
