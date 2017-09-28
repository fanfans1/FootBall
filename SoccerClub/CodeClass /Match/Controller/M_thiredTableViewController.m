//
//  M_thiredTableViewController.m
//  SoccerClub
//
//  Created by GCCC on 16/1/12.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "M_thiredTableViewController.h"
#import "M_thiredTableViewCell.h"
#import "M2_thiredViewController.h"
#import "M2_firstViewController.h"


@interface M_thiredTableViewController ()
@property (nonatomic,retain)NSMutableArray * array;
@property (nonatomic,retain)NSData *data;

@property (nonatomic,retain)NSArray * loadArr;
@end

@implementation M_thiredTableViewController
{
    NSDictionary *responseDict;
}

-(void)loadData{
    //  使用系统默认的刷新提示
    __block M_thiredTableViewController *vc = self;
    
    //  添加下拉刷新
    [self.tableView addHeaderWithCallback:^{
        [TestNet isConnectionAvailable];
       NSString *str = @"http://zhiboba.3b2o.com/mobileApi/programsV3/category/soccer/action/older?1452928081";
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSURL *urlStr = [NSURL URLWithString:str];
            _data = [NSData dataWithContentsOfURL:urlStr];
            if (!vc.data) {
                //            _data = [CacheHelper readCacheWithName:@"M_firstTable"];
                
            }else{
                [CacheHelper writeCacheWithData:vc.data name:@"M_thired"];
                [vc jiexi];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //  数据重载
                [vc.tableView reloadData];                
            });
        });
        [vc.tableView headerEndRefreshing];
    }];
    
    
    //  上拉刷新
    [self.tableView addFooterWithCallback:^{
        [TestNet isConnectionAvailable];
        //   modtime需要拼接
        //  因为需要确定没刷新前的最后一行
        NSDictionary *lastDic = [vc.array lastObject];
        
        NSString *str = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/mobileApi/programsV3/category/soccer/action/older/date/%@?1452944233",[lastDic objectForKey:@"ymd"]];
        
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSURL *urlStr = [NSURL URLWithString:str];
            _data  = [NSData dataWithContentsOfURL:urlStr];
            if (!vc.data) {
                _data = [CacheHelper readCacheWithName:@"M_firstTable"];
            }else{
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:vc.data options:NSJSONReadingAllowFragments error:nil];
                _loadArr = [dic objectForKey:@"games"];
                [vc.array addObjectsFromArray:vc.loadArr];
            }
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
    NSDictionary *dic = [NSDictionary dictionary];
    
    if (_data) {
        dic = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
    }
    if (responseDict) {
        dic = responseDict;
    }
    _array = [NSMutableArray arrayWithArray:[dic objectForKey:@"games"]];
   
}
#pragma mark -第一次加载数据
- (void)firstLoadData{
    NSString *urlString = @"http://zhiboba.3b2o.com/mobileApi/programsV3/category/soccer/action/older?1452610290";
    
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self loadData];
//    [TestNet isConnectionAvailable];
    UINavigationController *navC = [[UINavigationController alloc]init];
    [self addChildViewController:navC];
    
    [self firstLoadData];
    
    
    [self.tableView registerClass:[M_thiredTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[M_thiredTableViewCell class] forCellReuseIdentifier:@"CELL"];
    
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
    NSArray *secondArray = [dic objectForKey:@"games"];
    
    return secondArray.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = [_array objectAtIndex:indexPath.section];
    NSArray *array = [dic objectForKey:@"games"];
    
    NSDictionary *dic1 = [array objectAtIndex:indexPath.row];
    
    if ([[dic1 objectForKey:@"guestInfo"]isKindOfClass:[NSArray class]]) {
            M_thiredTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
            cell.backImage.image = [UIImage imageNamed:@"Match_backImage.png"];
            cell.soccerName.text = [dic1 objectForKey:@"name"];
            cell.soccerLeagueName.text = [dic1 objectForKey:@"leagueDesc"];
            cell.source.text = [dic1 objectForKey:@"source"];
        
    
            return cell;
        
    }else{
        
        M_thiredTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.backImage.image = [UIImage imageNamed:@"Match_backImage.png"];
        cell.guestInfo.text = [[dic1 objectForKey:@"guestInfo"] objectForKey:@"name"];
        NSURL *url = [NSURL URLWithString:[[dic1 objectForKey:@"guestInfo"] objectForKey:@"logo"]];
        [cell.guestLogo sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"loadingimg.png"]];
        cell.guestScore.text = [[dic1 objectForKey:@"guestInfo"] objectForKey:@"score"];
        cell.homeInfo.text = [[dic1 objectForKey:@"homeInfo"] objectForKey:@"name"];
        
        NSURL *url1 = [NSURL URLWithString:[[dic1 objectForKey:@"homeInfo"] objectForKey:@"logo"]];
        [cell.homeLogo sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"loadingimg.png"]];
        
        cell.homeScore.text = [[dic1 objectForKey:@"homeInfo"] objectForKey:@"score"];
        cell.soccerLeagueName.text = [dic1 objectForKey:@"leagueDesc"];
        cell.source.text = [dic1 objectForKey:@"source"];
        
        return cell;
    }

    
    
    
    
}

//  返回单元格的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGRectGetHeight([UIScreen mainScreen].bounds) /7;
}



//  返回分区头高度
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
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,CGRectGetWidth([UIScreen mainScreen].bounds), 20)];
    view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    UILabel *lable = [[UILabel alloc] initWithFrame:view.frame];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:13];
    lable.textColor = [UIColor grayColor];
    lable.text = string;
    
    [view addSubview:lable];
    
    return view;
}

//  单元格点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ([TestNet isConnectionAvailable]) {
    
    
    NSArray *array = [[self.array objectAtIndex:indexPath.section]objectForKey:@"games"];
    NSDictionary *dic = [array objectAtIndex:indexPath.row];
    NSString *sid = [dic objectForKey:@"sid"];
//    NSString *time = [dic objectForKey:@"time"];
    
    
    M2_thiredViewController *M2_thired = [[M2_thiredViewController alloc] init];
    M2_thired.sid = sid;
        
    [self presentViewController:M2_thired animated:YES completion:^{
        
    }];
//    }
//    [self.navigationController pushViewController:M2_thired animated:YES];
}


@end
