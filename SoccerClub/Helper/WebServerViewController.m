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
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBarTintColor: BACKGROUNDCOLOR];
    self.title = @"资讯";
    
    WKWebView* webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 48)];
    self.webView = webView;
    self.webView.navigationDelegate = self;
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.bouncesZoom = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setWashWeb];
    [self.view addSubview:webView];
    [_webView setAllowsBackForwardNavigationGestures:true];
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(Back)];
    
   
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 48, ScreenWidth, 48)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    btn.frame = CGRectMake(ScreenWidth/3 - 30, 8, 30, 30);
    [btn setImage:[UIImage imageNamed:@"webBack.png"]  forState:UIControlStateNormal];
//    btn.backgroundColor = BACKGROUNDCOLOR;'
    [btn addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview: btn];
    
    btn1.frame = CGRectMake(ScreenWidth/2 - 15, 8, 30, 30);
    [btn1 setImage:[UIImage imageNamed:@"webRefresh.png"] forState:UIControlStateNormal];
    [view addSubview: btn1];
//    btn1.backgroundColor = BACKGROUNDCOLOR;
    [btn1 addTarget:self action:@selector(setWashWeb) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    btn2.frame = CGRectMake(ScreenWidth*2/3 , 8, 30, 30);
    [btn2 setImage:[UIImage imageNamed:@"webGo.png"] forState:UIControlStateNormal];
    //    btn1.backgroundColor = BACKGROUNDCOLOR;
    [btn2 addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview: btn2];
    
    [self.view addSubview:view];
    
    _webView.hidden = YES;
    // Do any additional setup after loading the view.
}

- (void)Back{
    [_webView goBack];
}

- (void)go{
    [_webView goForward];
}



- (void)setWashWeb{
    NSURL* url = [NSURL URLWithString:self.url];//创建URL
    //    NSURL*url = [NSURL URLWithString:@"https://www.baidu.com"];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [_webView loadRequest:request];//加载
    
    self.mb = [[MBRefresh alloc] initWith];
    
    
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [self.mb remove];
    _webView.hidden = NO;
}



- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation { // 类似 UIWebView 的 －
        [webView evaluateJavaScript:
         @"document.getElementsByTagName(\"div\")[0].style.display = 'none';document.getElementsByTagName(\"div\")[1].style.display = 'none';document.getElementsByTagName(\"div\")[2].style.display = 'none';document.getElementsByClassName('footer')[0].style.display = 'none';document.getElementById('top_android').style.display = 'none';document.getElementsByClassName('commentArea')[0].style.display = 'none';document.getElementById('comment_list').style.display = 'none';document.getElementsByClassName('article_feedback')[0].style.display = 'none'" completionHandler:^(id _Nullable nul, NSError * _Nullable error) {

        }];
    [self.mb remove];
    _webView.hidden = NO;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
}

 





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

