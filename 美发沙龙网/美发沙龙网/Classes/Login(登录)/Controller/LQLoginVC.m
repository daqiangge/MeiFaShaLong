//
//  LQLoginVC.m
//  美发沙龙网
//
//  Created by admin on 15/8/3.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQLoginVC.h"

#define loginButton_backgroundColor ([UIColor colorWithRed:230/255. green:74/255. blue:94/255. alpha:1])

@interface LQLoginVC ()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LQLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"登录";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registeredAccount)];
    
    [self doLoading];
}

- (void)doLoading
{
    self.loginButton.backgroundColor    = loginButton_backgroundColor;
    self.loginButton.layer.borderColor  = [UIColor clearColor].CGColor;
    self.loginButton.layer.borderWidth  = Layer_BorderWidth;
    self.loginButton.layer.cornerRadius = Layer_CornerRadius;
}

- (void)registeredAccount
{

}

@end
