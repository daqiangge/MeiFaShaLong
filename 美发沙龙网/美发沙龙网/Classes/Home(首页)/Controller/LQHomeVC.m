//
//  LQHomeVC.m
//  美发沙龙网
//
//  Created by admin on 15/7/21.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQHomeVC.h"
#import "LQHomeModularView.h"
#import "LQHomePageControlView.h"
#import "LQInformationVC.h"
#import "LQHomeRollingView.h"
#import "LQNewsClass.h"
#import "LQNewsClassId.h"
#import "LQNewsList.h"
#import "LQNewsListContent.h"

@interface LQHomeVC ()<LQHomeModularViewDelegate>

@property (weak, nonatomic  ) LQHomeModularView     *homeModularView;
@property (nonatomic, weak  ) LQHomePageControlView *homePageControlView;
@property (nonatomic, weak  ) LQHomeRollingView     *homeRollingView;
@property (nonatomic, strong) LQNewsClass           *newsClass;

@end

@implementation LQHomeVC

- (LQHomeRollingView *)homeRollingView
{
    if (_homeRollingView == nil)
    {
        CGFloat x                          = 0;
        CGFloat y                          = 64;
        CGFloat width                      = LQScreen_Width;
        CGFloat height                     = (130 * LQScreen_Width)/320;
        CGRect frame                       = CGRectMake(x, y, width, height);

        LQHomeRollingView *homeRollingView = [LQHomeRollingView homeRollingViewWithFrame:frame];
        [self.view addSubview:homeRollingView];
        _homeRollingView                   = homeRollingView;
        
    }
    
    return _homeRollingView;
}

- (LQHomeModularView *)homeModularView
{
    if (_homeModularView == nil)
    {
        CGFloat x                               = 0.0;
        CGFloat y                               = CGRectGetMaxY(self.homeRollingView.frame);
        CGFloat width                           = LQScreen_Width;
        CGFloat height                          = LQScreen_Height - y - 49;
        CGRect frame                            = CGRectMake(x, y, width, height);

        LQHomeModularView *homeModularView      = [LQHomeModularView homeModularViewWithFrame:frame];
        homeModularView.backgroundColor         = [UIColor whiteColor];
        homeModularView.homeModularViewDelegate = self;
        [self.view addSubview:homeModularView];
        _homeModularView                        = homeModularView;
    }
    
    return _homeModularView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self doLoading];
    [self requestAllNewsClass];
    [self requestNewsList];
}

- (void)doLoading
{
    self.homeRollingView.hidden = NO;
    self.homeModularView.hidden = NO;
}

#pragma mark - 网络请求
- (void)requestAllNewsClass
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr                       = @"http://old.meifashalong.com/e/api/getNewsClass.php";

    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        self.newsClass = [LQNewsClass objectWithKeyValues:operation.responseString];
        LQLog(@"123123");

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LQLog(@"请求失败%@",error);
    }];
}

- (void)requestNewsList
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr                       = @"http://old.meifashalong.com/e/api/getNewsList.php";
    NSDictionary *parameters = @{@"pageSize":@"4"};
    
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        LQNewsList *newsList = [LQNewsList objectWithKeyValues:operation.responseString];
        self.homeRollingView.homeRollingScrollView.imageUrlArray = [NSMutableArray arrayWithArray:newsList.data];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LQLog(@"请求失败%@",error);
    }];
}

#pragma mark - LQHomeModularViewDelegate
- (void)homeModularViewDidClickBtnWithView:(LQHomeModularView *)view btn:(UIButton *)btn
{
    LQInformationVC *informationVC = [[LQInformationVC alloc] init];
    informationVC.title            = btn.titleLabel.text;
    informationVC.classid = [NSString stringWithFormat:@"%ld",btn.tag];

    switch (btn.tag)
    {
        case 58:
            informationVC.sonclassArray = self.newsClass.data.newsClassId_58.sonclass;
            break;
            
        case 62:
            informationVC.sonclassArray = self.newsClass.data.newsClassId_62.sonclass;
            break;
            
        case 74:
            informationVC.sonclassArray = self.newsClass.data.newsClassId_74.sonclass;
            break;
    }
    
    [self.navigationController pushViewController:informationVC animated:YES];
    
    
    
}

@end
