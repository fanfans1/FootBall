//
//  KongViewController.m
//  SoccerClub
//
//  Created by xalo on 16/1/14.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "KongViewController.h"

@interface KongViewController ()<UIWebViewDelegate>

@end

@implementation KongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeSystem];
    Btn.frame = CGRectMake(5, 22, 40, 40);
    [Btn setTitle:@"返回" forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(leftBtnItem) forControlEvents:UIControlEventTouchUpInside];
    Btn.titleLabel.font = [UIFont systemFontOfSize:20];
//    [self.view addSubview:Btn];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64)];
    headerView.backgroundColor = [UIColor colorWithRed:199/255.0 green:21/255.0 blue:133/255.0 alpha:1.0];
    [headerView addSubview:Btn];
    [self.view addSubview:headerView];
    //     拼接
    //    NSString *string = [NSString stringWithFormat:@"http://www.zhiboba.com/article/show/%@",self.str];
    
    //    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    //    [tapGR setNumberOfTapsRequired:2];
    //    [tapGR setNumberOfTouchesRequired:1];
    //    self.view.userInteractionEnabled = YES;
    //    [self.view addGestureRecognizer:tapGR];
    
    
    
    // 使用web承接HTML
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
    // 将请求放入子线程中
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSURL *url = [NSURL URLWithString:self.str];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
        
        // 回主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            webView.delegate = self;
            [self.view addSubview:webView];
        });
    });
    
}

//-(void)tapAction{
//    []
//}

// 去除广告  
-(void)webViewDidFinishLoad:(UIWebView *)webView{
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
