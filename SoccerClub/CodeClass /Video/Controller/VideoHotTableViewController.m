//
//  VideoHotTableViewController.m
//  SoccerClub
//
//  Created by xalo on 16/1/13.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "VideoHotTableViewController.h"
#import "VideoHotTableViewCell.h"
#import "CustomWebViewController.h"
@interface VideoHotTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)NSArray *allDataArray;
@property (nonatomic,retain)NSData *data;
@end

@implementation VideoHotTableViewController

- (void)loadData{
    // 使用系统默认的刷新提示
    __block VideoHotTableViewController *vc = self;
    // 添加下拉刷新
    [self.tableView addHeaderWithCallback:^{
        [TestNet isConnectionAvailable];
        NSString *urlStr = @"http://zhiboba.3b2o.com/videoIndex/rankVideosListJson/category/soccer?1452153011";
        _data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
        if (vc.data) {
            [CacheHelper writeCacheWithData:vc.data name:@"videoHot"];
            [vc jiexi];
        }else{
//            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
//            label.center = self.view.center;
//            label.text = @"木有网，肿么办？";
//            [self.view addSubview:label];
            _data = [CacheHelper readCacheWithName:@"videoHot"];
            [vc jiexi];
        }
        // 数据重载
        [vc.tableView reloadData];
        // 结束刷新
        [vc.tableView headerEndRefreshing];
    }];
    
    
}
- (void)jiexi{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments error:nil];
    _allDataArray = [dic objectForKey:@"videos"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationController *navC = [[UINavigationController alloc]init];
    [self addChildViewController:navC];
    
    [self loadData];
    
    NSString *str = @"http://zhiboba.3b2o.com/videoIndex/rankVideosListJson/category/soccer?1452153011";
    NSURL *urlStr = [NSURL URLWithString:str];
    _data = [NSData dataWithContentsOfURL:urlStr];
    if (self.data) {
        [CacheHelper writeCacheWithData:self.data name:@"videoHot"];
        [self jiexi];
    }else{
        _data = [CacheHelper readCacheWithName:@"videoHot"];
        [self jiexi];
    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[VideoHotTableViewCell class] forCellReuseIdentifier:@"CELL"];
    
    
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.allDataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoHotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    NSDictionary *dic = [self.allDataArray objectAtIndex:indexPath.row];
    cell.videoNameLabel.text = [dic objectForKey:@"bname"];
    [cell.videoImageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"imgUrl"]]placeholderImage:[UIImage imageNamed:@"loadingimg.png"]];
    cell.videoLengthLabel.text = [dic objectForKey:@"blength"];
    cell.timeLabel = [dic objectForKey:@"modtime"];
    cell.numberLabel.text = [NSString stringWithFormat:@"%d",(int)indexPath.row+1];
    
//    int i = (int)[self.allDataArray indexOfObject:dic];
    
    
    int i = (int)indexPath.row;
    if (i < 3) {
        cell.numberLabel.textColor = [UIColor redColor];
    }else{
        cell.numberLabel.textColor = [UIColor blackColor];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([TestNet isConnectionAvailable]) {
        
    
    NSDictionary *dic = [self.allDataArray objectAtIndex:indexPath.row];
    CustomWebViewController *customWebViewController = [[CustomWebViewController alloc]init];
    customWebViewController.urlString = [dic objectForKey:@"defaultMobileLink"];
//    [self presentViewController:customWebViewController animated:YES completion:nil];
    [self.navigationController pushViewController:customWebViewController animated:YES];
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
