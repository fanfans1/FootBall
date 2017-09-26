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
    
    
    

    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftButton.frame = CGRectMake(20, 20, 50, 30);
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds) ,CGRectGetHeight([UIScreen mainScreen].bounds)-64)];
    
    _webView.delegate = self;
    NSString *webString = [_receiveDic objectForKey:@"url"];
    NSURLRequest *requst = [NSURLRequest requestWithURL:[NSURL URLWithString:webString]];
    
    [self.webView loadRequest:requst];
    [self.view addSubview:_webView];
    
}

-(void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
    
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
