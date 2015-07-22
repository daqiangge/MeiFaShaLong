//
//  LQHomeVC.m
//  美发沙龙网
//
//  Created by admin on 15/7/21.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQHomeVC.h"

@interface LQHomeVC ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

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
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(64);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.equalTo(@150);
    }];
    
}

@end
