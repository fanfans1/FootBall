//
//  VideoSiftTableViewController.m
//  SoccerClub
//
//  Created by xalo on 16/1/11.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "VideoSiftTableViewController.h"
#import "VideoSiftTableViewCell.h"
#import "CustomWebViewController.h"
#import "MJRefresh.h"

@interface VideoSiftTableViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>

@property (nonatomic,retain)NSMutableArray *allVideoArr;

@property (nonatomic,retain)UIWebView *myWebView;

@property (nonatomic,retain)NSArray *loadArray; // 刷新时请求的新数组

@property (nonatomic,retain)NSData *data;
@end

@implementation VideoSiftTableViewController


- (NSMutableArray *)allVideoArr{
    if (!_allVideoArr) {
        _allVideoArr = [[NSMutableArray alloc]init];
    }
    return _allVideoArr;
}

- (void)loadData{
    // 使用系统默认的刷新提示
    __block VideoSiftTableViewController *vc = self;
    
    // 添加下拉刷新
    [self.tableView addHeaderWithCallback:^{
        NSString *str = @"http://zhiboba.3b2o.com/videoIndex/listJson/category/soccer?1452066637";
        NSURL *urlStr = [NSURL URLWithString:str];
        [TestNet isConnectionAvailable];
        _data = [NSData dataWithContentsOfURL:urlStr];
        if (vc.data) {
            [CacheHelper writeCacheWithData:vc.data name:@"videoSift"];
            [vc jiexi];
        }else{
            
        }
        // 数据重载
        [vc.tableView reloadData];
        // 结束刷新
        [vc.tableView headerEndRefreshing];
    }];
    // 添加上拉刷新
    [self.tableView addFooterWithCallback:^{
        [TestNet isConnectionAvailable];
        // modtime需要拼接
        NSDictionary *lastDic = [vc.allVideoArr lastObject];
        NSString *str = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/videoIndex/listJson/?category=soccer&modtime=%@&on=0&1452915206",[lastDic objectForKey:@"modtime_src"]];
        
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSURL *urlStr = [NSURL URLWithString:str];
            _data = [NSData dataWithContentsOfURL:urlStr];
            if (vc.data) {
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:vc.data options:NSJSONReadingAllowFragments error:nil];
                _loadArray = [dic objectForKey:@"videos"];
                [vc.allVideoArr addObjectsFromArray:vc.loadArray];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                // 数据重载
                [vc.tableView reloadData];
            });
        });
        // 结束刷新
        [vc.tableView footerEndRefreshing];
    }];
}
- (void)jiexi{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
    
    _allVideoArr = [NSMutableArray arrayWithArray:[dic objectForKey:@"videos"] ];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self loadData];
  
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UINavigationController *navC = [[UINavigationController alloc]init];
    [self addChildViewController:navC];
    
       NSString *str = @"http://zhiboba.3b2o.com/videoIndex/listJson/category/soccer?1452066637";
    // 将请求放入子线程中
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSURL *urlStr = [NSURL URLWithString:str];
        _data = [NSData dataWithContentsOfURL:urlStr];
        
        // 当请求到图片的时候，回主线程为cell添加照片
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.data) {
                [CacheHelper writeCacheWithData:self.data name:@"videoSift"];
            }else{
                _data = [CacheHelper readCacheWithName:@"videoSift"];
            }
            [self jiexi];
            [self.tableView reloadData];
            
        });
    });
    
    
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[VideoSiftTableViewCell class] forCellReuseIdentifier:@"CELL"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{

}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _allVideoArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoSiftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    NSDictionary *videoDetailDic = [self.allVideoArr objectAtIndex:indexPath.row];
//    [cell.videoImageView sd_setImageWithURL:[NSURL URLWithString:[videoDetailDic objectForKey:@"imgUrl"]]placeholderImage:[UIImage imageNamed:@"Placegolder.png"]];
    cell.videoLengthLabel.text = [videoDetailDic objectForKey:@"blength"];
    cell.videoNameLabel.text = [videoDetailDic objectForKey:@"bname"];
    cell.timeLabel.text = [videoDetailDic objectForKey:@"modtime"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([TestNet isConnectionAvailable]){
    NSDictionary *videoDetailDic = [self.allVideoArr objectAtIndex:indexPath.row];
    NSString *videoAddress = [videoDetailDic objectForKey:@"defaultMobileLink"];
    CustomWebViewController *customWebViewController = [[CustomWebViewController alloc]init];
    customWebViewController.urlString = videoAddress;
//    [self presentViewController:customWebViewController animated:YES completion:nil];
    [self.navigationController pushViewController:customWebViewController animated:YES];
    }
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
