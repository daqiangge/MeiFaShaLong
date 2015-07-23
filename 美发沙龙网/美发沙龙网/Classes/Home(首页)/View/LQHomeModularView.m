//
//  LQHomeModularView.m
//  美发沙龙网
//
//  Created by liqiang on 15/7/22.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//
//--------------------------------------------------
//---------- 首页中下半部分的模块按钮View-----------
//--------------------------------------------------

#import "LQHomeModularView.h"

@implementation LQHomeModularView

+ (instancetype)homeModularViewWithFrame:(CGRect)frame
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
    UIButton *oneBtn = [[UIButton alloc] init];
    oneBtn.backgroundColor = [UIColor redColor];
    [self addSubview:oneBtn];
    
    [oneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.top.equalTo(self.mas_top).with.offset(10);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
}

@end
