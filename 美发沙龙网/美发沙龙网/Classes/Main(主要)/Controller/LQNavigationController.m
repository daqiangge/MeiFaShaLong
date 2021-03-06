//
//  LQNavigationController.m
//  美发沙龙网
//
//  Created by admin on 15/7/22.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQNavigationController.h"
#import "AppDelegate.h"

@interface LQNavigationController ()

@end

@implementation LQNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count == 0)//给一级的界面添加左右按钮
    {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"menu-icon" selectedImageName:@"menu-icon" target:self action:@selector(openMeun)];
    }else
    {
        NSArray *array = self.viewControllers;
        long int count = array.count;
        UIViewController *vc = array[count - 1];
        vc.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    
    if (self.viewControllers.count > 1)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //设置导航栏的title为白色
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor]}];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UIBarButtonItem
/**
 *  打开菜单
 */
- (void)openMeun
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC openLeftView];
}

@end
