//
//  WebServerViewController.h
//  Foods
//
//  Created by yy on 2017/1/4.
//  Copyright © 2017年 fanfan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface WebServerViewController : UIViewController<WKNavigationDelegate>

@property (nonatomic, retain) WKWebView* webView;
@property (nonatomic, retain)NSString *url;

@end


