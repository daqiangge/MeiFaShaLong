//
//  LQInformationBtnGroupView.m
//  美发沙龙网
//
//  Created by admin on 15/7/25.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQInformationBtnGroupView.h"

@implementation LQInformationBtnGroupView

+ (instancetype)informationBtnGroupViewWithFrame:(CGRect)frame
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
    NSArray *titleArray = @[@"剪发技术",@"烫发技术",@"染发技术",@"吹风造型"];
    
    for (int i = 0; i < 4; i++)
    {
        int colum = i%4;
        CGFloat space = 10;
        CGFloat width = (self.width - 5*space)/4;
        CGFloat height = self.height - space*2;
        CGFloat x = space +(width + space) * colum;
        CGFloat y = space;
        CGRect frame = CGRectMake(x, y, width, height);
        
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = frame;
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        switch (i) {
            case 0:
                btn.backgroundColor = [UIColor colorWithRed:156/255. green:227/255. blue:237/255. alpha:1];
                break;
            case 1:
                btn.backgroundColor = [UIColor colorWithRed:212/255. green:243/255. blue:90/255. alpha:1];
                break;
            case 2:
                btn.backgroundColor = [UIColor colorWithRed:247/255. green:208/255. blue:107/255. alpha:1];
                break;
            case 3:
                btn.backgroundColor = [UIColor colorWithRed:252/255. green:170/255. blue:136/255. alpha:1];
                break;
                
            default:
                break;
        }
    }
}
                               
- (void)clickBtn:(UIButton *)btn
{
    LQLog(@"点击了按钮");
    
    if ([self.btnGroupViewDelegate respondsToSelector:@selector(informationBtnGroupViewWithFrame:)]) {
        [self.btnGroupViewDelegate InformationBtnGroupViewDidClickBtn:self];
    }
}
@end
