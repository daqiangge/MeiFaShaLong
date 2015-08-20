//
//  LQNewsWebVC.m
//  美发沙龙网
//
//  Created by liqiang on 15/8/8.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQNewsWebVC.h"
#import "LQWebView.h"

@interface LQNewsWebVC ()<UIWebViewDelegate>

@end

@implementation LQNewsWebVC

- (void)setUrlStr:(NSString *)urlStr
{
    _urlStr = urlStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self doLoading];
}

- (void)doLoading
{
    LQWebView *webView = [[LQWebView alloc] init];
    webView.frame = CGRectMake(0, Navigation_Height, LQScreen_Width, LQScreen_Height-Navigation_Height);
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://old.meifashalong.com%@",self.urlStr]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    //去除长按后出现的文本选取框
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
}

@end
