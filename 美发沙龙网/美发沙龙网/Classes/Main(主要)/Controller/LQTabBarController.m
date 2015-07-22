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

@interface LQTabBarController ()

@end

@implementation LQTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LQHomeVC *homeVC = [[LQHomeVC alloc] init];
    [self addChildVC:homeVC
         tabBarTitle:@"首页"
      navgationTitle:@"中国美发沙龙网"
           imageName:@"tabbar_home"
   selectedImageName:@"tabbar_home_selected"];
    
    LQNewRecommendVC *newRecommendVC = [[LQNewRecommendVC alloc] init];
    [self addChildVC:newRecommendVC
         tabBarTitle:@"最新"
      navgationTitle:@"中国美发沙龙网"
           imageName:@"tabbar_message_center"
   selectedImageName:@"tabbar_message_center_selected"];
    
    LQCommunityVC *communityVC = [[LQCommunityVC alloc] init];
    [self addChildVC:communityVC
         tabBarTitle:@"美发人社区"
      navgationTitle:@"中国美发沙龙网"
           imageName:@"tabbar_discover"
   selectedImageName:@"tabbar_discover_selected"];
    
    LQPersonalCenterVC *personalCenterVC = [[LQPersonalCenterVC alloc] init];
    [self addChildVC:personalCenterVC
         tabBarTitle:@"个人中心"
      navgationTitle:@"中国美发沙龙网"
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
    childVC.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255. green:arc4random()%255/255. blue:arc4random()%255/255. alpha:1];
    childVC.tabBarItem.title = tabBarTitle;
    childVC.navigationItem.title = navgationTitle;
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    
    //住tabbar对图片在进行渲染
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = selectedImage;
    
    LQNavigationController *childNav = [[LQNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:childNav];
}

@end
