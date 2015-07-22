//
//  LQHomeVC.m
//  美发沙龙网
//
//  Created by admin on 15/7/21.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQHomeVC.h"
#import "LQHomeModularView.h"
#import "LQHomeRollingScrollView.h"

@interface LQHomeVC ()

@property (weak, nonatomic) IBOutlet LQHomeRollingScrollView *homeRollingScrollView;
@property (weak, nonatomic) IBOutlet LQHomeModularView *homeModularView;

@end

@implementation LQHomeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self doLoading];
}

- (void)doLoading
{
    [self.homeRollingScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(64);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.equalTo(@150);
    }];
    
    [self.homeModularView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.homeRollingScrollView.mas_bottom).with.offset(0);
        make.left.equalTo(self.homeRollingScrollView.mas_left).with.offset(0);
        make.right.equalTo(self.homeRollingScrollView.mas_right).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-49);
    }];
}

@end
