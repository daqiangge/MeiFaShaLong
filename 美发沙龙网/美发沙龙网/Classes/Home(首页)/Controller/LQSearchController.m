//
//  LQSearchController.m
//  美发沙龙网
//
//  Created by admin on 15/8/26.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQSearchController.h"
#import "LQInformationTableViewCell.h"

@interface LQSearchController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation LQSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    [self doLoading];
}

- (void)doLoading
{
    UIButton *cancleBtn = [[UIButton alloc] init];
    cancleBtn.frame = CGRectMake(LQScreen_Width-50, 20, 50, 44);
    cancleBtn.backgroundColor = [UIColor clearColor];
    [cancleBtn setTitleColor:RGB(96, 170, 244) forState:UIControlStateNormal];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancleBtn];
    
    UISearchBar *searchBar      = [[UISearchBar alloc] init];
    searchBar.frame             = CGRectMake(0, 20, LQScreen_Width - CGRectGetWidth(cancleBtn.frame), 44);
    searchBar.placeholder       = @"搜索栏目内容";
    searchBar.showsCancelButton = NO;
    searchBar.delegate          = self;
    [searchBar setBackgroundImage:[UIImage imageNamed:@"navigationBar_background"]];
    [searchBar setSearchFieldBackgroundImage:[[[UIImage alloc] init] imageWithColor:SearchBar_SeachTextField_BackgroundColor size:CGSizeMake(100, 30) cornerRadius:4.0] forState:UIControlStateNormal];
    [searchBar setContentMode:UIViewContentModeLeft];
    [self.view addSubview:searchBar];
    self.searchBar = searchBar;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [searchBar becomeFirstResponder];
    });
    
    UITableView *tablewView = [[UITableView alloc] init];
    tablewView.frame = CGRectMake(0, CGRectGetMaxY(searchBar.frame), LQScreen_Width, LQScreen_Height-CGRectGetMaxY(searchBar.frame));
    tablewView.delegate = self;
    tablewView.dataSource = self;
    [self.view addSubview:tablewView];
    self.tableView = tablewView;
}

- (void)cancelBtnClick
{
    [self.searchBar resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQInformationTableViewCell *cell = [LQInformationTableViewCell cellWithTableView:tableView];
//    cell.listContent = self.newsListArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}

@end
