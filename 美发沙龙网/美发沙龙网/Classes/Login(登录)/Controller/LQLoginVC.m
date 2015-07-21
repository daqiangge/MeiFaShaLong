//
//  LQLoginVC.m
//  美发沙龙网
//
//  Created by admin on 15/7/21.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQLoginVC.h"
#import "MFSideMenuContainerViewController.h"
#import "LQLeftMeunVC.h"
#import "LQHomeVC.h"

@interface LQLoginVC ()

@end

@implementation LQLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doLogin:(id)sender
{
    LQLeftMeunVC *leftMeunVC = [[LQLeftMeunVC alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc]
                                        initWithRootViewController:[[LQHomeVC alloc] init]];
    MFSideMenuContainerViewController *mfSideMenu = [MFSideMenuContainerViewController
                                                 containerWithCenterViewController:homeNav
                                                 leftMenuViewController:leftMeunVC
                                                 rightMenuViewController:nil];
    [self presentViewController:mfSideMenu animated:NO completion:nil];
}

@end
