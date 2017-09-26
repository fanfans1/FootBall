//
//  WebServerViewController.m
//  Foods
//
//  Created by yy on 2017/1/4.
//  Copyright © 2017年 fanfan. All rights reserved.
//

#import "WebServerViewController.h"
#import "MBRefresh.h"


@interface WebServerViewController ()

@property (nonatomic, strong)MBRefresh *mb;

@end

@implementation WebServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WKWebView* webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    
    [self.view addSubview:webView];
    self.webView = webView;
    self.webView.navigationDelegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scollview=(UIScrollView *)[[_webView subviews]objectAtIndex:0];
    scollview.showsVerticalScrollIndicator = NO;
    scollview.bounces=NO;
    
    [self setWashWeb];
    
    // Do any additional setup after loading the view.
}


- (void)setWashWeb{
    NSURL* url = [NSURL URLWithString:self.url];//创建URL
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [_webView loadRequest:request];//加载
    
    self.mb = [[MBRefresh alloc] initWith];
}





- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation { // 类似 UIWebView 的 －webViewDidFinishLoad:
    //    [LZBLoadingView dismissLoadingView];
    
    [self.mb remove];
}



- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    [super viewWillAppear:YES];
}


- (void)jingshikuang:(NSString *)sender{//封装了一个警示框可以重复调用
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:sender preferredStyle:UIAlertControllerStyleAlert];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.window.rootViewController presentViewController:alertC animated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertC dismissViewControllerAnimated:YES completion:nil];
        });
    }];
    
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
