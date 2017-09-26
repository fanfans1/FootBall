//
//  First_1TableViewController.m
//  SoccerClub
//
//  Created by xalo on 16/1/13.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "First_1TableViewController.h"
#import "First_1TableViewCell.h"
#import "KongViewController.h"
//#import "UIImageView+WebCache.h"
//#import "MJRefresh.h"  // 下拉刷新
@interface First_1TableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) NSMutableArray *mutableArr;

@property (nonatomic,retain) NSData *data;  // 更新数据用
@end

@implementation First_1TableViewController

// 下拉刷新 上拉加载
-(void)renovateAndEvenMany{
    // 1、使用系统默认的刷新提示
    __block First_1TableViewController *vc = self;
    // 添加下拉刷新
    [self.tableView addHeaderWithCallback:^{
        [TestNet isConnectionAvailable];     // 判断网络
        NSString *stringUrl = @"http://zhiboba.3b2o.com/article/listJson/category/soccer?1452072425";// 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSURL *url = [NSURL URLWithString:stringUrl];
            _data = [NSData dataWithContentsOfURL:url];
            if (vc.data) {
                [CacheHelper writeCacheWithData:vc.data name:@"First_1TableViewController"];  // 缓存
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
        [TestNet isConnectionAvailable];     // 判断网络
        NSString *stringUrl = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/article/listJson/modtime/%@/category/soccer?1452924168",[[vc.mutableArr lastObject] objectForKey:@"modtime"]];
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSURL *url = [NSURL URLWithString:stringUrl];
            _data = [NSData dataWithContentsOfURL:url];
            if (vc.data) {
                NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:vc.data options:NSJSONReadingAllowFragments error:nil];
                for (NSDictionary *item in [receiveDic objectForKey:@"articles"]) {
                    [vc.mutableArr addObject:item];
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
    for (NSDictionary *item in [receiveDic objectForKey:@"articles"]) {
        [_mutableArr addObject:item];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     // 上下拉取
    [self renovateAndEvenMany];
    
    UINavigationController *navC = [[UINavigationController alloc] init];
    [navC addChildViewController:self];
    
    // 解析
    NSString *string = @"http://zhiboba.3b2o.com/article/listJson/category/soccer?1452072425";
    NSURL *url = [NSURL URLWithString:string];
    _data = [NSData dataWithContentsOfURL:url];
    if (_data) {
        [CacheHelper writeCacheWithData:self.data name:@"First_1TableViewController"];
        [self jiexi];
    }else{
         _data = [CacheHelper readCacheWithName:@"First_1TableViewController"];
        [self jiexi];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 80;
//    NSLog(@"__%@",_mutableArr);
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
    // 指定cellIdentifier为自定义的cell
    static NSString *cellIdentifiter = @"cell";
    First_1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifiter];
    if (cell == nil) {
        // 通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"First_1TableViewCell" owner:nil options:nil]firstObject];
    }
    cell.title.text = [[_mutableArr objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.shuzi.text = [[_mutableArr objectAtIndex:indexPath.row] objectForKey:@"comm_count"];
    cell.shijian.text = [[_mutableArr objectAtIndex:indexPath.row]objectForKey:@"modtime_desc"];
    NSString *str = [NSString stringWithFormat:@"http://in.3b2o.com/img/show/sid/%@/w//h//t/1/show.jpg",[[_mutableArr objectAtIndex:indexPath.row]objectForKey:@"thumb_id"]];
    [cell.zhaopian sd_setImageWithURL:[NSURL URLWithString:str]placeholderImage:[UIImage imageNamed:@"Placegolder.png"]];
    return cell;
//    NSLog(@"");
}

// 点击cell代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([TestNet isConnectionAvailable]) {
        
    KongViewController *kongVC = [[KongViewController alloc] init];
    NSString *str = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/article/showForMobile/%@",[[_mutableArr objectAtIndex:indexPath.row] objectForKey:@"sid"]];
    kongVC.str = str;
//    NSLog(@"%@",kongVC.str);
    [self presentViewController:kongVC animated:YES completion:nil];  // 模态
    }

//    [self presentViewController:realize1 animated:YES completion:nil];
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
