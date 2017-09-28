//
//  NewsViewController.m
//  SoccerClub
//
//  Created by Guang shen on 2017/9/28.
//  Copyright © 2017年 程龙. All rights reserved.
//

#import "NewsViewController.h"
#import "NewModel.h"
#import "NewTableViewCell.h"



@interface NewsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain)UITableView *tableView;
 
@property (nonatomic, retain)NSMutableArray *marr;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资讯";
      [self.navigationController.navigationBar setBarTintColor: BACKGROUNDCOLOR];
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStyleDone target:self action:@selector(login)];
    self.marr = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"NewTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview: self.tableView];
    [self getMassage];
    [self renovateAndEvenMany];
    // Do any additional setup after loading the view.
}

- (void)login{
    MMZCViewController *login = [[MMZCViewController alloc] init];
    [self.navigationController pushViewController:login animated:YES];
}


-(void)renovateAndEvenMany{
    
    
    
    // 1、使用系统默认的刷新提示
    __block NewsViewController *vc = self;
    
    // 添加下拉刷新
    [self.tableView addHeaderWithCallback:^{
        [TestNet isConnectionAvailable];   // 判断网络
     
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            
            // 当请求到图片的时候，回主线程为cell添加照片
            dispatch_async(dispatch_get_main_queue(), ^{
                [vc getMassage];
         
                
            });
        });
        // 结束刷新
        [vc.tableView headerEndRefreshing];
        //        NSLog(@"结束刷新");
    }];
    
    // 添加上拉加载
    [self.tableView addFooterWithCallback:^{
        [TestNet isConnectionAvailable];
     
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            
            // 当请求到图片的时候，回主线程为cell添加照片
            dispatch_async(dispatch_get_main_queue(), ^{
                [vc getLoad];
                
            });
        });
        
        // 结束刷新
        [vc.tableView footerEndRefreshing];
        //        NSLog(@"结束刷新");
    }];
    
}

- (void)getMassage{
    NSString *url = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/article/listJson/category/soccer?1452072425"];
    [MJPush getWithURLString: url parameters:nil success:^(NSDictionary *dictionary) {
        [self.marr removeAllObjects];
        NSArray *arr = [NSArray arrayWithArray:[dictionary objectForKey:@"articles"]];
        for (NSDictionary *dic in arr) {
            NewModel *model = [NewModel setModelWithDictionary:dic];
            [self.marr addObject: model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
       
            [self.tableView reloadData];
        });
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)getLoad{
    if (self.marr.count ==0) {
        return;
    }
    NewModel *model =[self.marr lastObject];
    NSString *url = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/article/listJson/modtime/%@/category/soccer?1452924168", model.modtime ];
    [MJPush getWithURLString: url parameters:nil success:^(NSDictionary *dictionary) {
        
//        [self.marr addObjectsFromArray: [dictionary objectForKey:@"articles"] ];
        NSArray *arr = [NSArray arrayWithArray:[dictionary objectForKey:@"articles"]];
        for (NSDictionary *dic in arr) {
            NewModel *model = [NewModel setModelWithDictionary:dic];
            [self.marr addObject: model];
        }
//        [self.tableView reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WebServerViewController *web = [[WebServerViewController alloc] init];
     NewModel *model = self.marr [indexPath.row];
    web.url = model.origin_url;
    [self.navigationController pushViewController:web animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NewModel *model = self.marr [indexPath.row];
    NSString *str = [NSString stringWithFormat:@"http://in.3b2o.com/img/show/sid/%@/w//h//t/1/show.jpg",model.thumb_id];
    [cell.pic sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"loadingimg.png"]];
    cell.pic.layer.masksToBounds = YES;
    cell.pic.layer.cornerRadius = 5;
    cell.title.text = model.title;
    cell.title.numberOfLines = 0;
    cell.time.text = model.pubtime;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.marr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
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
