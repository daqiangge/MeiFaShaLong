//
//  LQHomeRollingScrollView.m
//  美发沙龙网
//
//  Created by liqiang on 15/7/22.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//


#import "LQHomeRollingScrollView.h"

#define kCount 5

#define ImageUrlArray (@[@"https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=23abadd9d1ca7bcb7d2e946fd8345f51/024f78f0f736afc32894ab7fb519ebc4b745120b.jpg",@"http://img.firefoxchina.cn/2015/07/5/201507301312100.jpg",@"http://img.firefoxchina.cn/2015/07/5/201507300849040.jpg",@"http://img.firefoxchina.cn/2015/07/4/201507300846520.jpg",@"http://img.firefoxchina.cn/2015/07/4/201507300853170.jpg"])

@interface LQHomeRollingScrollView()<UIScrollViewDelegate>

@property (nonatomic, weak) UIImageView *previousImageView;
@property (nonatomic, weak) UIImageView *nextImageView;
@property (nonatomic, weak) UIImageView *currentImageView;
@property (nonatomic, assign) int page;

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
        
        self.page = 0;
        
        [self doLoading];
    }
    
    return self;
}

- (void)doLoading
{
    self.contentSize = CGSizeMake(LQScreen_Width * 3, self.height);
    self.contentOffset = CGPointMake(LQScreen_Width, 0);
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.bounces = NO;
    
    [self addImageView];
}

- (void)addImageView
{
    NSArray *array = ImageUrlArray;
    
    for (int i = 0; i < 3; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.frame = CGRectMake(LQScreen_Width * i, 0, LQScreen_Width, self.height);
        [self addSubview:imageView];
        
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(0, 0, imageView.width, imageView.height);
        [btn addTarget:self action:@selector(clickImageView:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:btn];
        
        switch (i)
        {
            case 0:
            {
                self.previousImageView = imageView;
                [imageView sd_setImageWithURL:[NSURL URLWithString:array[kCount - 1]] placeholderImage:[UIImage imageNamed:@"123"] options:SDWebImageRetryFailed];
            }
                break;
                
            case 1:
            {
                self.currentImageView = imageView;
                [imageView sd_setImageWithURL:[NSURL URLWithString:array[0]] placeholderImage:[UIImage imageNamed:@"123"] options:SDWebImageRetryFailed];
            }
                break;
                
            case 2:
            {
                self.nextImageView = imageView;
                [imageView sd_setImageWithURL:[NSURL URLWithString:array[1]] placeholderImage:[UIImage imageNamed:@"123"] options:SDWebImageRetryFailed];
            }
                break;
        }
    }
}

/**
 *  点击了图片
 */
- (void)clickImageView:(UIButton *)btn
{
    LQLog(@"点击了图片");
    
    if ([self.homeRollingScrollViewDelegate respondsToSelector:@selector(homeRollingScrollViewDidClickImageView:)])
    {
        [self.homeRollingScrollViewDelegate homeRollingScrollViewDidClickImageView:self];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray *array = ImageUrlArray;
    
    CGFloat offestX = scrollView.contentOffset.x;
    
    if (self.previousImageView.image == nil || self.nextImageView.image == nil)
    {
        [self.previousImageView sd_setImageWithURL:array[self.page == 0 ? kCount - 1:self.page - 1] placeholderImage:[UIImage imageNamed:@"123"] options:SDWebImageRetryFailed];
        [self.nextImageView sd_setImageWithURL:array[self.page == kCount - 1 ? 0 : self.page + 1] placeholderImage:[UIImage imageNamed:@"123"] options:SDWebImageRetryFailed];
    }
    
    if (offestX == 0)
    {
        self.currentImageView.image = self.previousImageView.image;
        scrollView.contentOffset = CGPointMake(LQScreen_Width, 0);
        self.previousImageView.image = nil;
        
        if (self.page == 0)
        {
            self.page = kCount - 1;
        }else
        {
            self.page -= 1;
        }
    }
    
    if (offestX == LQScreen_Width*2)
    {
        self.currentImageView.image = self.nextImageView.image;
        scrollView.contentOffset = CGPointMake(LQScreen_Width, 0);
        self.nextImageView.image = nil;
        
        if (self.page == kCount - 1)
        {
            self.page = 0;
        }else
        {
            self.page += 1;
        }
    }
    
    //更改小圆点的位置
    if ([self.homeRollingScrollViewDelegate respondsToSelector:@selector(homeRollingScrollViewDidUpdatePageControl:currentPage:)]) {
        [self.homeRollingScrollViewDelegate homeRollingScrollViewDidUpdatePageControl:self currentPage:self.page];
    }
}

@end
