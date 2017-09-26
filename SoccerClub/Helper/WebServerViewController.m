//
//  WebServerViewController.m
//  Foods
//
//  Created by yy on 2017/1/4.
//  Copyright © 2017年 fanfan. All rights reserved.
//

#import "WebServerViewController.h"
#import "MBRefresh.h"


@interface WebServerViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong)MBRefresh *mb;

@end

@implementation WebServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    
    // Do any additional setup after loading the view.
    WKWebView* webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.webView = webView;
    self.webView.navigationDelegate = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scollview=(UIScrollView *)[[_webView subviews]objectAtIndex:0];
    scollview.showsVerticalScrollIndicator = NO;
    scollview.bounces=NO;
    
    [self setWashWeb];
    [self.view addSubview:webView];
    
    // Do any additional setup after loading the view.
}


- (void)setWashWeb{
    NSURL* url = [NSURL URLWithString:@"https://m.dszuqiu.com/news"];//创建URL
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [_webView loadRequest:request];//加载
    
    self.mb = [[MBRefresh alloc] initWith];
//    self.webView.hidden = YES;
}




- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation { // 类似 UIWebView 的 －webViewDidFinishLoad:main-footer
    //    [LZBLoadingView dismissLoadingView];
    [webView evaluateJavaScript:@"document.getElementsByClassName('downloadApp')[0].style.display = 'none';document.getElementsByClassName('column column-block')[0].style.display = 'none';document.getElementsByClassName('main-footer')[0].style.display = 'none'" completionHandler:^(id _Nullable nul, NSError * _Nullable error) {
//        self.webView.hidden = NO;
    }];
    [self.mb remove];
}



- (void)viewWillAppear:(BOOL)animated{
  
    [super viewWillAppear:YES];
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
