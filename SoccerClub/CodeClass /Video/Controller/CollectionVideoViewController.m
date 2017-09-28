//
//  CollectionVideoViewController.m
//  SoccerClub
//
//  Created by xalo on 16/1/13.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "CollectionVideoViewController.h"
#import "CollectionVideoTableViewCell.h"
#import "CollectionVideoTableViewCell1.h"
#import "CustomWebViewController.h"
@interface CollectionVideoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)UITableView *myTableView;

@property (nonatomic,retain)NSArray *allDataArray;

@end

@implementation CollectionVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UINavigationController *navC = [[UINavigationController alloc]init];
    [self addChildViewController:navC];
    self.navigationItem.title = @"集锦";
    
//    NSString *string = @"http://zhiboba.3b2o.com/program/videosJson/JmZAb4Nrx8L?1452135232 ";
    NSString *urlStr = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/program/videosJson/%@?1452135232",self.sid];
    
    // 将请求放入子线程中
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSURL *url = [NSURL URLWithString:urlStr];
        NSData *data = [NSData dataWithContentsOfURL:url];
        if (data) {
            
            _allDataArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        }else{
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableView reloadData];
        });
    });
    
    
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame = CGRectMake(0, 10, 80, 64);
    
    backBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64-49)];
    [self.view addSubview:_myTableView];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    [self.myTableView registerClass:[CollectionVideoTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.myTableView registerClass:[CollectionVideoTableViewCell1 class] forCellReuseIdentifier:@"CELL"];
    // Do any additional setup after loading the view.
}



- (void)backAction{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _allDataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dic = [_allDataArray objectAtIndex:section];
    NSDictionary *detailDic = [dic objectForKey:@"group"];
    NSArray *array = [detailDic objectForKey:@"videos"];
    
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [_allDataArray objectAtIndex:indexPath.section];
    NSDictionary *detailDic = [dic objectForKey:@"group"];
    NSArray *array = [detailDic objectForKey:@"videos"];
    NSString *groupName = [detailDic objectForKey:@"groupname"];
    if ([groupName isEqualToString:@"精华镜头"]) {
        CollectionVideoTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
        NSDictionary *dic = [array objectAtIndex:indexPath.row];
        cell.nameLabel.text = [dic objectForKey:@"name"];
        NSString *fromStr = [dic objectForKey:@"from"];
        NSString *lengthStr = [dic objectForKey:@"length"];
        NSString *timeStr;
        if (lengthStr && fromStr) {
            timeStr = [fromStr stringByAppendingString:[NSString stringWithFormat:@"·%@",lengthStr]];
        }else if (lengthStr){
            timeStr = lengthStr;
        }else{
            timeStr = timeStr;
        }
        cell.timeLabel.text = timeStr;
        cell.timeLabel.font = [UIFont systemFontOfSize:12];
        cell.nameLabel.font = [UIFont systemFontOfSize:15];
        NSDictionary *imageInfodic = [dic objectForKey:@"imgInfo"];
        NSString *imageUrlStr = [NSString stringWithFormat:@"http://in.3b2o.com/img/show/sid/%@/w//h//t/1/show.jpg",[imageInfodic objectForKey:@"sid"]];
        [cell.videoImageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]placeholderImage:[UIImage imageNamed:@"loadingimg.png"]];
        
        
        return cell;
    }else{
        CollectionVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        NSDictionary *dic = [array objectAtIndex:indexPath.row];
        cell.nameLabel.text = [dic objectForKey:@"name"];
        cell.nameLabel.font = [UIFont systemFontOfSize:15];
        NSString *fromStr = [dic objectForKey:@"from"];
        NSString *lengthStr = [dic objectForKey:@"length"];
        NSString *timeStr;
        if (lengthStr && fromStr) {
            timeStr = [fromStr stringByAppendingString:[NSString stringWithFormat:@"·%@",lengthStr]];
        }else if (lengthStr){
            timeStr = lengthStr;
        }else{
            timeStr = fromStr;
        }
        cell.timeLabel.text = timeStr;
        cell.timeLabel.font = [UIFont systemFontOfSize:12];
        
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *dic = [self.allDataArray objectAtIndex:section];
    return [[dic objectForKey:@"group"] objectForKey:@"groupname"];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([TestNet isConnectionAvailable]) {
        
    
    NSDictionary *dic = [_allDataArray objectAtIndex:indexPath.section];
    NSDictionary *detailDic = [dic objectForKey:@"group"];
    NSArray *array = [detailDic objectForKey:@"videos"];
    NSDictionary *videoDic = [array objectAtIndex:indexPath.row];
    NSDictionary *targetDic = [videoDic objectForKey:@"target"];
    NSString *videoUrlStr = [targetDic objectForKey:@"para"];
    NSString *videourl = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/v/infoJson/%@?1452673470",videoUrlStr];
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:videourl]];
    NSDictionary *videodic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSString *myVideoDic = [[videodic objectForKey:@"defaultPlayer"] objectForKey:@"url"];
    
    CustomWebViewController *customWebViewController = [[CustomWebViewController alloc]init];
    customWebViewController.urlString = myVideoDic;
    [self.navigationController pushViewController:customWebViewController animated:YES];
//    [self presentViewController:customWebViewController animated:YES completion:nil];
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
