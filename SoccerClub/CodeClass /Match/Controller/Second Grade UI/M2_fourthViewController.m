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

@implementation M2_fourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds) ,CGRectGetHeight([UIScreen mainScreen].bounds)-64)];
    
    _webView.delegate = self;
    NSString *webString = [_receiveDic objectForKey:@"url"];
    NSURLRequest *requst = [NSURLRequest requestWithURL:[NSURL URLWithString:webString]];
    
    [self.webView loadRequest:requst];
    [self.view addSubview:_webView];
    
}

-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
