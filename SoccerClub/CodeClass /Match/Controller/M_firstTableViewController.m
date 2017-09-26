//
//  firstTableViewController.m
//  SoccerClub
//
//  Created by GCCC on 16/1/11.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "M_firstTableViewController.h"
#import "M_firstTableViewCell.h"
#import "M2_firstViewController.h"
#define FONT [UIFont systemFontOfSize:15]

@interface M_firstTableViewController ()
@property (nonatomic,retain)NSMutableArray * array;
@property (nonatomic,retain)NSMutableArray *dateArray;
@property (nonatomic,retain)NSMutableArray * gameArray;
@property (nonatomic,retain)NSMutableDictionary * allDic;
@property (nonatomic,retain)NSData *data;

@property (nonatomic,retain)NSMutableArray * removeArr;

@property (nonatomic,retain)NSArray * loadArr;


@end

@implementation M_firstTableViewController
{
    NSDictionary *responseDict;
}
- (void)loadData{
    // 使用系统默认的刷新提示
    __block M_firstTableViewController *vc = self;
    
    // 添加下拉刷新
    [self.tableView addHeaderWithCallback:^{
        [TestNet isConnectionAvailable];
        NSString *str = @"http://zhiboba.3b2o.com/mobileApi/programsV3/category/soccer/important/1?1452154236";
        
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSURL *urlStr = [NSURL URLWithString:str];
            _data = [NSData dataWithContentsOfURL:urlStr];
            if (!vc.data) {
                _data = [CacheHelper readCacheWithName:@"M_firstTable"];
                
            }else{
                
            }
            
            [vc jiexi];
            dispatch_async(dispatch_get_main_queue(), ^{
                // 数据重载
                [vc.tableView reloadData];
                
            });
        });
        
        // 结束刷新
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
                
                //  结束刷新
                [vc.tableView footerEndRefreshing];
            });
        });
        
   
    }];
    

}

- (void)jiexi{
    
    NSDictionary *dic = [NSDictionary dictionary];
    
    if (_data) {
         dic = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
    }
    
    if (responseDict) {
        dic = responseDict;
    }
    
   
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
    [self loadData];
    UINavigationController *navC  = [[UINavigationController alloc]init];
    [self addChildViewController:navC];
   
    [TestNet isConnectionAvailable];
    
    [self firstLoadData];
    

    [self.tableView registerClass:[M_firstTableViewCell class] forCellReuseIdentifier:@"cell"];
  

}

#pragma mark -第一次加载数据
- (void)firstLoadData{
    NSString *urlString = @"http://zhiboba.3b2o.com/mobileApi/programsV3/category/soccer/important/1?1452154236";
    
    __weak typeof (self)weakSelf = self;
    [HttpManager getUrl: urlString Parameters: nil success:^(id responseData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([responseData isKindOfClass: [NSDictionary class]]) {
                responseDict = responseData;
                [weakSelf jiexi];
                [weakSelf.tableView reloadData];
            }
        });
    } failure:^(NSError *error) {
        NSLog(@"请求发生错误");
    }];
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
   
    NSDictionary *dic = _array[section];
    NSArray *array = [dic objectForKey:@"games"];
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   M_firstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    NSDictionary *dic =[self.array objectAtIndex:indexPath.section];
//    NSArray *array =[dic objectForKey:@"games"];
//    NSDictionary *dic1 = [array objectAtIndex:indexPath.row];
    NSDictionary *dic =[_array objectAtIndex:indexPath.section];
    
    NSMutableArray *array = [dic objectForKey:@"games"];
    
    //  去除每日福利
//    _removeArr = [NSMutableArray arrayWithArray:array];
//    for (int i = 0; i < _removeArr.count; i++) {
//        if ([[_removeArr[i] objectForKey:@"id"] isEqualToString:@"40543"]) {
//            [_removeArr removeObject:_removeArr[i]];
//        }
//    }
    NSDictionary *dic1 = [array objectAtIndex:indexPath.row];
    cell.backImage.image = [UIImage imageNamed:@"Match_backImage.png"];
    
    //  比赛名称
    cell.soccerName.text = [dic1 objectForKey:@"name"];
    //  点赞图标     /*/*/*未添加点击方法
//    [cell.zanButton setImage:[UIImage imageNamed:@"M_dianzan.png"] forState:UIControlStateNormal];
//    cell.zanImage.image = [UIImage imageNamed:@"M_dianzan.png"];
    //  点赞人数
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
    
    return CGRectGetHeight([UIScreen mainScreen].bounds)/7 ;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSDictionary *dic = [_array objectAtIndex:section];
    NSString *string = [dic objectForKey:@"date"];
    if (!string) {
        return 0;
    }

    return 20;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSDictionary *dic = [_array objectAtIndex:section];
    NSString *string = [dic objectForKey:@"date"];
    if (!string) {
        UIView *v = [[UIView alloc] init];
        return v;
    }
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 20)];
    view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    //
    UILabel *label = [[UILabel alloc] initWithFrame:view.frame];
    label.text = string;
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    return view;
}



//  单元格的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if ([TestNet isConnectionAvailable]) {
        NSDictionary *dic =[_array objectAtIndex:indexPath.section];
        
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

@end
