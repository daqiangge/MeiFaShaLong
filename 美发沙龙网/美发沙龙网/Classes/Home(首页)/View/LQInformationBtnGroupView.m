//
//  LQInformationBtnGroupView.m
//  美发沙龙网
//
//  Created by admin on 15/7/25.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQInformationBtnGroupView.h"
#import "LQNewsSonClass.h"

#define space 10
#define button_height 30

@implementation LQInformationBtnGroupView

+ (instancetype)informationBtnGroupViewWithFrame:(CGRect)frame
{
    return [[self alloc] initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
    }
    
    return self;
}

- (void)setSonclassArray:(NSArray *)sonclassArray
{
    _sonclassArray = sonclassArray;
    
    [self doLoading];
}

- (void)doLoading
{
    long int num = self.sonclassArray.count;
    long int rows = (num - 1) / 4 + 1;
    self.height = space + (button_height + space) * rows;
    
    CGFloat width = (self.width - 5*space)/4;
    CGFloat height = button_height;
    
    //如果按钮个数小于4个，则一行均等放置
    if (num < 4)
    {
        width = (self.width - 4*space)/3;
    }
    
    for (int i = 0; i < num; i++)
    {
        int row = i/4;//行
        int colum = i%4;
        
        CGFloat x = space +(width + space) * colum;
        CGFloat y = space + (height + space) * row;
        CGRect frame = CGRectMake(x, y, width, height);
        
        LQNewsSonClass *sonclass = self.sonclassArray[i];
        
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = frame;
        [btn setTitle:sonclass.classname forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.tag = [sonclass.classid intValue];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        btn.backgroundColor = RGB(arc4random()%255, arc4random()%255, arc4random()%255);
    }
}
                               
- (void)clickBtn:(UIButton *)btn
{
    if ([self.btnGroupViewDelegate respondsToSelector:@selector(InformationBtnGroupViewDidClickBtnWithView:btn:)])
    {
        [self.btnGroupViewDelegate InformationBtnGroupViewDidClickBtnWithView:self btn:btn];
    }
}
@end
