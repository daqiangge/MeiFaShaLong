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
#import "LQNewsList.h"
#import "LQNewsListContent.h"
#import "LQNewsWebVC.h"

@interface LQHomeVC ()<LQHomeModularViewDelegate,LQHomeRollingViewDelegate>

@property (weak, nonatomic  ) LQHomeModularView     *homeModularView;
@property (nonatomic, weak  ) LQHomePageControlView *homePageControlView;
@property (nonatomic, weak  ) LQHomeRollingView     *homeRollingView;
@property (nonatomic, strong) NSArray *newsListArray;

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
        homeRollingView.deleagte = self;
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

- (NSArray *)newsListArray
{
    if (_newsListArray == nil)
    {
        _newsListArray = [NSArray array];
    }
    
    return _newsListArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"navigationbar_pop" selectedImageName:@"navigationbar_pop_highlighted" target:self action:@selector(refresh)];
    
    [self doLoading];
    [self refresh];
}

- (void)doLoading
{
    self.homeRollingView.hidden = NO;
    self.homeModularView.hidden = NO;
}

/**
 *  刷新
 */
- (void)refresh
{
    [self requestNewsList];
}

#pragma mark - 网络请求
- (void)requestNewsList
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr                       = @"http://old.meifashalong.com/e/api/getNewsList.php";
    NSDictionary *parameters = @{@"pageSize":@"5",@"classid":@"58"};
    
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        LQNewsList *newsList = [LQNewsList objectWithKeyValues:operation.responseString];
        self.newsListArray = newsList.data;
        
        self.homeRollingView.homeRollingScrollView.imageUrlArray = [NSMutableArray arrayWithArray:self.newsListArray];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LQLog(@"请求失败%@",error);
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = HTTPRequestErrer_Text;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.5];
    }];
}

#pragma mark - LQHomeModularViewDelegate
- (void)homeModularViewDidClickBtnWithView:(LQHomeModularView *)view btn:(UIButton *)btn
{
    LQInformationVC *informationVC = [[LQInformationVC alloc] init];
    informationVC.title            = btn.titleLabel.text;
    informationVC.classid = [NSString stringWithFormat:@"%ld",btn.tag];
    
    [self.navigationController pushViewController:informationVC animated:YES];
}

#pragma mark - LQHomeRollingViewDelegate
- (void)homeRollingViewDidClickImageView:(LQHomeRollingView *)homeRollingView newsListContent:(LQNewsListContent *)newsContent
{
    if (self.newsListArray.count == 0)
    {
        return;
    }
    
    LQNewsWebVC *newWebVC = [[LQNewsWebVC alloc] init];
    newWebVC.ID = newsContent.ID;
    newWebVC.classid = newsContent.classid;
    newWebVC.navigationItem.title = newsContent.classname;
    [self.navigationController pushViewController:newWebVC animated:YES];
}

@end
