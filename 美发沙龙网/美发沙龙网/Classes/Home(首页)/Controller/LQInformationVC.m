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
#import "LQVideoPlayerVC.h"

#define SearchBar_SeachTextField_BackgroundColor ([UIColor colorWithRed:59/255. green:59/255. blue:59/255. alpha:1])

@interface LQInformationVC ()<UITableViewDataSource,UITableViewDelegate,LQInformationBtnGroupViewDelegate>

@property (nonatomic, weak) LQHomeRollingView *homeRollingView;
@property (nonatomic, weak) UIView *searchBarBsckgroundView;
@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, weak) LQInformationBtnGroupView *btnGroupView;
@property (nonatomic, weak) UITableView *informationTableView;
@property (nonatomic, strong) NSMutableArray *newsListArray;
@property (nonatomic, strong) LQNewsList *newsList;
@property (nonatomic, strong) LQNewsClass *newsClass;

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
        searchBar.frame        = CGRectMake(0, 58, LQScreen_Width, 44);
        searchBar.placeholder  = @"搜索栏目内容";
        [searchBar setBackgroundImage:[UIImage imageNamed:@"navigationBar_background"]];
        [searchBar setSearchFieldBackgroundImage:[[[UIImage alloc] init] imageWithColor:SearchBar_SeachTextField_BackgroundColor size:CGSizeMake(100, 30) cornerRadius:4.0] forState:UIControlStateNormal];
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
        
        //设置tableview的分割线
        if([tableView respondsToSelector:@selector(setSeparatorInset:)])
        {
            [tableView setSeparatorInset:UIEdgeInsetsMake(0,12.5,0,12.5)];
        }
        
        tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshTableView)];
        
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

    self.view.backgroundColor = [UIColor blackColor];
    
    [self doLoading];
}

- (void)doLoading
{
    self.searchBar.hidden       = NO;
    self.homeRollingView.hidden = NO;
    
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.frame = CGRectMake(0, CGRectGetMaxY(self.homeRollingView.frame), LQScreen_Width, LQScreen_Height);
    [self.view addSubview:backgroundView];
    
    [self requestAllNewsClass];

}

- (void)refreshTableView
{
    [self requestGetNewsList];
}

#pragma mark - 网络请求
- (void)requestAllNewsClass
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr                       = @"http://old.meifashalong.com/e/api/getNewsClass.php";
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.newsClass = [LQNewsClass objectWithKeyValues:operation.responseString];
        
        switch ([self.classid intValue])
        {
            case 58:
                self.sonclassArray = self.newsClass.data.newsClassId_58.sonclass;
                break;
                
            case 62:
                self.sonclassArray = self.newsClass.data.newsClassId_62.sonclass;
                break;
                
            case 74:
                self.sonclassArray = self.newsClass.data.newsClassId_74.sonclass;
                break;
                
            case 81:
                self.sonclassArray = self.newsClass.data.newsClassId_81.sonclass;
                break;
                
            case 94:
                self.sonclassArray = self.newsClass.data.newsClassId_94.sonclass;
                break;
                
            case 107:
                self.sonclassArray = self.newsClass.data.newsClassId_107.sonclass;
                break;
        }
        
        [hud hide:YES];
        
        self.btnGroupView.hidden    = NO;
        self.informationTableView.hidden = NO;
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [self requestGetNewsList];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LQLog(@"请求失败%@",error);
        
        hud.labelText = HTTPRequestErrer_Text;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.5];
    }];
}

- (void)requestGetNewsList
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr                       = @"http://old.meifashalong.com/e/api/getNewsList.php";
    NSDictionary *parameters               = @{@"classid":self.classid,@"pageSize":@"10"};
    
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.newsListArray removeAllObjects];
        
        self.newsList      = [LQNewsList objectWithKeyValues:operation.responseString];
        self.newsListArray = [NSMutableArray arrayWithArray:self.newsList.data];
        [self.informationTableView reloadData];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        [self.informationTableView.header endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LQLog(@"请求失败%@",error);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        [self.informationTableView.header endRefreshing];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = HTTPRequestErrer_Text;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.5];
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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    LQNewsListContent *newsContent = self.newsListArray[indexPath.row];
    
    if ([self.newsList.table isEqualToString:@"news"])
    {
        LQNewsWebVC *newWebVC = [[LQNewsWebVC alloc] init];
        newWebVC.ID = newsContent.ID;
        newWebVC.classid = newsContent.classid;
        newWebVC.navigationItem.title = newsContent.classname;
        [self.navigationController pushViewController:newWebVC animated:YES];
        
        return;
    }
    
    if ([self.newsList.table isEqualToString:@"movie"])
    {
        LQVideoPlayerVC *videoPlayerVC = [[LQVideoPlayerVC alloc] init];
        [self.navigationController pushViewController:videoPlayerVC animated:YES];
        
        return;
    }
    
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
