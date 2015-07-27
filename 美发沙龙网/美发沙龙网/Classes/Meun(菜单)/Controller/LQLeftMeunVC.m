//
//  LQLeftMeunVC.m
//  美发沙龙网
//
//  Created by admin on 15/7/21.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQLeftMeunVC.h"
#import "LQMeunTableViewCell.h"

#define MeunTitleArray (@[@"美业资讯",@"美发技术",@"发廊经营",@"发现图片",@"求职招聘",@"美发视频",@"免费视频",@"美发商城",@"美发人社区",@"每日正能量"])

@interface LQLeftMeunVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *nameBackgroundView;
@property (nonatomic, weak) UITableView *meunTableView;

@end

@implementation LQLeftMeunVC

- (UITableView *)meunTableView
{
    if (_meunTableView == nil)
    {
        CGFloat x = 0;
        CGFloat y = CGRectGetMaxY(self.nameBackgroundView.frame);
        CGFloat width = LQScreen_Width;
        CGFloat height = LQScreen_Height - CGRectGetMaxY(self.nameBackgroundView.frame)-10;
        CGRect frame = CGRectMake(x, y, width, height);
        
        UITableView *meunTableView = [[UITableView alloc] init];
        meunTableView.frame = frame;
        meunTableView.backgroundColor = self.view.backgroundColor;
        meunTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        meunTableView.delegate = self;
        meunTableView.dataSource = self;
        [self.view addSubview:meunTableView];
        self.meunTableView = meunTableView;
    }
    
    return _meunTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self doLoading];
    
}

- (void)doLoading
{
    NSString *identifier = @"LQMeunTableViewCell";
    UINib *nib = [UINib nibWithNibName:@"LQMeunTableViewCell" bundle:nil];
    [self.meunTableView registerNib:nib forCellReuseIdentifier:identifier];
}

#pragma mark - TableViewDelegate&DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQMeunTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LQMeunTableViewCell"];
    
    NSArray *meunTitleArray = MeunTitleArray;
    cell.titleLable.text = meunTitleArray[indexPath.row];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *headerView = [[UIView alloc] init];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 37;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

@end
