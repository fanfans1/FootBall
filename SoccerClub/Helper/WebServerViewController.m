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
    
    self.title = @"资讯";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 使用web承接HTML
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
    //
    NSURL *url = [NSURL URLWithString:@"https://m.dszuqiu.com/news"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    
    //  网页适配高度
    CGSize contentSize = webView.scrollView.contentSize;
    CGSize viewSize = self.view.bounds.size;
    
    float rw = viewSize.width / contentSize.width;
    
    webView.scrollView.minimumZoomScale = rw;
    webView.scrollView.maximumZoomScale = rw;
    webView.scrollView.zoomScale = rw;
    
    webView.delegate = self;
    [self.view addSubview:webView];
    
    
    
}


// 去除广告
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    //杰哥去广告
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('.downloadApp').style.display = 'none'"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('ntes_nav_wrap ntes-nav-wrap-resize1024')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('N-nav-channel JS_NTES_LOG_FE')[0].style.display = 'none'"]; // MAC广告
     [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('channel')[0].style.display = 'none'"]; // MAC广告
     [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('area topad channel_relative_2016')[0].style.display = 'none'"]; // MAC广告
     [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('left_part')[0].style.display = 'none'"]; // MAC广告
     [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('right_part')[0].style.display = 'none'"]; // MAC广告
     [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('top_news_focus')[0].style.display = 'none'"]; // MAC广告
     [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('topnews_block')[0].style.display = 'none'"]; // MAC广告
     [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('topnews_block')[1].style.display = 'none'"]; // MAC广告
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('topnews_block')[2].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('topnews_block')[3].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('topnews_block')[4].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('foot_execute_leader area')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('h70')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('footerbg')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('banner')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('N-nav-bottom')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('area bottomad channel_relative_2016')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('bottomnews_focus')[0].style.display = 'none'"];
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('banner')[0].style.display = 'none'"];
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('zbb_path').style.display = 'none'"];
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

