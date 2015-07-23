//
//  LQHomeRollingScrollView.m
//  美发沙龙网
//
//  Created by liqiang on 15/7/22.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQHomeRollingScrollView.h"

@interface LQHomeRollingScrollView()<UIScrollViewDelegate>

@end

@implementation LQHomeRollingScrollView

+ (instancetype)homeRollingScrollViewWithFrame:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.delegate = self;
        
        [self doLoading];
    }
    
    return self;
}

- (void)doLoading
{
    self.contentSize = CGSizeMake(LQScreen_Width * 5, self.height);
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.bounces = NO;
    
    [self addImageView];
    
} 

- (void)addImageView
{
    for (int i = 0; i < 5; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=23abadd9d1ca7bcb7d2e946fd8345f51/024f78f0f736afc32894ab7fb519ebc4b745120b.jpg"] placeholderImage:[UIImage imageNamed:@"123"] options:SDWebImageRetryFailed];
        imageView.userInteractionEnabled = YES;
        imageView.frame = CGRectMake(LQScreen_Width * i, 0, LQScreen_Width, self.height);
        [self addSubview:imageView];
        
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(0, 0, imageView.width, imageView.height);
        [btn addTarget:self action:@selector(clickImageView:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:btn];
    }
}

- (void)clickImageView:(UIButton *)btn
{
    LQLog(@"123");
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint point = [scrollView contentOffset];
    int n = point.x/LQScreen_Width;
    
    //更改小圆点的位置
    if ([self.homeRollingScrollViewDelegate respondsToSelector:@selector(homeRollingScrollViewDidUpdatePageControl:currentPage:)]) {
        [self.homeRollingScrollViewDelegate homeRollingScrollViewDidUpdatePageControl:self currentPage:n];
    }
}

@end
