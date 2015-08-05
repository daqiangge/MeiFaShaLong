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
@property (weak, nonatomic) IBOutlet UIButton *finishRegistered;

@end

@implementation LQRegisteredAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"注册";
    
    [self doLoading];
}

- (void)doLoading
{
    self.finishRegistered.backgroundColor    = loginButton_backgroundColor;
    self.finishRegistered.layer.borderColor  = [UIColor clearColor].CGColor;
    self.finishRegistered.layer.borderWidth  = Layer_BorderWidth;
    self.finishRegistered.layer.cornerRadius = Layer_CornerRadius;
}

- (IBAction)finishRegistered:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



@end
