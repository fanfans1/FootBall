//
//  KongViewController.m
//  SoccerClub
//
//  Created by xalo on 16/1/14.
//  Copyright © 2016年 程龙. All rights reserved.
//

#import "WebServerViewController.h"

@interface WebServerViewController ()<UIWebViewDelegate>

@end

@implementation WebServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 使用web承接HTML
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
    // 将请求放入子线程中
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSURL *url = [NSURL URLWithString:@""];
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
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('head')[0].style.display = 'none'"];
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

