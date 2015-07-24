//
//  LQInformationVC.m
//  美发沙龙网
//
//  Created by admin on 15/7/22.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQInformationVC.h"

@interface LQInformationVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (weak, nonatomic) IBOutlet UIPageControl *abx;

@end

@implementation LQInformationVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    UINavigationBar *bar = self.navigationController.navigationBar;
//    CGFloat navBarHeight = 80.0f;
//    
//    CGRect rect = CGRectMake(0, 20, LQScreen_Width, navBarHeight);
//    
//    [bar setFrame:rect];
    
    [self.view removeConstraint:self.top];//先删除原有的对于顶部的约束
    //接下来通过代码添加一个约束
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.abx attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:400]];
    [self.view layoutIfNeeded];
    
}

@end
