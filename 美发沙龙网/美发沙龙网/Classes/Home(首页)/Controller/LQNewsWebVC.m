//
//  LQNewsWebVC.m
//  美发沙龙网
//
//  Created by liqiang on 15/8/8.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQNewsWebVC.h"

@interface LQNewsWebVC ()

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
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = CGRectMake(0, Navigation_Height, LQScreen_Width, LQScreen_Height-Navigation_Height);
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://old.meifashalong.com%@",self.urlStr]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
}

@end
