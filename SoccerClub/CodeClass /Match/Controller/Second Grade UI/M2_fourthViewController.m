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

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [mb remove];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [mb remove];
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
