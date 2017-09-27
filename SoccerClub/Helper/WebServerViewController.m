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

    self.title = @"资讯";
    
    WKWebView* webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.webView = webView;
    self.webView.navigationDelegate = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setWashWeb];
    [self.view addSubview:webView];
    [_webView setAllowsBackForwardNavigationGestures:true];

//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//
//    btn.frame = CGRectMake(20, 30, 50, 30);
////    [btn addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
//    [btn setImage:[UIImage imageNamed:@"goback_back_orange_on.png"] forState:UIControlStateNormal];
//    [self.view addSubview: btn];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"goback_back_orange_on.png"] style:UIBarButtonItemStyleDone target:self action:@selector(Back)];
    // Do any additional setup after loading the view.
}

- (void)Back{
     [_webView goBack];
}


- (void)setWashWeb{
    NSURL* url = [NSURL URLWithString:@"https://m.dszuqiu.com/news"];//创建URL
//    NSURL*url = [NSURL URLWithString:@"https://www.baidu.com"];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [_webView loadRequest:request];//加载
    
    self.mb = [[MBRefresh alloc] initWith];
   
  
}




- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation { // 类似 UIWebView 的 －webViewDidFinishLoad:main-footer
    //    [LZBLoadingView dismissLoadingView];
    [webView evaluateJavaScript:@"document.getElementsByClassName('main-header')[0].style.display = 'none';document.getElementsByClassName('downloadApp')[0].style.display = 'none';document.getElementsByClassName('downloadApp')[0].style.height = 0;document.getElementsByClassName('column column-block')[0].style.display = 'none';document.getElementsByClassName('main-footer')[0].style.display = 'none'" completionHandler:^(id _Nullable nul, NSError * _Nullable error) {
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



@end
