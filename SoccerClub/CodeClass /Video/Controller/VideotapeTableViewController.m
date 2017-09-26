//
//  VideotapeTableViewController.m
//  SoccerClub
//
//  Created by xalo on 16/1/13.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "VideotapeTableViewController.h"
#import "VideoCollectionTableViewCell.h"
#import "VideotapeSubViewController.h"
#import "VideoCollectionTableViewCell1.h"

@interface VideotapeTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)NSMutableArray *dateArray;
@property (nonatomic,retain)NSMutableArray *allVideosArray;
@property (nonatomic,retain)NSData *data;
@property (nonatomic,retain)NSArray *loadArray;  // 上拉加载时获取的新数据
@end

@implementation VideotapeTableViewController

- (NSMutableArray *)dateArray{
    if (!_dateArray) {
        _dateArray = [NSMutableArray array];
    }
    return _dateArray;
}

- (NSMutableArray *)allVideosArray{
    if (!_allVideosArray) {
        _allVideosArray = [[NSMutableArray alloc]init];;
    }
    return _allVideosArray;
}
- (void)loadData{
    // 使用系统默认的刷新提示
    __block VideotapeTableViewController *vc = self;
    // 添加下拉刷新
    [self.tableView addHeaderWithCallback:^{
        [TestNet isConnectionAvailable];
        _dateArray = nil;
        NSString *urlStr = @"http://zhiboba.3b2o.com/recording/relatedVideoListJson/recording/1/category/soccer?1452155403";
        _data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
        if (vc.data) {
            [CacheHelper writeCacheWithData:vc.data name:@"videoTape"];
            [vc jiexi];
        }else{
//            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
//            label.center = vc.view.center;
//            label.text = @"木有网，肿么办？";
//            [vc.view addSubview:label];
            _data = [CacheHelper readCacheWithName:@"videoTape"];
            [vc jiexi];
        }
        // 数据重载
        [vc.tableView reloadData];
        // 结束刷新
        [vc.tableView headerEndRefreshing];
    }];
    
    [self.tableView addFooterWithCallback:^{
        [TestNet isConnectionAvailable];
        // modtime需要拼接
        NSDictionary *lastDatedic = [vc.allVideosArray lastObject];
        //        NSString *str = @"http://zhiboba.3b2o.com/videoIndex/listJson/?category=soccer&modtime=1452831562&on=0&1452915206";
        NSString *str = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/recording/relatedVideoListJson/date/%@/category/soccer?1452925161",[lastDatedic objectForKey:@"ymd"]];
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSURL *urlStr = [NSURL URLWithString:str];
            _data = [NSData dataWithContentsOfURL:urlStr];
            if (vc.data) {
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:vc.data options:NSJSONReadingAllowFragments error:nil];
                _loadArray = [dic objectForKey:@"relatedVideos"];
                for (NSDictionary *dic in vc.loadArray) {
                    NSString *date = [dic objectForKey:@"date"];
                    
                    [vc.dateArray addObject:date];
                }
                [vc.allVideosArray addObjectsFromArray:vc.loadArray];
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
// 解析获取的数据
- (void)jiexi{
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
    for (NSDictionary *dic in [dictionary objectForKey:@"relatedVideos"]) {
        NSString *date = [dic objectForKey:@"date"];
        [self.dateArray addObject:date];
    }
    NSArray *array = [dictionary objectForKey:@"relatedVideos"];
    _allVideosArray = [NSMutableArray arrayWithArray:array];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationController *navC = [[UINavigationController alloc]init];
    [self addChildViewController:navC];
    [self loadData];
    
    NSString *urlStr = @"http://zhiboba.3b2o.com/recording/relatedVideoListJson/recording/1/category/soccer?1452155403";
    _data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
    if (self.data) {
        [CacheHelper writeCacheWithData:self.data name:@"videoTape"];
        [self jiexi];
    }else{
        _data = [CacheHelper readCacheWithName:@"videoTape"];
        [self jiexi];
    }
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[VideoCollectionTableViewCell class] forCellReuseIdentifier:@"CELL"];
    [self.tableView registerClass:[VideoCollectionTableViewCell1 class] forCellReuseIdentifier:@"cell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dateArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dic = [self.allVideosArray objectAtIndex:section];
    NSArray *array = [dic objectForKey:@"games"];
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSDictionary *dic = [self.allVideosArray objectAtIndex:indexPath.section];
    NSArray *array = [dic objectForKey:@"games"];
    NSDictionary *detailDic = [array objectAtIndex:indexPath.row];
    
    
    NSArray *tagArr = [detailDic objectForKey:@"nav"];
//    NSLog(@"%@",tagArr);
    if (tagArr.count == 1) {
        VideoCollectionTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.nameLabel.text = [detailDic objectForKey:@"name"];
        cell.matchTimeLabel.text = [detailDic objectForKey:@"detailtime"];
        NSString *str = tagArr[0][1];
        if ([str isEqualToString:@"集锦"]) {
            cell.tag1TextField.text = str;
            cell.tag1TextField.textColor = [UIColor redColor];
            cell.tag1TextField.layer.borderColor = [UIColor redColor].CGColor;
        }else{
            cell.tag1TextField.text = str;
            cell.tag1TextField.textColor = [UIColor blueColor];
            cell.tag1TextField.layer.borderColor = [UIColor blueColor].CGColor;
        }
        return cell;
    }else{
        VideoCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
        cell.nameLabel.text = [detailDic objectForKey:@"name"];
        cell.matchTimeLabel.text = [detailDic objectForKey:@"detailtime"];
        cell.tag1TextField.text = tagArr[1][1];
        cell.tag1TextField.textColor = [UIColor blueColor];
        cell.tag1TextField.layer.borderColor = [UIColor blueColor].CGColor;
        cell.tag2TextField.text = tagArr[0][1];
        cell.tag2TextField.textColor = [UIColor redColor];
        cell.tag2TextField.layer.borderColor = [UIColor redColor].CGColor;
        
        return cell;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20)];
    view.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.7];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:13];
    label.text = [self.dateArray objectAtIndex:section];
    label.textColor = [UIColor whiteColor];
    [view addSubview:label];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([TestNet isConnectionAvailable]) {
        
    
    NSDictionary *dic = [self.allVideosArray objectAtIndex:indexPath.section];
    NSArray *array = [dic objectForKey:@"games"];
    NSDictionary *detailDic = [array objectAtIndex:indexPath.row];
    VideotapeSubViewController *videotapeSubViewController = [[VideotapeSubViewController alloc]init];
    videotapeSubViewController.targetArr = [detailDic objectForKey:@"nav"];
    videotapeSubViewController.nameStr = [detailDic objectForKey:@"name"];
    videotapeSubViewController.sidStr = [detailDic objectForKey:@"sid"];
//    [self presentViewController:videotapeSubViewController animated:YES completion:nil];
    [self.navigationController pushViewController:videotapeSubViewController animated:YES];
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
