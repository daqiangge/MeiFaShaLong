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
    
    self.view.backgroundColor = Meun_BackgroundColor;
    
    [self doLoading];
    
}

- (void)doLoading
{
    self.meunTableView.hidden = false;
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
//    [self.meunTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//    [self setCellTitleLableTextColor:self.meunTableView indexPath:indexPath textColor:[UIColor blackColor]];
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
    static NSString *identifier = @"LQMeunTableViewCell";
    LQMeunTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LQMeunTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"meunTableview_background"]];
    }
    
    NSArray *meunTitleArray = MeunTitleArray;
    cell.titleLable.text = meunTitleArray[indexPath.row];
    cell.titleLable.textColor = [UIColor whiteColor];
    
    if ([indexPath isEqual:[self.meunTableView indexPathForSelectedRow]])
    {
        cell.titleLable.textColor = [UIColor blackColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setCellTitleLableTextColor:tableView indexPath:indexPath textColor:[UIColor blackColor]];
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setCellTitleLableTextColor:tableView indexPath:indexPath textColor:[UIColor blackColor]];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setCellTitleLableTextColor:tableView indexPath:indexPath textColor:[UIColor whiteColor]];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setCellTitleLableTextColor:tableView indexPath:indexPath textColor:[UIColor whiteColor]];
}

- (void)setCellTitleLableTextColor:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath textColor:(UIColor *)color
{
    LQMeunTableViewCell *cell = (LQMeunTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.titleLable.textColor = color;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *headerView = [[UIView alloc] init];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (37 * LQScreen_Width)/320;
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
