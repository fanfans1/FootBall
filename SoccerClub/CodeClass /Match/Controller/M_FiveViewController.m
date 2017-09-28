//
//  M_FiveViewController.m
//  SoccerClub
//
//  Created by Guang shen on 2017/9/28.
//  Copyright © 2017年 程龙. All rights reserved.
//

#import "M_FiveViewController.h"

@interface M_FiveViewController ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain)UIWebView * webView;
@property (nonatomic, retain)UITableView *tableView;
@end

@implementation M_FiveViewController{
    MBRefresh *mb;
}

// 下拉刷新 上拉加载
-(void)renovateAndEvenMany{
    // 1、使用系统默认的刷新提示
    __block M_FiveViewController *vc = self;
    
    // 添加下拉刷新
    [self.tableView addHeaderWithCallback:^{
//        [TestNet isConnectionAvailable];   // 判断网络
      
        // 将请求放入子线程中
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // 当请求到图片的时候，回主线程为cell添加照片
            dispatch_async(dispatch_get_main_queue(), ^{
                    [vc refresh];
                // 数据重载
//                [vc.tableView reloadData];
                
            });
        });
        // 结束刷新
        [vc.tableView headerEndRefreshing];
        //        NSLog(@"结束刷新");
    }];
    
   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, ScreenHeight - 64 - 49 - 30)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview: self.tableView];
    [self renovateAndEvenMany];
  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.bounds.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , ScreenHeight - 64 - 49 - 30)];
    _webView.delegate = self;
   
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.bouncesZoom = NO;
  
   
    [cell.contentView addSubview:_webView];
    [self refresh];
    mb = [[MBRefresh alloc] initWith];
    return cell;
}


- (void)refresh{
     NSURLRequest *requst = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
      [self.webView loadRequest:requst];
    _webView.hidden = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [mb remove];
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if (!_webView.hidden) {
        mb = [[MBRefresh alloc] initWith];
    }
    _webView.hidden = YES;
    
    return YES;
}



-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('main-nav-wrap')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('mod-nav sub-nav')[0].style.display = 'none'"]; // MAC广告
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('J-nav-wrap').style.display = 'none'"];
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('BAIDU_EXP_MOB__wrapper_u2363177_0').style.display = 'none'"];
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('commentArea')[0].style.display = 'none'"];
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('footer')[0].style.display = 'none'"];
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('STRONG')[0].innerText = ''"];
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('pos')[0].style.display = 'none'"];
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('banner')[0].style.display = 'none'"];
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('zbb_path').style.display = 'none'"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [mb remove];
        _webView.hidden = NO;
        
    });
}

-(void)backAction{
    [mb remove];
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
