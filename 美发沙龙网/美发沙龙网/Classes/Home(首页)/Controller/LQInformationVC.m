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
#import "LQNewsClass.h"
#import "LQNewsList.h"
#import "LQNewsListContent.h"
#import "LQNewsListVC.h"
#import "LQNewsWebVC.h"

#define SearchBar_SeachTextField_BackgroundColor ([UIColor colorWithRed:59/255. green:59/255. blue:59/255. alpha:1])

@interface LQInformationVC ()<UITableViewDataSource,UITableViewDelegate,LQInformationBtnGroupViewDelegate>

@property (nonatomic, weak) LQHomeRollingView *homeRollingView;
@property (nonatomic, weak) UIView *searchBarBsckgroundView;
@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, weak) LQInformationBtnGroupView *btnGroupView;
@property (nonatomic, weak) UITableView *informationTableView;
@property (nonatomic, strong) NSMutableArray *newsListArray;

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
        CGFloat x                          = 0;
        CGFloat y                          = CGRectGetMaxY(self.searchBarBsckgroundView.frame);
        CGFloat width                      = LQScreen_Width;
        CGFloat height                     = (145 * LQScreen_Width)/320;
        CGRect frame                       = CGRectMake(x, y, width, height);

        LQHomeRollingView *homeRollingView = [LQHomeRollingView homeRollingViewWithFrame:frame];
        [self.view addSubview:homeRollingView];
        _homeRollingView                   = homeRollingView;
        
    }
    
    return _homeRollingView;
}

/**
 *  按钮组
 */
- (LQInformationBtnGroupView *)btnGroupView
{
    if (_btnGroupView == nil)
    {
        CGFloat x                               = 0;
        CGFloat y                               = CGRectGetMaxY(self.homeRollingView.frame);
        CGFloat width                           = LQScreen_Width;
        CGFloat height                          = 0;
        CGRect frame                            = CGRectMake(x, y, width, height);

        LQInformationBtnGroupView *btnGroupView = [LQInformationBtnGroupView informationBtnGroupViewWithFrame:frame];
        btnGroupView.sonclassArray = self.sonclassArray;
        btnGroupView.btnGroupViewDelegate = self;
        [self.view addSubview:btnGroupView];
        _btnGroupView                           = btnGroupView;
    }
    
    return _btnGroupView;
}

- (NSMutableArray *)newsListArray
{
    if (_newsListArray == nil)
    {
        NSMutableArray *array = [NSMutableArray array];
        
        _newsListArray = array;
    }
    
    return _newsListArray;
}

- (UITableView *)informationTableView
{
    if (_informationTableView == nil)
    {
        CGFloat x              = 0;
        CGFloat y              = CGRectGetMaxY(self.btnGroupView.frame);
        CGFloat width          = CGRectGetWidth(self.btnGroupView.frame);
        CGFloat height         = LQScreen_Height - y;
        CGRect frame           = CGRectMake(x, y, width, height);

        UITableView *tableView = [[UITableView alloc] init];
        tableView.frame        = frame;
        tableView.delegate     = self;
        tableView.dataSource   = self;
        [self.view addSubview:tableView];
        _informationTableView  = tableView;
    }
    
    return _informationTableView;
}

- (void)setClassid:(NSString *)classid
{
    _classid = classid;
}

- (void)setSonclassArray:(NSArray *)sonclassArray
{
    _sonclassArray = sonclassArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self doLoading];
//    [self requestGetNewClass];
    [self requestGetNewsList];
}

- (void)doLoading
{
    self.searchBar.hidden       = NO;
    self.homeRollingView.hidden = NO;
    self.btnGroupView.hidden    = NO;

    //设置tableview的分割线
    if([self.informationTableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.informationTableView setSeparatorInset:UIEdgeInsetsMake(0,12.5,0,12.5)];
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

#pragma mark - 网络请求
- (void)requestGetNewClass
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr = @"http://old.meifashalong.com/e/api/getNewsClass.php";
    NSDictionary *parameters = @{@"bclassid":@"58"};
    
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSData *jsonData = [operation.responseString dataUsingEncoding:NSASCIIStringEncoding];
//        NSError *error;
//        NSDictionary *resultDic = [[CJSONDeserializer deserializer] deserialize:jsonData error:&error];
        
        LQNewsClass *newsClass = [LQNewsClass objectWithKeyValues:operation.responseString];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LQLog(@"请求失败%@",error);
    }];
}

- (void)requestGetNewsList
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr = @"http://old.meifashalong.com/e/api/getNewsList.php";
    NSDictionary *parameters = @{@"classid":self.classid,@"pageSize":@"10"};
    
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        LQNewsList *newsList = [LQNewsList objectWithKeyValues:operation.responseString];
        self.newsListArray = [NSMutableArray arrayWithArray:newsList.data];
        [self.informationTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LQLog(@"请求失败%@",error);
    }];
}

#pragma mark - TableViewDelegate&DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQInformationTableViewCell *cell = [LQInformationTableViewCell cellWithTableView:tableView];
    cell.listContent = self.newsListArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LQNewsListContent *newsContent = self.newsListArray[indexPath.row];
    
    LQNewsWebVC *newWebVC = [[LQNewsWebVC alloc] init];
    newWebVC.urlStr = newsContent.titleurl;
    newWebVC.navigationItem.title = newsContent.classname;
    [self.navigationController pushViewController:newWebVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

#pragma mark - LQInformationBtnGroupViewDelegate
- (void)InformationBtnGroupViewDidClickBtnWithView:(LQInformationBtnGroupView *)btnGroupView btn:(UIButton *)btn
{
    LQNewsListVC *newsListVC = [[LQNewsListVC alloc] init];
    newsListVC.classid = [NSString stringWithFormat:@"%ld",btn.tag];
    newsListVC.navigationItem.title = btn.titleLabel.text;
    [self.navigationController pushViewController:newsListVC animated:YES];
}

@end
