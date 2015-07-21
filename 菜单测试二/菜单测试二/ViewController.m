//
//  ViewController.m
//  菜单测试二
//
//  Created by admin on 15/7/21.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "ViewController.h"
#import "MFSideMenuContainerViewController.h"
#import "MeunVC.h"
#import "OneVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

/**
 *  登陆操作
 */
- (IBAction)doLoging:(id)sender
{
    MeunVC *meunVC = [[MeunVC alloc] init];
    UINavigationController *oneVCNav = [[UINavigationController alloc]
                                        initWithRootViewController:[[OneVC alloc] init]];
    MFSideMenuContainerViewController *mfMeun = [MFSideMenuContainerViewController
                                                 containerWithCenterViewController:oneVCNav
                                                 leftMenuViewController:meunVC
                                                 rightMenuViewController:nil];
    [self presentViewController:mfMeun animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
