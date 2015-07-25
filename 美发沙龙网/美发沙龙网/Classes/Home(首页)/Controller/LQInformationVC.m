//
//  LQInformationVC.m
//  美发沙龙网
//
//  Created by admin on 15/7/22.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQInformationVC.h"
#import "LQHomeRollingView.h"

#define SearchBar_SeachTextField_BackgroundColor ([UIColor colorWithRed:59/255. green:59/255. blue:59/255. alpha:1])

@interface LQInformationVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (weak, nonatomic) IBOutlet UIPageControl *abx;
@property (nonatomic, weak) LQHomeRollingView *homeRollingView;
@property (nonatomic, weak) UIView *searchBarBsckgroundView;
@property (nonatomic, weak) UISearchBar *searchBar;

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
        [searchBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background_transparent"]];
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
        CGFloat height = (130 * LQScreen_Width)/320;
        CGRect frame = CGRectMake(x, y, width, height);
        
        LQHomeRollingView *homeRollingView = [LQHomeRollingView homeRollingViewWithFrame:frame];
        [self.view addSubview:homeRollingView];
        _homeRollingView = homeRollingView;
        
    }
    
    return _homeRollingView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"menu-icon" selectedImageName:@"menu-icon" target:self action:@selector(openMeun)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"navigationbar_pop" selectedImageName:@"navigationbar_pop_highlighted" target:self action:@selector(refresh)];
    
    [self doLoading];
    
}

- (void)doLoading
{
    self.searchBar.hidden = NO;
    self.homeRollingView.hidden = NO;
    
    
}

- (void)openMeun
{
    LQLog(@"打开菜单");
}

- (void)refresh
{
    LQLog(@"刷新。。。");
}

@end
