//
//  CustomWebViewController.m
//  SoccerClub
//
//  Created by xalo on 16/1/12.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "CustomWebViewController.h"


@interface CustomWebViewController ()<UIWebViewDelegate>

@end

@implementation CustomWebViewController{
    MBRefresh *mb;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64)];
//    view.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:view];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(10, 25, 45, 35);
    
//    [btn setImage:[[UIImage imageNamed:@"0.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 65, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-44)];
    webView.delegate = self;
    NSURL *url = [NSURL URLWithString:self.urlString];
    webView.scrollView.bounces = NO;
    webView.scrollView.bouncesZoom = NO;
    // 将请求放入子线程中
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 当请求到图片的时候，回主线程为cell添加照片
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [webView loadRequest:request];
           [self.view addSubview:webView];
        });
    });
    
    
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    [webView addGestureRecognizer:panGR];
    mb = [[MBRefresh alloc] initWith];
}
// 边缘清扫
- (void)panAction:(UIPanGestureRecognizer *)sender{
    [mb remove];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backAction{
        [mb remove];
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
// 去除广告  暂时没有实现
-(void)webViewDidFinishLoad:(UIWebView *)webView{
        [mb remove];
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
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('main-nav-wrap')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('mod-nav sub-nav')[0].style.display = 'none'"]; 
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
        [mb remove];
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
