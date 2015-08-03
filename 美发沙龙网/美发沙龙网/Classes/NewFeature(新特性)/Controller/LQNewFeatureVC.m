//
//  LQNewFeatureVC.m
//  美发沙龙网
//
//  Created by admin on 15/7/30.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQNewFeatureVC.h"
#import "LQTabBarController.h"
#import "LQLeftMeunVC.h"
#import "AppDelegate.h"

@interface LQNewFeatureVC ()

@end

@implementation LQNewFeatureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(AA) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self doLoading];
}

- (void)doLoading
{
    
}

- (void)AA
{
    LQLeftMeunVC *leftMeunVC = [[LQLeftMeunVC alloc] init];
    LQTabBarController *tabBarController = [[LQTabBarController alloc] init];
    LeftSlideViewController *LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftMeunVC andMainView:tabBarController];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.LeftSlideVC = LeftSlideVC;
    appDelegate.tabBarController = tabBarController;
    
    [self presentViewController:LeftSlideVC animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
