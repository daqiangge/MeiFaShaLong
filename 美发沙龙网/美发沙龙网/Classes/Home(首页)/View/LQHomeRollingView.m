//
//  LQHomeRollingView.m
//  美发沙龙网
//
//  Created by admin on 15/7/25.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQHomeRollingView.h"

@interface LQHomeRollingView()<LQHomeRollingScrollViewDelegate>

@end

@implementation LQHomeRollingView

- (LQHomeRollingScrollView *)homeRollingScrollView
{
    if (_homeRollingScrollView == nil)
    {
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat width = self.width;
        CGFloat height = self.height;
        CGRect frame = CGRectMake(x, y, width, height);
        
        LQHomeRollingScrollView *homeRollingScrollView = [LQHomeRollingScrollView homeRollingScrollViewWithFrame:frame];
        homeRollingScrollView.homeRollingScrollViewDelegate = self;
        homeRollingScrollView.backgroundColor = [UIColor blueColor];
        [self addSubview:homeRollingScrollView];
        _homeRollingScrollView = homeRollingScrollView;
    }
    
    return _homeRollingScrollView;
}

- (LQHomePageControlView *)homePageControlView
{
    if (_homePageControlView == nil)
    {
        CGFloat homePageControlViewW = CGRectGetWidth(self.homeRollingScrollView.frame);
        CGFloat homePageControlViewH = 30;
        CGFloat homePageControlViewX = 0;
        CGFloat homePageControlViewY = CGRectGetMaxY(self.homeRollingScrollView.frame) - homePageControlViewH;
        CGRect homePageControlViewF = CGRectMake(homePageControlViewX, homePageControlViewY, homePageControlViewW, homePageControlViewH);
        
        LQHomePageControlView *homePageControlView = [LQHomePageControlView homePageControlViewWithFrame:homePageControlViewF];
        homePageControlView.pageControl.currentPage = 0;
        [self addSubview:homePageControlView];
        self.homePageControlView = homePageControlView;
    }
    
    return _homePageControlView;
}

+ (instancetype)homeRollingViewWithFrame:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self doLoading];
    }
    
    return self;
}

- (void)doLoading
{
    self.homePageControlView.hidden = NO;
}

#pragma mark - LQHomeRollingScrollViewDelegate
- (void)homeRollingScrollViewDidUpdatePageControl:(LQHomeRollingScrollView *)scrollView currentPage:(NSInteger)currentPage titleName:(NSString *)titleName
{
    self.homePageControlView.pageControl.currentPage = currentPage;
    self.homePageControlView.titleLable.text = titleName;
}

- (void)homeRollingScrollViewDidClickImageView:(LQHomeRollingScrollView *)scrollView newsListContent:(LQNewsListContent *)newsContent
{
    if ([self.deleagte respondsToSelector:@selector(homeRollingViewDidClickImageView:newsListContent:)])
    {
        [self.deleagte homeRollingViewDidClickImageView:self newsListContent:newsContent];
    }
}

@end
