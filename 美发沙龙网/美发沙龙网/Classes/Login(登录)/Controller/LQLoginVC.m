//
//  LQLoginVC.m
//  美发沙龙网
//
//  Created by admin on 15/8/3.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQLoginVC.h"
#import "LQRegisteredAccountVC.h"

@interface LQLoginVC ()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LQLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor blackColor];
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

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registeredAccount
{
    LQRegisteredAccountVC *registeredAccountVC = [[LQRegisteredAccountVC alloc] init];
    [self.navigationController pushViewController:registeredAccountVC animated:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
