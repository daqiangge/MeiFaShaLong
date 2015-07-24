//
//  LQHomeVC.m
//  美发沙龙网
//
//  Created by admin on 15/7/21.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQHomeVC.h"
#import "LQHomeModularView.h"
#import "LQHomeRollingScrollView.h"
#import "LQHomePageControlView.h"
#import "LQInformationVC.h"

@interface LQHomeVC ()<LQHomeRollingScrollViewDelegate,LQHomeModularViewDelegate>

@property (weak, nonatomic) LQHomeRollingScrollView *homeRollingScrollView;
@property (weak, nonatomic) LQHomeModularView *homeModularView;
@property (nonatomic, weak) LQHomePageControlView *homePageControlView;

@end

@implementation LQHomeVC

- (LQHomeRollingScrollView *)homeRollingScrollView
{
    if (_homeRollingScrollView == nil)
    {
        CGFloat x = 0.0;
        CGFloat y = 64.0;
        CGFloat width = LQScreen_Width;
        CGFloat height = 150.0;
        CGRect frame = CGRectMake(x, y, width, height);
        
        LQHomeRollingScrollView *homeRollingScrollView = [LQHomeRollingScrollView homeRollingScrollViewWithFrame:frame];
        homeRollingScrollView.homeRollingScrollViewDelegate = self;
        homeRollingScrollView.backgroundColor = [UIColor blueColor];
        [self.view addSubview:homeRollingScrollView];
        _homeRollingScrollView = homeRollingScrollView;
    }
    
    return _homeRollingScrollView;
}

- (LQHomeModularView *)homeModularView
{
    if (_homeModularView == nil)
    {
        CGFloat x = 0.0;
        CGFloat y = CGRectGetMaxY(self.homeRollingScrollView.frame);
        CGFloat width = LQScreen_Width;
        CGFloat height = LQScreen_Height - y - 49;
        CGRect frame = CGRectMake(x, y, width, height);
        
        LQHomeModularView *homeModularView = [LQHomeModularView homeModularViewWithFrame:frame];
        homeModularView.backgroundColor = [UIColor whiteColor];
        homeModularView.homeModularViewDelegate = self;
        [self.view addSubview:homeModularView];
        _homeModularView = homeModularView;
    }
    
    return _homeModularView;
}

- (MFSideMenuContainerViewController *)menuContainerViewController
{
    return (MFSideMenuContainerViewController *)self.tabBarController.parentViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"menu-icon" selectedImageName:@"menu-icon" target:self action:@selector(openMeun)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"navigationbar_pop" selectedImageName:@"navigationbar_pop_highlighted" target:self action:@selector(refresh)];
    
    [self doLoading];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //设置导航栏的title为白色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //设置菜单栏的状态为可打开
    self.menuContainerViewController.panMode = MFSideMenuPanModeDefault;
}

- (void)doLoading
{
    self.homeRollingScrollView.hidden = NO;
    self.homeModularView.hidden = NO;
    
    //加载pageControlView
    CGFloat homePageControlViewW = CGRectGetWidth(self.homeRollingScrollView.frame);
    CGFloat homePageControlViewH = 30;
    CGFloat homePageControlViewX = 0;
    CGFloat homePageControlViewY = CGRectGetMaxY(self.homeRollingScrollView.frame) - homePageControlViewH;
    CGRect homePageControlViewF = CGRectMake(homePageControlViewX, homePageControlViewY, homePageControlViewW, homePageControlViewH);
    
    LQHomePageControlView *homePageControlView = [LQHomePageControlView homePageControlViewWithFrame:homePageControlViewF];
    homePageControlView.titleLable.text = @"史上最全打蜡配方，高端学习教程";
    homePageControlView.pageControl.currentPage = 0;
    [self.view addSubview:homePageControlView];
    self.homePageControlView = homePageControlView;
}

- (void)openMeun
{
    LQLog(@"打开菜单");
}

- (void)refresh
{

}

#pragma mark - LQHomeRollingScrollViewDelegate
- (void)homeRollingScrollViewDidUpdatePageControl:(LQHomeRollingScrollView *)scrollView currentPage:(NSInteger)currentPage
{
    self.homePageControlView.pageControl.currentPage = currentPage;
    self.homePageControlView.titleLable.text = @"史上最全打蜡配方，高端学习教程";
}

#pragma mark - LQHomeModularViewDelegate
- (void)homeModularViewDidClickBtnWithView:(LQHomeModularView *)view btn:(UIButton *)btn
{
    LQInformationVC *informationVC = [[LQInformationVC alloc] init];
    [self.navigationController pushViewController:informationVC animated:YES];
}

@end
