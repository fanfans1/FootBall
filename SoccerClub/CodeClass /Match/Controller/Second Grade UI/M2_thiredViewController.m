
//
//  M2_thiredViewController.m
//  SoccerClub
//
//  Created by GCCC on 16/1/14.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "M2_thiredViewController.h"
#import "CustomSegmentControl.h"
#import "CustomWebViewController.h"
#define FONT [UIFont systemFontOfSize:15]
#define SFONT [UIFont systemFontOfSize:12]
@interface M2_thiredViewController ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,UIScrollViewDelegate>
@property (nonatomic,retain)CustomSegmentControl *custom;

@property (nonatomic,retain)NSMutableDictionary * dic;// 总字典

@property (nonatomic,retain)NSMutableArray * NavArr;

@property (nonatomic,retain)NSMutableArray * nameArr;

@property (nonatomic,retain)UIScrollView *scroll;
@end



@implementation M2_thiredViewController

-(void)btnAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)property{
//    _backImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 64, CGRectGetWidth(self.view.frame)-10, 100)];
//    [self.view addSubview:_backImage];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setImage:[[UIImage imageNamed:@"11.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(5, 20, 50, 50)];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/20, 70, 80, 30)];
    _timeLabel.font = FONT;
    [self.view addSubview:_timeLabel];
    
    _titlLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/5, 70, CGRectGetWidth(self.view.frame)*2/3, 30)];
    _titlLabel.font = FONT;
    [self.view addSubview:_titlLabel];
    
    _projectTitle = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame)-80)/2, 170, 40, 30)];
    _projectTitle.font = FONT;
    [self.view addSubview:_projectTitle];
    
    _PromptLabel =[[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame)-150)/2, 170, 150, 30)];
    _PromptLabel.font = FONT;
    [self.view addSubview:_PromptLabel];
    
    
    _homeInfo = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 120, 30)];
    _homeInfo.font = FONT;
    [self.view addSubview:_homeInfo];
    
    _guestInfo = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)-130, 100, 120, 30)];
    _guestInfo.font = FONT;
    _guestInfo.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_guestInfo];
    
    _homeScore = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/5, 70, 60, 30)];
    [self.view addSubview:_homeScore];
    
    _guestScore = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)-80, 70, 80, 30)];
    [self.view addSubview:_guestScore];
    
    _homeLoge = [[UIImageView alloc] initWithFrame:CGRectMake(25, 70, 30, 30)];
    [self.view addSubview:_homeLoge ];
    
    _guestLoge = [[UIImageView  alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)-50, 70, 30, 30)];
    [self.view addSubview:_guestLoge];
    
    _matchTime = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/3, 80, CGRectGetWidth(self.view.frame)/3, 30)];
    _matchTime.textAlignment = NSTextAlignmentCenter;
    _matchTime.font = SFONT;
    [self.view addSubview:_matchTime];
    
    _leagueDesc = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/3, 50,CGRectGetWidth(self.view.frame)/3, 30)];
    _leagueDesc.textAlignment = NSTextAlignmentCenter;
    _leagueDesc.font = FONT;
    [self.view addSubview:_leagueDesc];
    
    _matchCase = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/3-5, 110, CGRectGetWidth(self.view.frame)/3, 30)];
    _matchCase.textAlignment = NSTextAlignmentCenter;
    _matchCase.font = SFONT;
    [self.view addSubview:_matchCase];}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self property];
//     self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"0.4.png"]];
    
    UINavigationController *navC = [[UINavigationController alloc]init];
    [self addChildViewController:navC];
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://zhiboba.3b2o.com/program/initJson/type/android/sid/%@?1452066637",self.sid]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    if (!data) {
        data = [CacheHelper readCacheWithName:@"M_firstTable"];
        
    }else{
        
    }
    _dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *programDic = [_dic objectForKey:@"program"];

//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 30, CGRectGetWidth(self.view.frame), 40)];
//    view.backgroundColor = [UIColor orangeColor];
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    backBtn.frame = CGRectMake(10, 10, 60, 30);
//    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:backBtn];
//    [self.view addSubview:view];
    
    
    //  移除聊天记录
    NSArray *array = [_dic objectForKey:@"newNavV4"];
    _NavArr = [NSMutableArray arrayWithArray:array];
    for (int i = 0; i < _NavArr.count; i++) {
        for (int i = 0; i < _NavArr.count; i++) {
        if ([[_NavArr[i] objectForKey:@"type"] isEqualToString:@"communication"] || [[_NavArr[i] objectForKey:@"type"] isEqualToString:@"live"] ) {
            [_NavArr removeObject:_NavArr[i]];
        }
        }
//        [_nameArr addObject:[_NavArr[i] objectForKey:@"name"]];
    }
    
    _nameArr = [NSMutableArray array];
    for (NSDictionary *item in _NavArr) {
        [_nameArr addObject:[item objectForKey:@"name"]];
    }
    
    
    _custom = [[CustomSegmentControl alloc] initWithFrame:CGRectMake(0, 150, CGRectGetWidth(self.view.frame), 30)];
    [_custom drawItemWithArr:_nameArr];
    [self.view addSubview:_custom];
    
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 180, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-180)];
    _scroll.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame)*_NavArr.count, 0);
    _scroll.pagingEnabled = YES;
//    _scroll.backgroundColor = [UIColor greenColor];
    _scroll.delegate = self;
    [self.view addSubview:_scroll];
    _scroll.tag = 1010;
    _backImage.image =[UIImage imageNamed:@"Match_backImage.png"];
    
    
    NSArray *homeInfo = [[_dic objectForKey:@"program"] objectForKey:@"hostInfo"];
    if (homeInfo.count) {
        
    _homeInfo.text = [[programDic objectForKey:@"hostInfo"] objectForKey:@"name"];
    NSURL *homeLogeUrl = [NSURL URLWithString:[[programDic objectForKey:@"hostInfo"] objectForKey:@"logo"]];
    [_homeLoge sd_setImageWithURL:homeLogeUrl placeholderImage:[UIImage imageNamed:@"logoPlace.jpg"]];
    _homeScore.text = [[programDic objectForKey:@"hostInfo"] objectForKey:@"score"];
    _guestInfo.text = [[programDic objectForKey:@"guestInfo"] objectForKey:@"name"];
    NSURL *guestLogeUrl = [NSURL URLWithString:[[programDic objectForKey:@"guestInfo"] objectForKey:@"logo"]];
    [_guestLoge sd_setImageWithURL:guestLogeUrl placeholderImage:[UIImage imageNamed:@"logoPlace.jpg"]];
    _guestScore.text = [[programDic objectForKey:@"guestInfo"] objectForKey:@"score"];
    _matchTime.text = [[_dic objectForKey:@"program"]  objectForKey:@"detailtime"];
    _leagueDesc.text =[[_dic objectForKey:@"program"]  objectForKey:@"leagueName"];
    _matchCase.text = @"已结束";
    }else{
        _timeLabel.text = [[_dic objectForKey:@"program"] objectForKey:@"datetime"];
        
        _titlLabel.text = [[_dic objectForKey:@"program"]objectForKey:@"name"];
    }
    
   
    
    for (int i = 0; i < _NavArr.count; i++) {
        if ([[_NavArr[i] objectForKey:@"type"] isEqualToString:@"webview"]) {
            
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)*i, 0,CGRectGetWidth(self.view.frame) , CGRectGetHeight(_scroll.frame))];
            webView.delegate = self;
            NSURL *url = [NSURL URLWithString:[_NavArr[i] objectForKey:@"url"]];
            NSURLRequest *reque = [NSURLRequest requestWithURL:url];
            [webView loadRequest:reque];
           [_scroll addSubview:webView];
        }else{
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)*i,0,CGRectGetWidth(self.view.frame) , CGRectGetHeight(_scroll.frame))];
            tableView.delegate = self;
            tableView.dataSource = self;
            if ([[_NavArr[i] objectForKey:@"type"] isEqualToString:@"highlights"]) {
                tableView.tag = 1000;
            }else if ([[_NavArr[i] objectForKey:@"type"] isEqualToString:@"recording"]){
                tableView.tag = 1001;
                
            }else if ([[_NavArr[i] objectForKey:@"type"] isEqualToString:@"live"]){
                tableView.tag = 1002;
            }
        
            [_scroll addSubview:tableView];
            [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        }
    }
    
    
    //  添加监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notice:) name:@"btnAction" object:nil];
    
    
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 1000) {
        NSArray *highlights = [_dic objectForKey:@"highlights"];
        return highlights.count;
    }else if (tableView.tag == 1001){
        NSArray *recording = [_dic objectForKey:@"recording"];
        return recording.count;
    }else{
        NSArray *live = [_dic objectForKey:@"live"];
        return live.count;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if ((tableView.tag == 1000)&&([[_dic objectForKey:@"highlights"] objectAtIndex:indexPath.row])) {
       cell.textLabel.text = [[[_dic objectForKey:@"highlights"] objectAtIndex:indexPath.row] objectForKey:@"name"];
    }else if (tableView.tag == 1001){
        cell.textLabel.text = [[[_dic objectForKey:@"recording"] objectAtIndex:indexPath.row] objectForKey:@"name"];
    }else{
        cell.textLabel.text = [[[_dic objectForKey:@"live"] objectAtIndex:indexPath.row] objectForKey:@"content"];
    }
    cell.textLabel.numberOfLines = 0;
    
    
    
    
    return cell;
    
}

-(void)backBtn{
//    [self dismissViewControllerAnimated:YES completion:^{}];
    [self.navigationController popViewControllerAnimated:YES];
}



//  scrollView的代理方法  页面 静止
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   
   
    int wid = _scroll.contentOffset.x/self.view.frame.size.width;
    [_custom animationWithIndex:wid];
}


//  监听的回调方法
-(void)notice:(id)sender{
    NSNotification *notice = sender;
    NSString * str = notice.object;
    for (int i = 0; i < _nameArr.count; i++) {
        if ([_nameArr[i] isEqualToString:str]) {
            
            [_scroll setContentOffset:CGPointMake(i*CGRectGetWidth(self.view.frame), 0) animated:YES];
        }
    }

    
    
//    NSNotification *notic = sender;
//    int temp = [notic.object intValue];
//    UIScrollView *view = (UIScrollView *)[self.view viewWithTag:1010];
//    view.contentOffset = CGPointMake(CGRectGetWidth(self.view.frame)*temp, 0);
}




//  点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([TestNet isConnectionAvailable]) {
        
        CustomWebViewController *webView = [[CustomWebViewController alloc] init];
        if (tableView.tag == 1000) {
            NSMutableArray *array = [_dic objectForKey:@"highlights"];
            webView.urlString  = [[array objectAtIndex:indexPath.row] objectForKey:@"defaultMobileLink"];
            [self presentViewController:webView animated:YES completion:^{
                //
            }];
        }else if (tableView.tag == 1001){
            NSMutableArray *array = [_dic objectForKey:@"recording"];
            webView.urlString  = [[array objectAtIndex:indexPath.row] objectForKey:@"defaultMobileLink"];
            [self presentViewController:webView animated:YES completion:^{
                //
            }];
        }else{
            
        }
    }
 
    
}

//  返回单元格的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
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
