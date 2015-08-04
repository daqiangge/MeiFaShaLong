//
//  LQRegisteredAccountVC.m
//  美发沙龙网
//
//  Created by admin on 15/8/3.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQRegisteredAccountVC.h"

@interface LQRegisteredAccountVC ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LQRegisteredAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"注册";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishRegistered)];
}

- (void)finishRegistered
{
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
