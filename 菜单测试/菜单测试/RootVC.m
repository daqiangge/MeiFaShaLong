//
//  RootVC.m
//  菜单测试
//
//  Created by admin on 15/7/20.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "RootVC.h"
#import "MeunVC.h"
#import "ViewController.h"

@interface RootVC ()

@end

@implementation RootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.peakAmount = 250;
    self.topViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    self.leftSideViewController = [[MeunVC alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
