//
//  KongViewController.m
//  SoccerClub
//
//  Created by xalo on 16/1/14.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "KongViewController.h"

#import "MBRefresh.h"
@interface KongViewController ()<UIWebViewDelegate>

@property (nonatomic, strong)MBRefresh *mb;
@end

@implementation KongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.navigationController) {
        
        UIButton *Btn = [UIButton buttonWithType:UIButtonTypeSystem];
        Btn.frame = CGRectMake(5, 22, 60, 40);
        [Btn setTitle:@"返回" forState:UIControlStateNormal];
        [Btn addTarget:self action:@selector(leftBtnItem) forControlEvents:UIControlEventTouchUpInside];
        Btn.titleLabel.font = [UIFont systemFontOfSize:20];
        //    [self.view addSubview:Btn];
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64)];
        headerView.backgroundColor = BACKGROUNDCOLOR;
        [headerView addSubview:Btn];
        [self.view addSubview:headerView];
    }else{
        self.mb = [[MBRefresh alloc] initWith];
    }
    // 使用web承接HTML
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
    // 将请求放入子线程中
    NSURL *url = [NSURL URLWithString:self.str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    webView.scrollView.bounces = NO;
    webView.scrollView.bouncesZoom = NO;
    [webView loadRequest:request];
    webView.delegate = self;
    webView.scrollView.bouncesZoom = NO;
    [self.view addSubview:webView];
        // 回主线程
    
}



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
     [self.mb remove];
}

- (void)viewWillAppear:(BOOL)animated{
    if (self.navigationController) {
        self.tabBarController.tabBar.hidden = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    if (self.navigationController) {
        self.tabBarController.tabBar.hidden = NO;
    }
}

// 去除广告  
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.mb remove];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('header').style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('banner').style.display = 'none'"]; // MAC广告
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('index_view_navigator').style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('BAIDU_EXP_MOB__wrapper_u2363177_0').style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('commentArea')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('footer')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('STRONG')[0].innerText = ''"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('pos')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('banner')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('zbb_path').style.display = 'none'"];
}
-(void)leftBtnItem{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 // 创建边缘轻扫手势
-(void)screenEdgePan{
    UIScreenEdgePanGestureRecognizer *screenEdgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(leftBtnItem)];
    screenEdgePan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:screenEdgePan];
     [self.mb remove];
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
