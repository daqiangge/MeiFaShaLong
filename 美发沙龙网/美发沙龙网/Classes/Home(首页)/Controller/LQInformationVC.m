//
//  LQInformationVC.m
//  美发沙龙网
//
//  Created by admin on 15/7/22.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQInformationVC.h"
#import "LQHomeRollingView.h"
#import "LQInformationBtnGroupView.h"
#import "LQInformationTableViewCell.h"

#define SearchBar_SeachTextField_BackgroundColor ([UIColor colorWithRed:59/255. green:59/255. blue:59/255. alpha:1])

@interface LQInformationVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) LQHomeRollingView *homeRollingView;
@property (nonatomic, weak) UIView *searchBarBsckgroundView;
@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, weak) LQInformationBtnGroupView *btnGroupView;
@property (nonatomic, weak) UITableView *informationTableView;

@end

@implementation LQInformationVC

- (UIView *)searchBarBsckgroundView
{
    if (_searchBarBsckgroundView == nil)
    {
        UIView *searchBarBsckgroundView = [[UIView alloc] init];
        searchBarBsckgroundView.frame = CGRectMake(0, 0, LQScreen_Width, 105);
        searchBarBsckgroundView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:searchBarBsckgroundView];
        _searchBarBsckgroundView = searchBarBsckgroundView;
    }
    
    return _searchBarBsckgroundView;
}

- (UISearchBar *)searchBar
{
    if (_searchBar == nil)
    {
        UISearchBar *searchBar = [[UISearchBar alloc] init];
        searchBar.frame = CGRectMake(0, 58, LQScreen_Width, 44);
        [searchBar setBackgroundImage:[UIImage imageNamed:@"navigationBar_background"]];
        [searchBar setSearchFieldBackgroundImage:[[[UIImage alloc] init] imageWithColor:SearchBar_SeachTextField_BackgroundColor size:CGSizeMake(100, 30) cornerRadius:4.0] forState:UIControlStateNormal];
        searchBar.placeholder = @"搜索栏目内容";
        [searchBar setContentMode:UIViewContentModeLeft];
        [self.searchBarBsckgroundView addSubview:searchBar];
    }
    
    return _searchBar;
}

- (LQHomeRollingView *)homeRollingView
{
    if (_homeRollingView == nil)
    {
        CGFloat x = 0;
        CGFloat y = CGRectGetMaxY(self.searchBarBsckgroundView.frame);
        CGFloat width = LQScreen_Width;
        CGFloat height = (145 * LQScreen_Width)/320;
        CGRect frame = CGRectMake(x, y, width, height);
        
        LQHomeRollingView *homeRollingView = [LQHomeRollingView homeRollingViewWithFrame:frame];
        [self.view addSubview:homeRollingView];
        _homeRollingView = homeRollingView;
        
    }
    
    return _homeRollingView;
}

- (LQInformationBtnGroupView *)btnGroupView
{
    if (_btnGroupView == nil)
    {
        CGFloat x = 0;
        CGFloat y = CGRectGetMaxY(self.homeRollingView.frame);
        CGFloat width = LQScreen_Width;
        CGFloat height = 45;
        CGRect frame = CGRectMake(x, y, width, height);
        
        LQInformationBtnGroupView *btnGroupView = [LQInformationBtnGroupView informationBtnGroupViewWithFrame:frame];
        [self.view addSubview:btnGroupView];
        _btnGroupView = btnGroupView;
    }
    
    return _btnGroupView;
}

- (UITableView *)informationTableView
{
    if (_informationTableView == nil)
    {
        CGFloat x = 0;
        CGFloat y = CGRectGetMaxY(self.btnGroupView.frame);
        CGFloat width = CGRectGetWidth(self.btnGroupView.frame);
        CGFloat height = LQScreen_Height - y;
        CGRect frame = CGRectMake(x, y, width, height);
        
        UITableView *tableView = [[UITableView alloc] init];
        tableView.frame = frame;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        _informationTableView = tableView;
    }
    
    return _informationTableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self doLoading];
}

- (void)doLoading
{
    self.searchBar.hidden = NO;
    self.homeRollingView.hidden = NO;
    self.btnGroupView.hidden = NO;
    
    //给tableview注册一个cell模板
    NSString *identifer=@"LQInformationTableViewCell";
    UINib *nib=[UINib nibWithNibName:@"LQInformationTableViewCell" bundle:nil];
    [self.informationTableView registerNib:nib forCellReuseIdentifier:identifer];
    
    //设置tableview的分割线
    if([self.informationTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.informationTableView setSeparatorInset:UIEdgeInsetsMake(0,15,0,15)];
        
//        [self.informationTableView setSeparatorColor:[UIColor redColor]];
    }

}

- (void)openMeun
{
    LQLog(@"打开菜单");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refresh
{
    LQLog(@"刷新。。。");
}

#pragma mark - TableViewDelegate&DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LQInformationTableViewCell"];
    
    [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img.firefoxchina.cn/2015/07/5/201507300849040.jpg"] placeholderImage:[UIImage imageNamed:@"123"] options:SDWebImageRetryFailed];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

@end
