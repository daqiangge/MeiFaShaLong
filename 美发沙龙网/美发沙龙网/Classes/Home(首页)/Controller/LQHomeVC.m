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

@interface LQHomeVC ()<LQHomeModularViewDelegate>

@property (weak, nonatomic) LQHomeModularView *homeModularView;
@property (nonatomic, weak) LQHomePageControlView *homePageControlView;
@property (nonatomic, weak) LQHomeRollingView *homeRollingView;

@end

@implementation LQHomeVC

- (LQHomeRollingView *)homeRollingView
{
    if (_homeRollingView == nil)
    {
        CGFloat x = 0;
        CGFloat y = 64;
        CGFloat width = LQScreen_Width;
        CGFloat height = (130 * LQScreen_Width)/320;
        CGRect frame = CGRectMake(x, y, width, height);
        
        LQHomeRollingView *homeRollingView = [LQHomeRollingView homeRollingViewWithFrame:frame];
        [self.view addSubview:homeRollingView];
        _homeRollingView = homeRollingView;
        
    }
    
    return _homeRollingView;
}

- (LQHomeModularView *)homeModularView
{
    if (_homeModularView == nil)
    {
        CGFloat x = 0.0;
        CGFloat y = CGRectGetMaxY(self.homeRollingView.frame);
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self doLoading];
}

- (void)doLoading
{
    self.homeRollingView.hidden = NO;
    self.homeModularView.hidden = NO;
}

#pragma mark - LQHomeModularViewDelegate
- (void)homeModularViewDidClickBtnWithView:(LQHomeModularView *)view btn:(UIButton *)btn
{
    LQInformationVC *informationVC = [[LQInformationVC alloc] init];
    informationVC.title = btn.titleLabel.text;
    [self.navigationController pushViewController:informationVC animated:YES];
}

@end
