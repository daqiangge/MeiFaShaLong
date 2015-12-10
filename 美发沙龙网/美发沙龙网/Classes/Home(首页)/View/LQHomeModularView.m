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
    
    NSArray *titles = @[@"美业资讯",@"美发视频",@"",@"",@"发型图片",@"免费视频",@"美发商城",@"美发人社区",@"美发技术",@"美发学校",@"发廊经营",@"求职招聘"];
    
    for (int i = 0; i < 12; i++)
    {
        if (i == 2 || i == 3)
        {
            continue;
        }
        
        CGFloat space = 10;
        CGFloat minBtnWidth = (self.width - 4*space)/3;
        CGFloat minBtnHeight = (self.height - 5*space)/4;
        
        int row = i/3;//行
        int column = i%3;//列
        CGFloat x = space + (minBtnWidth +space)*column;
        CGFloat y = space + (minBtnHeight +space)*row;
        
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font    = TextFont_13;
        btn.layer.borderColor  = Layer_BorderColor;
        btn.layer.borderWidth  = Layer_BorderWidth;
        btn.layer.cornerRadius = Layer_CornerRadius;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        //设置按钮的标签
        switch (i) {
            case 0:
                btn.tag = 58;
                btn.frame = CGRectMake(x,y, minBtnWidth, minBtnHeight*2+space);
                btn.titleLabel.font = TextFont_16;
                [btn setBackgroundImageAndTitlePositionRelationWithUpDownSpace:10.0];
                break;
                
            case 1:
                btn.tag = 107;
                btn.frame = CGRectMake(x,y, minBtnWidth*2+space, minBtnHeight);
                btn.titleLabel.font = TextFont_16;
                [btn setBackgroundImageAndTitlePositionRelationWithLeftRightSpace:10.0];
                break;
                
            case 4:
                btn.tag = 81;
                break;
                
            case 5:
                
                break;
                
            case 6:
                btn.tag = 94;
                break;
                
            case 7:
                
                break;
                
            case 8:
                btn.tag = 62;
                break;
                
            case 9:
                
                break;
                
            case 10:
                btn.tag = 74;
                break;
                
            case 11:
                break;
        }
        
        if (i !=0 && i != 1)
        {
            if (IPhone4_4s)
            {
                [btn setImage:[UIImage imageNamed:@"3"] forState:UIControlStateNormal];
            }
            btn.frame = CGRectMake(x,y, minBtnWidth, minBtnHeight);
            [btn setBackgroundImageAndTitlePositionRelationWithUpDownSpace:5.0];
        }
    }
}

- (void)clickBtn:(UIButton *)btn
{
    if ([self.homeModularViewDelegate respondsToSelector:@selector(homeModularViewDidClickBtnWithView:btn:)]) {
        [self.homeModularViewDelegate homeModularViewDidClickBtnWithView:self btn:btn];
    }
}

@end
