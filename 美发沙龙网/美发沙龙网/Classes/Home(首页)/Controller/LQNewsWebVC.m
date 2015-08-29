//
//  LQNewsWebVC.m
//  美发沙龙网
//
//  Created by liqiang on 15/8/8.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQNewsWebVC.h"
#import "LQNewsContent.h"

@interface LQNewsWebVC ()<UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *webView;

@end

@implementation LQNewsWebVC

- (void)setID:(NSString *)ID
{
    _ID = ID;
}

- (void)setClassid:(NSString *)classid
{
    _classid = classid;
}

- (void)setNewstext:(NSString *)newstext
{
    _newstext = newstext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self doLoading];
    
    if (self.newstext)
    {
        [self.webView loadHTMLString:self.newstext baseURL:nil];
    }
    else
    {
        [self RequsetNewsContent];
    }
    
}

- (void)doLoading
{
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = CGRectMake(0, Navigation_Height, LQScreen_Width, LQScreen_Height-Navigation_Height);
    webView.scalesPageToFit = NO;
    webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //去除长按后出现的文本选取框
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //判断是否是单击
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        return NO;
    }
    return YES;
}

#pragma mark - 网络请求
- (void)RequsetNewsContent
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr = @"http://old.meifashalong.com/e/api/getNewsContent.php";
    NSDictionary *parameters = @{@"id":self.ID,@"classid":self.classid};
    LQLog(@"http://old.meifashalong.com/e/api/getNewsContent.php?id=%@&classid=%@",self.ID,self.classid);
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        LQNewsContent *newsContent = [LQNewsContent objectWithKeyValues:operation.responseString];
        LQLog(@"%@",operation.responseString);
        NSString *html_str = [NSString stringWithFormat:@"<p style=\"text-align:center;font-size:20px;font-weight:bold;\">%@</p>%@",newsContent.title,newsContent.newstext];
        
        [self.webView loadHTMLString:html_str baseURL:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LQLog(@"请求失败%@",error);
        
        hud.labelText = HTTPRequestErrer_Text;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.5];
    }];
}

@end
