//
//  LQLeftMeunVC.m
//  美发沙龙网
//
//  Created by admin on 15/7/21.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQLeftMeunVC.h"

@interface LQLeftMeunVC ()

@end

@implementation LQLeftMeunVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)doLoading
{
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar_message_center_selected"]];
    [self.view addSubview:iconImageView];
}

@end
