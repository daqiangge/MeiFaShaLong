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
    MFSideMenuContainerViewController *mfSideMenu = [MFSideMenuContainerViewController
                                                     containerWithCenterViewController:tabBarController
                                                     leftMenuViewController:leftMeunVC
                                                     rightMenuViewController:nil];
    
    [self presentViewController:mfSideMenu animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
