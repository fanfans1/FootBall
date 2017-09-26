//
//  RealizeFirst_2ViewController.m
//  SoccerClub
//
//  Created by xalo on 16/1/14.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "RealizeFirst_2ViewController.h"
#import "RealizeFirst2_TableViewCell.h"
//#import "UIImageView+WebCache.h"
#import "KongViewController.h"
//#import "MJRefresh.h"  // 下拉刷新
@interface RealizeFirst_2ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain) NSDictionary *Dic;
@property (nonatomic,retain) NSData *data;  // 更新数据用
@property (nonatomic,retain) UITableView *tableView;
@end

@implementation RealizeFirst_2ViewController

// 下拉刷新 上拉加载
-(void)renovateAndEvenMany{
    // 1、使用系统默认的刷新提示
    __block RealizeFirst_2ViewController *vc = self;
    
    // 添加下拉刷新
    [self.tableView addHeaderWithCallback:^{
        NSString *str = [NSString stringWithFormat:@"http://zhiboba.3b2o.com//recommend/recommendCollectionInfoJson/%@",vc.sid];
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSURL *url = [NSURL URLWithString:str];
            _data = [NSData dataWithContentsOfURL:url];
            
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
        // 数据重载
        [vc.tableView reloadData];
        // 结束刷新
        [vc.tableView footerEndRefreshing];
//        NSLog(@"结束刷新");
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 数据解析
    NSString *str = [NSString stringWithFormat:@"http://zhiboba.3b2o.com//recommend/recommendCollectionInfoJson/%@",self.sid];
    NSURL *url = [NSURL URLWithString:str];
    _data = [NSData dataWithContentsOfURL:url];
    if (self.data) {
        
        _Dic = [NSDictionary dictionary];
        _Dic = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
        //    NSLog(@"!!%@",_Dic);
        
        self.navigationItem.title = [_Dic objectForKey:@"title"];
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"0.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnAction)];
        self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeFont:[UIFont systemFontOfSize:16]};
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 80;
        [self.view addSubview:_tableView];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 280)];
        //    view.backgroundColor = [UIColor greenColor];
        _tableView.tableHeaderView = view;
        [_tableView addSubview:view];
        
        // 将照片贴到view上
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 220)];
        // 打开交互
        imageView.userInteractionEnabled = YES;
        [view addSubview:imageView];
        if (self.data) {
            
            // 添加照片用的______
            NSDictionary *dic = [[_Dic objectForKey:@"group"] objectAtIndex:0];  // group数组下0这个字典
            //    NSLog(@"dic=%@",dic);
            NSDictionary *dic2 = [[dic objectForKey:@"items"] objectAtIndex:0];  // 取出了每一个
//            NSLog(@"arr = %@",dic2);/
            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://in.3b2o.com/img/show/sid/%@/w//h//t/1/show.jpg",[dic2 objectForKey:@"imgSid"]]]placeholderImage:[UIImage imageNamed:@"Placegolder.png"]];
        }
        //______
        
#pragma  mark -- 轻拍手势
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGest:)];
        // 设置触控对象的最小数量
        [tapGest setNumberOfTouchesRequired:1];
        // 设置轻拍的次数。
        [tapGest setNumberOfTapsRequired:1];
        [imageView addGestureRecognizer:tapGest];
        
        
        // 照片下透明view
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 190, CGRectGetWidth(self.view.frame), 30)];
        //    view1.backgroundColor = [UIColor redColor];
        view1.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        [imageView addSubview:view1];
        // view里的label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.view.frame), 25)];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor whiteColor];
        label.text = [_Dic objectForKey:@"title"];
        [view1 addSubview:label];
        
        // 这个是导语那块的
        UIView *daoYuview = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(imageView.frame)+10, 30, 20)];
        daoYuview.backgroundColor = [UIColor redColor];
        [view addSubview:daoYuview];
        UILabel *daoYulabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30,20)];
        daoYulabel.text = @"导语";
        daoYulabel.font = [UIFont systemFontOfSize:14];
        daoYulabel.textAlignment = NSTextAlignmentCenter;
        daoYulabel.textColor = [UIColor whiteColor];
        //    daoYulabel.textColor = [UIColor redColor];
        [daoYuview addSubview:daoYulabel];
        UILabel *daoYulabel2 = [[UILabel alloc] initWithFrame:CGRectMake(45, CGRectGetHeight(imageView.frame), CGRectGetWidth(imageView.frame)-50, 50)];
        daoYulabel2.font = [UIFont systemFontOfSize:14];
        daoYulabel2.text = [_Dic objectForKey:@"brief"];
        daoYulabel2.numberOfLines = 0;
        [view addSubview:daoYulabel2];
        
    }else{
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
        label.center = self.view.center;
        label.text = @"木有网，肿么办？";
        [self.view addSubview:label];
    }
    // 边缘轻扫
    [self screenEdgePan];
    
    // 上下拉去
    [self renovateAndEvenMany];
}
//-(void)leftBtnAction{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

// 轻拍手势的方法
-(void)tapGest:(UITapGestureRecognizer *)sender{
    
    KongViewController *kongView = [[KongViewController alloc] init];
    NSDictionary *dic = [[_Dic objectForKey:@"group"] objectAtIndex:0];
    NSDictionary *dic2 = [[dic objectForKey:@"items"] objectAtIndex:0];
    NSString *str = [[dic2 objectForKey:@"target"] objectForKey:@"sid"];
    // 拼接
    NSString *string = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/article/appRecap/sid/%@/iPhone",str];
    kongView.str = string;
    [self.navigationController pushViewController:kongView animated:YES];
//    NSLog(@"轻拍了一下");
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = [[[_Dic objectForKey:@"group"] objectAtIndex:0] objectForKey:@"items"];
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 指定cellIdentifier为自定义的cell
    static NSString *cellIdentifier = @"cell";
    RealizeFirst2_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        // 通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle]loadNibNamed:@"RealizeFirst2_TableViewCell" owner:nil options:nil
                 ]firstObject];
    }
    
    NSDictionary *dic = [[_Dic objectForKey:@"group"] objectAtIndex:0];  // group数组下0这个字典
//    NSLog(@"dic=%@",dic);
    NSDictionary *dic2 = [[dic objectForKey:@"items"] objectAtIndex:indexPath.row];  // 取出了每一个
//    NSLog(@"arr = %@",dic2);
    [cell.zhaopian sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://in.3b2o.com/img/show/sid/%@/w//h//t/1/show.jpg",[dic2 objectForKey:@"imgSid"]]]placeholderImage:[UIImage imageNamed:@"Placegolder.png"]];
    cell.label1.text = [dic2 objectForKey:@"title"];
    cell.label2.text = [dic2 objectForKey:@"digest"];
    
    
    return cell;
}

// tableView 头标题
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *str = [[[_Dic objectForKey:@"group"] objectAtIndex:0] objectForKey:@"name"];
    return str;
}

// 点击cell代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KongViewController *kongView = [[KongViewController alloc] init];
    NSDictionary *dic = [[_Dic objectForKey:@"group"] objectAtIndex:0];
    NSDictionary *dic2 = [[dic objectForKey:@"items"] objectAtIndex:indexPath.row];
    NSString *str = [[dic2 objectForKey:@"target"] objectForKey:@"sid"];
    // 拼接
    NSString *string = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/article/appRecap/sid/%@/iPhone",str];
    kongView.str = string;
    [self.navigationController pushViewController:kongView animated:YES];
    
//    RealizeFIrst_2_1ViewController *realizeFIrst_2_1 = [[RealizeFIrst_2_1ViewController alloc] init];
//    NSDictionary *dic = [[_Dic objectForKey:@"group"] objectAtIndex:0];
//    NSDictionary *dic2 = [[dic objectForKey:@"items"] objectAtIndex:indexPath.row];
//    realizeFIrst_2_1.str = [[dic2 objectForKey:@"target"] objectForKey:@"sid"];
//    [self.navigationController pushViewController:realizeFIrst_2_1 animated:YES];
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

-(void)leftBtnItem{
    if (self.navigationController) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else{
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

// 创建边缘轻扫手势
-(void)screenEdgePan{
    UIScreenEdgePanGestureRecognizer *screenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(leftBtnItem)];
    screenEdgePan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:screenEdgePan];
}
@end
