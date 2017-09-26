//
//  M_secondTableViewController.m
//  SoccerClub
//
//  Created by GCCC on 16/1/12.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "M_secondTableViewController.h"
#import "M_firstTableViewCell.h"
#import "M2_firstViewController.h"

@interface M_secondTableViewController ()

@property (nonatomic,retain)NSMutableArray  * array;
@property (nonatomic,retain) NSData *data;


@property (nonatomic,retain)NSArray * loadArr;

@property (nonatomic,retain)NSMutableArray * removeArr;
@end

@implementation M_secondTableViewController


-(void)loadData{
    //  使用系统默认的刷新提示
    __block M_secondTableViewController *vc = self;
    
    //  添加下拉刷新
    [self.tableView addHeaderWithCallback:^{
        [TestNet isConnectionAvailable];
        NSString *str = @"http://zhiboba.3b2o.com/mobileApi/programsV3/category/soccer?1452927970";
        
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSURL *urlStr = [NSURL URLWithString:str];
            _data = [NSData dataWithContentsOfURL:urlStr];
            if (!vc.data) {
                _data = [CacheHelper readCacheWithName:@"M_firstTable"];
                
            }else{
                
            }
            [vc jiexi];
            
            // 当请求到图片的时候，回主线程为cell添加照片
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //  数据重载
                [vc.tableView reloadData];
            });
        });
        
        //  结束刷新
        [vc.tableView headerEndRefreshing];
        
    }];
    
    //  上拉刷新
    [self.tableView addFooterWithCallback:^{
        [TestNet isConnectionAvailable];
        //   modtime需要拼接
        //  因为需要确定没刷新前的最后一行
        NSDictionary *lastDic = [vc.array lastObject];
        
        NSString *str = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/mobileApi/programsV3/category/soccer/action/newer/date/%@/important/1?1452927763",[lastDic objectForKey:@"ymd"]];
        
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSURL *urlStr = [NSURL URLWithString:str];
            _data  = [NSData dataWithContentsOfURL:urlStr];
            if (!vc.data) {
                _data = [CacheHelper readCacheWithName:@"M_firstTable"];
                
            }else{
                
            }
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:vc.data options:NSJSONReadingAllowFragments error:nil];
            
            _loadArr = [dic objectForKey:@"games"];
            
            [vc.array addObjectsFromArray:vc.loadArr];
            
            // 当请求到图片的时候，回主线程为cell添加照片
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //  数据重载
                [vc.tableView reloadData];
            });
        });
        
        
        
        //  结束刷新
        [vc.tableView footerEndRefreshing];
        
    }];

    
    
    
 
}

-(void)jiexi{
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
    
    _array = [NSMutableArray arrayWithArray:[dic objectForKey:@"games"]];
    
    NSDictionary *dic0 =[_array objectAtIndex:0];
    
    NSMutableArray *array = [dic0 objectForKey:@"games"];
    
    _removeArr = [NSMutableArray arrayWithArray:array];
    [_removeArr removeObjectAtIndex:0];
    
    //    //  去除每日福利
    //    dic setValue:<#(nullable id)#> forUndefinedKey:<#(nonnull NSString *)#>
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [mutableDic setValue:_removeArr forKey:@"games"];
    _array[0] = mutableDic;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //  下拉刷新
    [self loadData];
//    [TestNet isConnectionAvailable];
    
    UINavigationController *navC = [[UINavigationController alloc]init];
    [self addChildViewController:navC];
    
    NSString *urlString = @"http://zhiboba.3b2o.com/mobileApi/programsV3/category/soccer?1452154294";
    NSURL *url = [NSURL URLWithString:urlString];
    
    _data = [NSData dataWithContentsOfURL:url];
    if (!_data) {
        _data = [CacheHelper readCacheWithName:@"M_second"];
    }else{
    
    [CacheHelper writeCacheWithData:_data name:@"M_second"];
    
     
    }
    [self jiexi];
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
//    
//    
//    _array = [dic objectForKey:@"games"];
    
   
    [self.tableView registerClass:[M_firstTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
    return _array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dic = [_array objectAtIndex:section];
    NSMutableArray *array = [dic objectForKey:@"games"];
    _removeArr = [NSMutableArray arrayWithArray:array];
    for (int i = 0; i < _removeArr.count; i++) {
        if ([[_removeArr[i] objectForKey:@"id"] isEqualToString:@"40543"]) {
            [_removeArr removeObject:_removeArr[i]];
        }
    }
    return _removeArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    M_firstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary *dic = [_array objectAtIndex:indexPath.section];
    NSMutableArray *array = [dic objectForKey:@"games"];
//    _removeArr = [NSMutableArray arrayWithArray:array];
//    for (int i = 0; i < _removeArr.count; i++) {
//        if ([[_removeArr[i] objectForKey:@"id"] isEqualToString:@"40543"]) {
//            [_removeArr removeObject:_removeArr[i]];
//        }
//    }
    NSDictionary *dic1 = [array objectAtIndex:indexPath.row];
    cell.backImage.image = [UIImage imageNamed:@"Match_backImage.png"];
    cell.soccerName.text = [dic1 objectForKey:@"name"];
//    [cell.zanButton setImage:[UIImage imageNamed:@"M_dianzan.png"] forState:UIControlStateNormal];
//    cell.zanNumber.text = [[dic1 objectForKey:@"dig"] stringValue];
    
    //  比赛开始的时间
    cell.timeLabel.text = [dic1 objectForKey:@"timeName"];
    
    //  视频来源
    cell.source.text = [dic1 objectForKey:@"source"];
    
    //  足球联赛
    cell.soccerLeagueName.text = [dic1 objectForKey:@"leagueDesc"];
    
    return cell;
}


//  返回单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGRectGetHeight([UIScreen mainScreen].bounds) /7;
}

//  分区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSDictionary *dic = [_array objectAtIndex:section];
    NSString *string = [dic objectForKey:@"date"];
    if (!string) {
        return 0;
    }
    return 20;
}

//  自定义头分区的风格
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSDictionary *dic = [_array objectAtIndex:section];
    NSString *string = [dic objectForKey:@"date"];
    if (!string) {
        UIView *v = [[UIView alloc] init];
        return v;
    }
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 20)];
    view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    UILabel *label = [[UILabel alloc] initWithFrame:view.frame];
    label.text = string;
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    return view;
}


//  单元格点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([TestNet isConnectionAvailable]) {
        
    
        NSDictionary *dic = [_array objectAtIndex:indexPath.section];
        NSMutableArray *array = [dic objectForKey:@"games"];

    NSDictionary *dic1 = [array objectAtIndex:indexPath.row];
    NSString *sid = [dic1 objectForKey:@"sid"];
    NSString *time = [dic1 objectForKey:@"time"];
    NSMutableDictionary *homeInfoDic = [dic1 objectForKey:@"homeInfo"];
    M2_firstViewController *M2_first = [[M2_firstViewController alloc] init];
    M2_first.match = [dic1 objectForKey:@"timeName"];
    M2_first.homeInfoDic = homeInfoDic;
    M2_first.sid = sid;
    M2_first.time = time;
        
    M2_first.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:M2_first animated:YES];

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
