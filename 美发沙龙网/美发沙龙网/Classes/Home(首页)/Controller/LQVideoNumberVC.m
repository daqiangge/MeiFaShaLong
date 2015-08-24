//
//  LQVideoNumberVC.m
//  美发沙龙网
//
//  Created by admin on 15/8/22.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQVideoNumberVC.h"

@interface LQVideoNumberVC ()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation LQVideoNumberVC

- (void)setVideoBtnSelecteNum:(int)videoBtnSelecteNum
{
    _videoBtnSelecteNum = videoBtnSelecteNum;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.navigationItem.title = @"集数";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"navigationbar_pop" selectedImageName:@"navigationbar_pop_highlighted" target:self action:@selector(refresh)];
    
    [self doLoading];
}

- (void)doLoading
{
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = RGB(246, 246, 246);
    backgroundView.frame = CGRectMake(0, Navigation_Height, LQScreen_Width, LQScreen_Height);
    [self.view addSubview:backgroundView];
    
    for (int i = 0; i < 21; i++)
    {
        int row = i/6;
        int col = i%6;
        
        CGFloat width = 40;
        CGFloat height = 40;
        CGFloat space = (LQScreen_Width - 40*6)/7;
        CGFloat x = space + (space + width) * col;
        CGFloat y = Navigation_Height + space + (space + height) * row;
        
        CGRect frame = CGRectMake(x, y, width, height);
        
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = frame;
        btn.tag = 101 + i;
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitle:[NSString stringWithFormat:@"%02d",i+1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        if (i == self.videoBtnSelecteNum - 101)
        {
            btn.selected = YES;
            self.btn = btn;
        }
    }
}

- (void)refresh
{
    LQLog(@"刷新");
}

- (void)btnDidClick:(UIButton *)btn
{
    self.btn.selected = NO;
    
    btn.selected = YES;
    self.btn = btn;
    
    self.videoBtnSelecteNum = (int)btn.tag;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationName_VideoBtnSelecteNum object:[NSNumber numberWithInt:self.videoBtnSelecteNum]];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
