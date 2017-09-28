//
//  M2_fourthViewController.m
//  SoccerClub
//
//  Created by GCCC on 16/1/13.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "M2_fourthViewController.h"

@interface M2_fourthViewController ()<UIWebViewDelegate>
@property (nonatomic,retain)UIWebView * webView;

@end

@implementation M2_fourthViewController{
    MBRefresh *mb;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds) ,CGRectGetHeight([UIScreen mainScreen].bounds)-64)];
    
    
    _webView.delegate = self;
    NSString *webString = [_receiveDic objectForKey:@"url"];
    NSURLRequest *requst = [NSURLRequest requestWithURL:[NSURL URLWithString:webString]];
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.bouncesZoom = NO;
    [self.webView loadRequest:requst];
    [self.view addSubview:_webView];
    mb = [[MBRefresh alloc] initWith];
}



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [mb remove];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [mb remove];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('main-nav-wrap')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('mod-nav sub-nav')[0].style.display = 'none'"]; // MAC广告
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('index_view_navigator').style.display = 'none'"];
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('BAIDU_EXP_MOB__wrapper_u2363177_0').style.display = 'none'"];
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('commentArea')[0].style.display = 'none'"];
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('footer')[0].style.display = 'none'"];
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('STRONG')[0].innerText = ''"];
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('pos')[0].style.display = 'none'"];
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('banner')[0].style.display = 'none'"];
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('zbb_path').style.display = 'none'"];
}

-(void)backAction{
    [mb remove];
    [self.navigationController popViewControllerAnimated:YES];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
