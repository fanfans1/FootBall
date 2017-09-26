//
//  WebServerViewController.m
//  Foods
//
//  Created by yy on 2017/1/4.
//  Copyright © 2017年 fanfan. All rights reserved.
//

#import "WebServerViewController.h"
#import "MBRefresh.h"


@interface WebServerViewController ()<UIWebViewDelegate>

@property (nonatomic, strong)MBRefresh *mb;

@end

@implementation WebServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"资讯";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 使用web承接HTML
    UIWebView *mywebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
    //
    NSURL *url = [NSURL URLWithString:@"https://m.dszuqiu.com/news"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [mywebView loadRequest:request];
    
    
    //  网页适配高度
//    CGSize contentSize = mywebView.scrollView.contentSize;
//    CGSize viewSize = self.view.bounds.size;
//    float rw = viewSize.width / contentSize.width;
//    mywebView.scrollView.minimumZoomScale = rw;
//    mywebView.scrollView.maximumZoomScale = rw;
//    mywebView.scrollView.zoomScale = rw;
    
//
    mywebView.delegate = self;
    [self.view addSubview:mywebView];
    
    self.mb = [[MBRefresh alloc] initWith];
}


// 去除广告
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self.mb remove];
    
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
    
}





- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation { // 类似 UIWebView 的 －webViewDidFinishLoad:
    //    [LZBLoadingView dismissLoadingView];
    
    
}



#pragma mark -没搞懂小范想干嘛

//- (void)viewWillAppear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden = YES;
//    [super viewWillAppear:YES];
//}
//
//
//- (void)jingshikuang:(NSString *)sender{//封装了一个警示框可以重复调用
//
//    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:sender preferredStyle:UIAlertControllerStyleAlert];
//    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    [tempAppDelegate.window.rootViewController presentViewController:alertC animated:YES completion:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [alertC dismissViewControllerAnimated:YES completion:nil];
//        });
//    }];
//}


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
