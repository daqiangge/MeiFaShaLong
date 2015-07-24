//
//  LQHomePageControlView.m
//  美发沙龙网
//
//  Created by admin on 15/7/23.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQHomePageControlView.h"

@implementation LQHomePageControlView

+ (instancetype)homePageControlViewWithFrame:(CGRect)frame
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
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.frame   = CGRectMake(0, 0, self.width, self.height);
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0.5;
    [self addSubview:backgroundView];
    
    UILabel *titleLable  = [[UILabel alloc] init];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = TextFont_14;
    [self addSubview:titleLable];
    self.titleLable = titleLable;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = 5;
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(0);
        make.top.equalTo(self.mas_top).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.width.equalTo(@90);
    }];
    
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(pageControl.mas_left).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.top.equalTo(self.mas_top).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
    }];
}

@end
