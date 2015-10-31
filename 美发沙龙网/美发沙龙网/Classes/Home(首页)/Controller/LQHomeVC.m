//
//  LQHomeVC.m
//  美发沙龙网
//
//  Created by admin on 15/7/21.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQHomeVC.h"
#import "LQHomeModularView.h"
#import "LQInformationVC.h"
#import "LQNewsList.h"
#import "LQNewsListContent.h"
#import "LQNewsWebVC.h"
#import "LQAdvertisements.h"
#import "LQAdvertisement.h"
#import "LZAutoScrollView.h"

@interface LQHomeVC ()<LQHomeModularViewDelegate,LZAutoScrollViewDelegate>

@property (weak, nonatomic  ) LQHomeModularView     *homeModularView;
@property (nonatomic, weak  ) LZAutoScrollView     *homeRollingView;
@property (nonatomic, strong) NSArray *newsListArray;

@end

@implementation LQHomeVC

- (LZAutoScrollView *)homeRollingView
{
    if (_homeRollingView == nil)
    {
        CGFloat x                          = 0;
        CGFloat y                          = 64;
        CGFloat width                      = LQScreen_Width;
        CGFloat height                     = (130 * LQScreen_Width)/320;
        CGRect frame                       = CGRectMake(x, y, width, height);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = [UIImage imageNamed:@"placehodeImage"];
        [self.view addSubview:imageView];

        LZAutoScrollView *homeRollingView =[[LZAutoScrollView alloc] initWithFrame:frame];
        homeRollingView.delegate = self;
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
//    [self requestNewsList];
    [self requestAdvertisementPhoto];
}

#pragma mark - 网络请求
/*
 获取广告图片
 */
- (void)requestAdvertisementPhoto
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr                       = @"http://old.meifashalong.com/e/api/getNewsList.php";
    NSDictionary *parameters = @{@"classid":@"134"};
    
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
//        LQLog(@"%@",operation.responseString);
        
        LQAdvertisements *advertisements = [LQAdvertisements objectWithKeyValues:operation.responseString];
        
        NSMutableArray *imageArray = [NSMutableArray array];
        NSMutableArray *titleArray = [NSMutableArray array];
        for (LQAdvertisement *advertisement in advertisements.advertisements)
        {
            [imageArray addObject:advertisement.titlepic];
            [titleArray addObject:advertisement.title];
        }
        
        self.homeRollingView.titles = titleArray;
        self.homeRollingView.images = imageArray;
        self.homeRollingView.placeHolder = [UIImage imageNamed:@"placehodeImage"];
        [self.homeRollingView createViews];
        
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

@end
