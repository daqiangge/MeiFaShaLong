//
//  LQTabBarController.m
//  美发沙龙网
//
//  Created by admin on 15/7/22.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQTabBarController.h"
#import "LQHomeVC.h"
#import "LQNewRecommendVC.h"
#import "LQCommunityVC.h"
#import "LQPersonalCenterVC.h"
#import "LQNavigationController.h"

#import "LQMoreVC.h"
#import "ReleaseInformationVC.h"
#import "FriendsCircleVC.h"

@interface LQTabBarController ()<UITabBarControllerDelegate>

@end

@implementation LQTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.barTintColor = [UIColor blackColor];
    self.tabBar.tintColor    = [UIColor orangeColor];
    self.delegate            = self;
    
    LQHomeVC *homeVC = [[LQHomeVC alloc] init];
    [self addChildVC:homeVC
         tabBarTitle:@"首页"
      navgationTitle:@"中国美发沙龙网"
           imageName:@"tabbar_home"
   selectedImageName:@"tabbar_home_selected"];
    
    FriendsCircleVC *friendsCircleVC = [[FriendsCircleVC alloc] init];
    [self addChildVC:friendsCircleVC
         tabBarTitle:@"朋友圈"
      navgationTitle:@"朋友圈"
           imageName:@"tabbar_message_center"
   selectedImageName:@"tabbar_message_center_selected"];
    
    ReleaseInformationVC *releaseInformationVC = [[ReleaseInformationVC alloc] init];
    [self addChildVC:releaseInformationVC
         tabBarTitle:@"发布信息"
      navgationTitle:@"发布信息"
           imageName:@"tabbar_discover"
   selectedImageName:@"tabbar_discover_selected"];
    
    LQPersonalCenterVC *personalCenterVC = [[LQPersonalCenterVC alloc] init];
    [self addChildVC:personalCenterVC
         tabBarTitle:@"个人中心"
      navgationTitle:@"个人中心"
           imageName:@"tabbar_profile"
   selectedImageName:@"tabbar_profile_selected"];
    
    LQMoreVC *moreVC = [[LQMoreVC alloc] init];
    [self addChildVC:moreVC
         tabBarTitle:@"更多"
      navgationTitle:@"更多"
           imageName:@"tabbar_profile"
   selectedImageName:@"tabbar_profile_selected"];
    
}

/**
 *  添加子控制器
 *
 *  @param childVC           子控制器
 *  @param tabBarTitle       tabBar标题
 *  @param navgationTitle    导航栏标题
 *  @param imageName         tabBar默认图片名称
 *  @param selectedImageName tabBar选中图片名称
 */
- (void)addChildVC:(UIViewController *)childVC tabBarTitle:(NSString *)tabBarTitle navgationTitle:(NSString *)navgationTitle imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    LQNavigationController *childNav = [[LQNavigationController alloc] initWithRootViewController:childVC];
    [childNav.tabBarItem setTitlePositionAdjustment:UIOffsetMake(-5, -5)];
    [childNav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    childNav.tabBarItem.title        = tabBarTitle;
    childVC.navigationItem.title     = navgationTitle;
    childNav.tabBarItem.image        = [UIImage imageNamed:imageName];
//    childNav.tabBarItem.badgeValue = @"10";
    
    //住tabbar对图片在进行渲染
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage          = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childNav.tabBarItem.selectedImage = selectedImage;
    
    [self addChildViewController:childNav];
}

@end
