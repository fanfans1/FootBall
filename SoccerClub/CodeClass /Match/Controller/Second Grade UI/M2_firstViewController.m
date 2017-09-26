//
//  M2_firstViewController.m
//  SoccerClub
//
//  Created by GCCC on 16/1/13.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "M2_firstViewController.h"
#import "CustomWebViewController.h"
#define FONT [UIFont systemFontOfSize:15]
#define SFONT [UIFont systemFontOfSize:12]

@interface M2_firstViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)NSMutableArray *array;
@property (nonatomic,retain)NSDictionary *dic ;
@property (nonatomic,retain)NSMutableArray * Nav;// 用于剔除聊天和
@property (nonatomic,retain)NSMutableArray * programArr;
@end

@implementation M2_firstViewController
-(void)property{
    _backImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 80, CGRectGetWidth(self.view.frame)-10, 100)];
    [self.view addSubview:_backImage];
    
    
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/20, 100, 80, 30)];
    _timeLabel.font = FONT;
    [self.view addSubview:_timeLabel];
    
    _titlLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/5, 100, CGRectGetWidth(self.view.frame)*2/3, 30)];
    _titlLabel.font = FONT;
    [self.view addSubview:_titlLabel];
    
    _projectTitle = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame)-80)/2, 200, 40, 30)];
    _projectTitle.font = FONT;
    [self.view addSubview:_projectTitle];
    
    _PromptLabel =[[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame)-150)/2, 200, 150, 30)];
    _PromptLabel.font = FONT;
    [self.view addSubview:_PromptLabel];
    
    
    _homeInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, 120, 30)];
    _homeInfo.font = FONT;
    [self.view addSubview:_homeInfo];
    
    _guestInfo = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)-130, 130, 120, 30)];
    _guestInfo.font = FONT;
    _guestInfo.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_guestInfo];
    
    _homeScore = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/5, 100, 60, 30)];
    [self.view addSubview:_homeScore];
    
    _guestScore = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)-80, 100, 80, 30)];
    [self.view addSubview:_guestScore];
    
    _homeLoge = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 30, 30)];
    [self.view addSubview:_homeLoge];
    
    _guestLoge = [[UIImageView  alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)-50, 100, 30, 30)];
    [self.view addSubview:_guestLoge];
    
    _matchTime = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/3, 110, CGRectGetWidth(self.view.frame)/3, 30)];
    _matchTime.textAlignment = NSTextAlignmentCenter;
    _matchTime.font = SFONT;
    [self.view addSubview:_matchTime];
    
    _leagueDesc = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/3, 80,CGRectGetWidth(self.view.frame)/3, 30)];
    _leagueDesc.textAlignment = NSTextAlignmentCenter;
    _leagueDesc.font = FONT;
    [self.view addSubview:_leagueDesc];
    
    _matchCase = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/3-5, 140, CGRectGetWidth(self.view.frame)/3, 30)];
    _matchCase.textAlignment = NSTextAlignmentCenter;
    _matchCase.font = SFONT;
    [self.view addSubview:_matchCase];
    
   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self property];
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];

    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 240, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-240-49)];
//    scroll.backgroundColor = [UIColor redColor];
    [self.view addSubview:scroll];
    
    UINavigationController *navC = [[UINavigationController alloc]init];
    [self addChildViewController:navC];

    
    NSMutableArray *array = [_dic objectForKey:@"newNavV4"];
    _Nav = [NSMutableArray arrayWithArray:array];
    for (int i = 0; i < _Nav.count; i++) {
        if ([[_Nav[i] objectForKey:@"type"]isEqualToString:@"communication"]) {
            [_Nav removeObject:_Nav[i]];
        }
    }
    NSString *urlString = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/program/initJson/type/android/sid/%@?1453521021",self.sid];
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    if (!data) {
        data = [CacheHelper readCacheWithName:@"M_firstTable"];
    }else{
        
    }
    _dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

//    //  解析每日福利中的电影接口
//    _array = [_dic objectForKey:@"highlights"];
//    _programArr = [_dic objectForKey:@"program"];
//    _backImage.image =[UIImage imageNamed:@"Match_backImage.png"];
    
    
    if ([[[_dic objectForKey:@"program"] objectForKey:@"hostInfo"]isKindOfClass:[NSArray class]]) {
        if ([[[_dic objectForKey:@"program"] objectForKey:@"name"] isEqualToString:@"每日福利"]) {
           _projectTitle.text = @"福利";
        }
//        self.projectTitle.text = @"福利";
        self.titlLabel.text = [[_dic objectForKey:@"program"] objectForKey:@"name"];
        self.timeLabel.text = [[_dic objectForKey:@"program"] objectForKey:@"datetime"];
        NSDictionary *dic = [_dic objectForKey:@"nav"];
        BOOL tvs = (BOOL)[dic objectForKey:@"tvs"];
        
        if (tvs ) {
            self.matchCase.text = self.match;
            
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 180, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-150)];
            //    tableView.backgroundColor = [UIColor greenColor];
            
            tableView.delegate = self;
            tableView.dataSource = self;
            [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
            [self.view addSubview:tableView];
        }else{
            self.matchCase.text = @"未开始";
        }

    }else{
        self.homeInfo.text = [[[_dic objectForKey:@"program"] objectForKey:@"hostInfo"] objectForKey:@"name"];
        self.guestInfo.text = [[[_dic objectForKey:@"program"] objectForKey:@"guestInfo"] objectForKey:@"name"];
        NSURL *url = [NSURL URLWithString:[[[_dic objectForKey:@"program"] objectForKey:@"hostInfo"] objectForKey:@"logo"]];
        [self.homeLoge sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"logoPlace.jpg"]];
        NSURL *url1 = [NSURL URLWithString:[[[_dic objectForKey:@"program"] objectForKey:@"guestInfo"] objectForKey:@"logo"]];
        [self.guestLoge sd_setImageWithURL:url1 placeholderImage:[UIImage imageNamed:@"logoPlace.jpg"]];
        self.guestScore.text = [[[_dic objectForKey:@"program"]objectForKey:@"hostInfo"] objectForKey:@"score"];
        self.homeScore.text = [[[_dic objectForKey:@"program"] objectForKey:@"guestInfo"] objectForKey:@"score"];
        self.matchTime.text = [[_dic objectForKey:@"program"]  objectForKey:@"detailtime"];
        self.leagueDesc.text =[[_dic objectForKey:@"program"]  objectForKey:@"leagueName"];
        
        NSDictionary *dic = [_dic objectForKey:@"nav"];
        BOOL tvs = (BOOL)[dic objectForKey:@"tvs"];
        
        if (tvs ) {
            self.matchCase.text = self.match;
            
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 180, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-150)];
            //    tableView.backgroundColor = [UIColor greenColor];
            
            tableView.delegate = self;
            tableView.dataSource = self;
            [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
            [self.view addSubview:tableView];
        }else{
            self.matchCase.text = @"未开始";
        }
        
    }
    
    NSMutableArray *tempArr = [_dic objectForKey:@"highlights"];
    //  添加tableView
    if (tempArr.count) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-240-49)];
        //    tableView.backgroundColor = [UIColor greenColor];
        
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
        [scroll addSubview:tableView];
        
    }else{
        _PromptLabel.text = @"暂时没有比赛数据";
    }
}

-(void)backBtn{
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = [_dic objectForKey:@"tvsV3"];
    if (array.count) {
        return array.count;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSArray *array = [_dic objectForKey:@"tvsV3"];
    cell.textLabel.text = [[array objectAtIndex:indexPath.row] objectForKey:@"name"];
    return cell;
}


//  点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([TestNet isConnectionAvailable]) {
        
        CustomWebViewController *webView = [[CustomWebViewController alloc] init];
        NSArray *array = [_dic objectForKey:@"tvsV3"];
        webView.urlString  = [[[array objectAtIndex:indexPath.row] objectForKey:@"link"] objectForKey:@"url"];
        [self.navigationController pushViewController:webView animated:YES];
    }
  
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
