//
//  First_4TableViewController.m
//  SoccerClub
//
//  Created by xalo on 16/1/13.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "First_4TableViewController.h"
#import "first_4tableViewcell.h"
//#import "UIImageView+WebCache.h"
#import "RealizeFirst_4ViewController.h"
//#import "MJRefresh.h"  // 下拉刷新
@interface First_4TableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain) NSMutableArray *mutableArr;
@property (nonatomic,retain) NSData *data;  // 更新数据用
@end

@implementation First_4TableViewController

// 下拉刷新 上拉加载
-(void)renovateAndEvenMany{
    // 1、使用系统默认的刷新提示
    __block First_4TableViewController *vc = self;
    
    // 添加下拉刷新
    [self.tableView addHeaderWithCallback:^{
        [TestNet isConnectionAvailable];
        NSString *stringUrl = @"http://zhiboba.3b2o.com/photoIndex/listjson/category/soccer?1452147398";
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSURL *url = [NSURL URLWithString:stringUrl];
            _data = [NSData dataWithContentsOfURL:url];
            if (vc.data) {
                [CacheHelper writeCacheWithData:vc.data name:@"First_4TableViewController"];
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
        [TestNet isConnectionAvailable];
        NSString *stringUrl = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/photoIndex/listjson/modtime/%@/category/soccer?1452926070",[[vc.mutableArr lastObject] objectForKey:@"modtime"]];
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            NSURL *url = [NSURL URLWithString:stringUrl];
            _data = [NSData dataWithContentsOfURL:url];
            if (vc.data) {
                [CacheHelper writeCacheWithData:vc.data name:@"First_4TableViewController"];
                NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:vc.data options:NSJSONReadingAllowFragments error:nil];
                for (NSDictionary *item in [receiveDic objectForKey:@"album"]) {
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
    for (NSDictionary *item in [receiveDic objectForKey:@"album"]) {
        [_mutableArr addObject:item];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 上下拉取
    [self renovateAndEvenMany];
    // 解析
    NSString *str = @"http://zhiboba.3b2o.com/photoIndex/listjson/category/soccer?1452147398";
    NSURL *url = [NSURL URLWithString:str];
    _data = [NSData dataWithContentsOfURL:url];
    if (self.data) {
        [CacheHelper writeCacheWithData:self.data name:@"First_4TableViewController"];
        [self jiexi];
    }else{
        _data = [CacheHelper readCacheWithName:@"First_4TableViewController"];
        [self jiexi];
    }
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 255;
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
   
    //指定cellIdentifier为自定义cell
    static NSString *cellIdentifier = @"cell";
    // 自定义cell类
    First_4TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"First_4TableViewCell" owner:nil options:nil]firstObject];
    }
    cell.imagi.image = [UIImage imageNamed:@"Placegolder.png"];
    // 将请求放入子线程中
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 当请求到图片的时候，回主线程为cell添加照片
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[_mutableArr objectAtIndex:indexPath.row] objectForKey:@"firstImg"]]]];
            CGSize size = CGSizeMake(CGRectGetWidth(self.view.frame)-20, 200);
            UIImage *myImage = [self cutImage:image rect:size];
            
            [cell.imagi setImage:myImage];
        });
    });
    
    
    
//    [cell.imagi sd_setImageWithURL:[NSURL URLWithString:[[_mutableArr objectAtIndex:indexPath.row] objectForKey:@"firstImg"]]];
    cell.labell.text = [[_mutableArr objectAtIndex:indexPath.row] objectForKey:@"bname"];
 
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([TestNet isConnectionAvailable]) {
        
    RealizeFirst_4ViewController *realizeFirst_4 = [[RealizeFirst_4ViewController alloc]init];
    realizeFirst_4.str = [[_mutableArr objectAtIndex:indexPath.row] objectForKey:@"sid"];
    [self presentViewController:realizeFirst_4 animated:YES completion:nil];
//    [self.navigationController pushViewController:realizeFirst_4 animated:YES];
    }
    
}

//裁剪图片
- (UIImage *)cutImage:(UIImage*)image
                 rect:(CGSize)size;
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < (size.width / size.height)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * size.height / size.width;
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * size.width / size.height;
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
    }
    return [UIImage imageWithCGImage:imageRef];
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
