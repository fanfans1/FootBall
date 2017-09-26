//
//  VideotapeSubViewController.m
//  SoccerClub
//
//  Created by xalo on 16/1/13.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "VideotapeSubViewController.h"
#import "CollectionVideoTableViewCell.h"
#import "CustomWebViewController.h"

@interface VideotapeSubViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,retain)CustomSegmentControl *customSegmentControl;
@property (nonatomic,retain)NSMutableArray *targetArray;

@property (nonatomic,retain)UIScrollView *myScrollView;

@property (nonatomic,retain)NSMutableDictionary *allDataDic;

//@property (nonatomic,retain)

@end

@implementation VideotapeSubViewController

- (NSMutableArray *)targetArray{
    if (!_targetArray) {
        _targetArray = [[NSMutableArray alloc]init];
    }
    return _targetArray;
}
- (NSMutableDictionary *)allDataDic{
    if (!_allDataDic) {
        _allDataDic = [[NSMutableDictionary alloc]init];
    }
    return _allDataDic;
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%@",self.targetArr);
//    NSLog(@"%@",self.nameStr);
//    NSLog(@"%@",self.sidStr);
    
    for (NSArray *arr in self.targetArr) {
        [self.targetArray addObject:arr[1]];
    }
    self.navigationItem.title = @"录像";
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 44)];
//    view.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:view];
    self.allDataDic = [[NSMutableDictionary alloc]init];
    NSString *urlStr = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/program/relatedVideoForMobile/%@?1452157665",self.sidStr];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
    if (data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.allDataDic  = [NSMutableDictionary dictionaryWithDictionary:dic];
        NSMutableArray *keyArray = [[NSMutableArray alloc]init];
        
        for (int i =0;i<self.allDataDic.allKeys.count; i++) {
            NSArray *myArr = [self.allDataDic objectForKey:[self.allDataDic.allKeys objectAtIndex:i]];
            if (myArr.count == 0 ) {
                [keyArray addObject:[self.allDataDic.allKeys objectAtIndex:i]];
            }
        }
        [self.allDataDic removeObjectsForKeys:keyArray];
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        backBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        backBtn.frame = CGRectMake(10, 15,40, 54);
        [self.view addSubview:backBtn];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(55, 15, CGRectGetWidth(self.view.frame)-45, 54)];
        label.text = self.nameStr;
        label.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:label];
        
        
        _customSegmentControl = [[CustomSegmentControl alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 30)];
        
        [self.view addSubview:_customSegmentControl];
        [_customSegmentControl drawItemWithArr:_targetArray];
        
        
        _myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 94, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-94-49)];
        _myScrollView.delegate = self;
        _myScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame)*_targetArray.count, 0);
        [self.view addSubview:_myScrollView];
        _myScrollView.pagingEnabled = YES;
        for (int i=0; i<_targetArray.count; i++) {
            UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)*i, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(_myScrollView.frame))];
            tableView.dataSource = self;
            tableView.delegate = self;
            tableView.tag = 1000+i;
            [tableView registerClass:[CollectionVideoTableViewCell class] forCellReuseIdentifier:@"cell"];
            [self.myScrollView addSubview:tableView];
        }
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notice:) name:@"btnAction" object:nil];
        int page = _myScrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
        [_customSegmentControl animationWithIndex:page];
    }else{
        [TestNet isConnectionAvailable];
    }
    
    
    
    

    
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_targetArray.count ==1 ) {
        if ([_targetArray[0] isEqualToString:@"录像"]) {
           NSArray *array = [self.allDataDic objectForKey:@"recordings"];
            return array.count;
        }else{
            return 1;
        }
    }else{
        if (tableView.tag == 1000) {
            return 1;
        }else{
            NSArray *array = [self.allDataDic objectForKey:@"recordings"];
            return array.count;
        }
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_targetArray.count ==1 ) {
        if ([_targetArray[0] isEqualToString:@"录像"]) {
            NSArray *array = [self.allDataDic objectForKey:@"recordings"];
            NSDictionary *dic = [array objectAtIndex:section];
            NSArray *videosArr = [dic objectForKey:@"videos"];
            return videosArr.count;
        }else{
            return 1;
        }
    }else{
        if (tableView.tag == 1000) {
            NSArray *array = [self.allDataDic objectForKey:@"highlights"];
            return array.count;
        }else{
            NSArray *array = [self.allDataDic objectForKey:@"recordings"];
            NSDictionary *dic = [array objectAtIndex:section];
            NSArray *videosArr = [dic objectForKey:@"videos"];
            return videosArr.count;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CollectionVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(70, CGRectGetHeight(cell.frame)/3*2+4, 80, CGRectGetHeight(cell.frame)/3-12)];
//    label.text = @"比赛时间";
//    [cell.contentView addSubview:label];
    if (_targetArray.count ==1 ) {
        if ([_targetArray[0] isEqualToString:@"录像"]) {
            NSArray *array = [self.allDataDic objectForKey:@"recordings"];
            NSDictionary *dic = [array objectAtIndex:indexPath.section];
            NSArray *videosArr = [dic objectForKey:@"videos"];
            NSDictionary *videoDic = [videosArr objectAtIndex:indexPath.row];
            cell.nameLabel.text = [videoDic objectForKey:@"name"];
            cell.timeLabel.text = [videoDic objectForKey:@"length"];
            return cell;
        }else{
            return nil;
        }
    }else{
        if (tableView.tag == 1000) {
            NSArray *array = [self.allDataDic objectForKey:@"highlights"];
            NSDictionary *dic = [array objectAtIndex:indexPath.row];
            cell.nameLabel.text = [dic objectForKey:@"name"];
            cell.timeLabel.text = [dic objectForKey:@"length"];
            return cell;
        }else{
            NSArray *array = [self.allDataDic objectForKey:@"recordings"];
            NSDictionary *dic = [array objectAtIndex:indexPath.section];
            NSArray *videosArr = [dic objectForKey:@"videos"];
            NSDictionary *videoDic = [videosArr objectAtIndex:indexPath.row];
            cell.nameLabel.text = [videoDic objectForKey:@"name"];
            cell.timeLabel.text = [videoDic objectForKey:@"length"];
            return cell;
        }
    }
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (_targetArray.count ==1 ) {
        if ([_targetArray[0] isEqualToString:@"录像"]) {
            NSArray *array = [self.allDataDic objectForKey:@"recordings"];
            NSDictionary *dic = [array objectAtIndex:section];
            return [dic objectForKey:@"source"];
        }else{
            return nil;
        }
    }else{
        if (tableView.tag == 1000) {
            return nil;
        }else{
            NSArray *array = [self.allDataDic objectForKey:@"recordings"];
            NSDictionary *dic = [array objectAtIndex:section];
            return [dic objectForKey:@"source"];
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([TestNet isConnectionAvailable]) {
        
    
    if (_targetArray.count ==1 ) {
        if ([_targetArray[0] isEqualToString:@"录像"]) {
            NSArray *array = [self.allDataDic objectForKey:@"recordings"];
            NSDictionary *dic = [array objectAtIndex:indexPath.section];
            NSArray *videosArr = [dic objectForKey:@"videos"];
            NSDictionary *videoDic = [videosArr objectAtIndex:indexPath.row];
            CustomWebViewController *customWebViewController = [[CustomWebViewController alloc]init];
            customWebViewController.urlString = [videoDic objectForKey:@"defaultMobileLink"];
//            [self presentViewController:customWebViewController animated:YES completion:nil];
            [self.navigationController pushViewController:customWebViewController animated:YES];
            
        }else{
            
        }
    }else{
        if (tableView.tag == 1000) {
            NSArray *array = [self.allDataDic objectForKey:@"highlights"];
            NSDictionary *dic = [array objectAtIndex:indexPath.row];
            CustomWebViewController *customWebViewController = [[CustomWebViewController alloc]init];
            customWebViewController.urlString = [dic objectForKey:@"defaultMobileLink"];
//            [self presentViewController:customWebViewController animated:YES completion:nil];
            [self.navigationController pushViewController:customWebViewController animated:YES];
        }else{
            NSArray *array = [self.allDataDic objectForKey:@"recordings"];
            NSDictionary *dic = [array objectAtIndex:indexPath.section];
            NSArray *videosArr = [dic objectForKey:@"videos"];
            NSDictionary *videoDic = [videosArr objectAtIndex:indexPath.row];
            CustomWebViewController *customWebViewController = [[CustomWebViewController alloc]init];
            customWebViewController.urlString = [videoDic objectForKey:@"defaultMobileLink"];
//            [self presentViewController:customWebViewController animated:YES completion:nil];
            [self.navigationController pushViewController:customWebViewController animated:YES];
        }
    }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

// scrollView的代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = _myScrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
    [_customSegmentControl animationWithIndex:page];
}
// 监听的代理方法
- (void)notice:(id)sender{
    NSNotification *notice = sender;
    NSString * str = notice.object;
    for (int i = 0; i < _targetArray.count; i++) {
        if ([_targetArray[i] isEqualToString:str]) {
            
            [_myScrollView setContentOffset:CGPointMake(i*CGRectGetWidth(self.view.frame), 0) animated:YES];
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
