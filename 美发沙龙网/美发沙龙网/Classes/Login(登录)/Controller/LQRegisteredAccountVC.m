//
//  LQRegisteredAccountVC.m
//  美发沙龙网
//
//  Created by admin on 15/8/3.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQRegisteredAccountVC.h"

@interface LQRegisteredAccountVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *finishRegistered;

@end

@implementation LQRegisteredAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
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
    //判断是否有未填项
    if (self.nameTextField.text.length == 0 || self.emailTextField.text.length == 0 || self.passwordTextField.text == 0)
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请填写所有信息";
        hud.labelFont = [UIFont systemFontOfSize:15];
        [hud hide:YES afterDelay:1.0];
    
        return;
    }
    
    //判断邮箱格式
    if (![[Regex shareInstance] judgeEmail:self.emailTextField.text])
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"邮箱格式错误";
        hud.labelFont = [UIFont systemFontOfSize:15];
        [hud hide:YES afterDelay:1.0];
        
        return;
    }
    
    [self registerRequest];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - 网络请求
- (void)registerRequest
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window] animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在注册。。。";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr = @"http://old.meifashalong.com/e/api/Register.php";
    NSDictionary *parameters = @{@"username":self.nameTextField.text,@"password":self.passwordTextField.text,@"email":self.emailTextField.text};
    
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation.responseString);
        
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        hud.mode = MBProgressHUDModeCustomView;
        hud.labelText = @"注册成功";
        [hud hide:YES afterDelay:1.0];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - TextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (str.length > 24)
    {
        textField.text = [string substringToIndex:24];
        
        return NO;
    }
    
    return YES;
}


@end
