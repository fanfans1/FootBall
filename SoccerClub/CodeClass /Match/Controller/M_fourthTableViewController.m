//
//  M_fourthTableViewController.m
//  SoccerClub
//
//  Created by GCCC on 16/1/13.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "M_fourthTableViewController.h"
#import "M_fourthTableViewCell.h"
#import "M2_fourthViewController.h"

@interface M_fourthTableViewController ()

@property (nonatomic,retain)NSMutableArray * array;

@end

@implementation M_fourthTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UINavigationController *navC = [[UINavigationController alloc]init];
    [self addChildViewController:navC];

    
    
    NSData *data =[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://zhiboba.3b2o.com/leagueData/listJson?1452067806"]];
    if (!data) {
       data = [CacheHelper readCacheWithName:@"M_four"];
    }else{
    
    [CacheHelper writeCacheWithData:data name:@"M_four"];
    
    }
    
    
    NSArray * array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    _array = [NSMutableArray arrayWithArray:array];
    NSMutableArray *deleteArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < _array.count; i++) {
        NSDictionary *dic = [_array objectAtIndex:i];
        if ([[dic objectForKey:@"league"] isEqualToString:@"nba"]) {
            [deleteArr addObject:dic];

    }
    for (int i = 0; i<deleteArr.count; i++) {
        NSDictionary *dic = [deleteArr objectAtIndex:i];
        [_array removeObject:dic];
    }
     }
    
    [self.tableView registerClass:[M_fourthTableViewCell class] forCellReuseIdentifier:@"cell"];
    
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
    
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    M_fourthTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:240/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    NSDictionary *dic = [_array objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = [dic objectForKey:@"name"];
    cell.descLabel.text = [dic objectForKey:@"desc"];
    cell.descLabel.font = [UIFont systemFontOfSize:13];

    
    return cell;
}

//  返回分区的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

//  单元格点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ([TestNet isConnectionAvailable]) {
    
    
    M2_fourthViewController *M2_fourth = [[M2_fourthViewController alloc] init];
    M2_fourth.receiveDic = [_array objectAtIndex:indexPath.row];
        
    M2_fourth.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:M2_fourth animated:YES];
//    }

}


@end
