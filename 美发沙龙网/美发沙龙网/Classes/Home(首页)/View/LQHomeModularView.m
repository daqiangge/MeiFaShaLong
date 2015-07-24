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
        [btn setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
        [btn setTitle:@"美业资讯" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font    = TextFont_14;
        btn.layer.borderColor  = Layer_BorderColor;
        btn.layer.borderWidth  = Layer_BorderWidth;
        btn.layer.cornerRadius = Layer_CornerRadius;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        switch (i)
        {
            case 0:
                btn.frame = CGRectMake(x,y, minBtnWidth, minBtnHeight*2+space);
                btn.titleLabel.font = TextFont_17;
                [btn setBackgroundImageAndTitlePositionRelationWithUpDownSpace:10.0];
                break;
            case 1:
                btn.frame = CGRectMake(x,y, minBtnWidth*2+space, minBtnHeight);
                btn.titleLabel.font = TextFont_17;
                [btn setBackgroundImageAndTitlePositionRelationWithLeftRightSpace:10.0];
                break;
                
            default:
                btn.frame = CGRectMake(x,y, minBtnWidth, minBtnHeight);
                [btn setBackgroundImageAndTitlePositionRelationWithUpDownSpace:5.0];
                break;
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
