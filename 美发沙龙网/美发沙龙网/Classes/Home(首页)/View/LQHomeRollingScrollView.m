//
//  LQHomeRollingScrollView.m
//  美发沙龙网
//
//  Created by liqiang on 15/7/22.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQHomeRollingScrollView.h"

@implementation LQHomeRollingScrollView

+ (instancetype)homeRollingScrollView
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init])
    {
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [self addImageView];
}

- (void)addImageView
{
    self.contentSize = CGSizeMake(LQScreen_Width * 5, self.height);
    
    for (int i = 0; i < 5; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=23abadd9d1ca7bcb7d2e946fd8345f51/024f78f0f736afc32894ab7fb519ebc4b745120b.jpg"] placeholderImage:[UIImage imageNamed:@"123"] options:SDWebImageRetryFailed];
        imageView.frame = CGRectMake(LQScreen_Width * i, 0, LQScreen_Width, self.height);
        [self addSubview:imageView];
    }
}

@end
