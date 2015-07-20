//
//  ViewController.m
//  菜单测试
//
//  Created by admin on 15/7/20.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blueColor];
    
    UIButton *vv = [[UIButton alloc] init];
    vv.frame = CGRectMake(100, [UIScreen mainScreen].bounds.size.height-101, 100, 100);
    vv.backgroundColor = [UIColor redColor];
    [vv addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:vv];
    
}

- (void)aaa
{
    ViewController *vc = [[ViewController alloc] init];
    vc.view.backgroundColor = [UIColor greenColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
