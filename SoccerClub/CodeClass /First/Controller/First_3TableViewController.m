//
//  First_3TableViewController.m
//  SoccerClub
//
//  Created by xalo on 16/1/13.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "First_3TableViewController.h"
#import "First_3TableViewCell.h"
//#import "UIImageView+WebCache.h"
#import "KongViewController.h"
//#import "MJRefresh.h"  // 下拉刷新
@interface First_3TableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) NSMutableArray *mutableArr;
@property (nonatomic,retain) NSData *data;  // 更新数据用
@end
@implementation First_3TableViewController

// 下拉刷新 上拉加载
-(void)renovateAndEvenMany{
    // 1、使用系统默认的刷新提示
    __block First_3TableViewController *vc = self;
    
    // 添加下拉刷新
    [self.tableView addHeaderWithCallback:^{
        [TestNet isConnectionAvailable];   // 判断网络 只是为了提示框
        NSString *stringUrl = @"http://zhiboba.3b2o.com/recommend/dailyRankListJson/category/soccer";
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSURL *url = [NSURL URLWithString:stringUrl];
            _data = [NSData dataWithContentsOfURL:url];
            if (vc.data) {
                [CacheHelper writeCacheWithData:vc.data name:@"First_3TableViewController"];
                _mutableArr = [NSJSONSerialization JSONObjectWithData:vc.data options:NSJSONReadingAllowFragments error:nil];   // 解析
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 上下拉取
    [self renovateAndEvenMany];
    
    // 解析
    NSString *str = @"http://zhiboba.3b2o.com/recommend/dailyRankListJson/category/soccer";
    NSURL *url = [NSURL URLWithString:str];
    _data = [NSData dataWithContentsOfURL:url];
    //    _mutableArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if (self.data) {
        [CacheHelper writeCacheWithData:self.data name:@"First_3TableViewController"];
        _mutableArr = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
    }else{
        _data = [CacheHelper readCacheWithName:@"First_3TableViewController"];
        _mutableArr = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100;
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
    //指定cellIdentifier为自定义cell
    static NSString *cellIdentifier = @"cell";
    // 自定义cell类
    First_3TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"First_3TableViewCell" owner:nil options:nil]firstObject];
        
        NSString *str = [NSString stringWithFormat:@"http://in.3b2o.com/img/show/sid/%@/w//h//t/1/show.jpg",[[_mutableArr objectAtIndex:indexPath.row] objectForKey:@"imgSid"]];
        [cell.imagei sd_setImageWithURL:[NSURL URLWithString:str]placeholderImage:[UIImage imageNamed:@"loadingimg.png"]];
        cell.title.text = [[_mutableArr objectAtIndex:indexPath.row] objectForKey:@"title"];
        cell.title2.text = [[_mutableArr objectAtIndex:indexPath.row] objectForKey:@"digest"];
        
    }
  
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([TestNet isConnectionAvailable]) {
        
    KongViewController *kongVC = [[KongViewController alloc] init];
    NSString *str = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/article/showForMobile/%@",[[[_mutableArr objectAtIndex:indexPath.row] objectForKey:@"target"] objectForKey:@"sid"]];
    kongVC.str = str;
//    NSLog(@"%@",kongVC.str);
//    [self presentViewController:kongVC animated:YES completion:nil];  // 模态
//    }
        [self.navigationController pushViewController:kongVC animated:YES];
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
