//
//  LQInformationVC.m
//  美发沙龙网
//
//  Created by admin on 15/7/22.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQInformationVC.h"
#import "LZAutoScrollView.h"
#import "LQInformationBtnGroupView.h"
#import "LQInformationTableViewCell.h"
#import "LQNewsClass.h"
#import "LQNewsList.h"
#import "LQNewsListContent.h"
#import "LQNewsListVC.h"
#import "LQNewsWebVC.h"
#import "LQVideoPlayerVC.h"
#import "LQSearchController.h"
#import "AppDelegate.h"
#import "LQMallVC.h"
#import "LQAdvertisements.h"
#import "LQAdvertisement.h"

@interface LQInformationVC ()<UITableViewDataSource,UITableViewDelegate,LQInformationBtnGroupViewDelegate,UISearchBarDelegate,LZAutoScrollViewDelegate>

@property (nonatomic, weak) LZAutoScrollView *homeRollingView;
@property (nonatomic, weak) UIView *searchBarBsckgroundView;
@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, weak) LQInformationBtnGroupView *btnGroupView;
@property (nonatomic, weak) UITableView *informationTableView;
@property (nonatomic, strong) NSMutableArray *newsListArray;
@property (nonatomic, strong) LQNewsList *newsList;
@property (nonatomic, strong) LQNewsClass *newsClass;
@property (nonatomic, strong) YTKKeyValueStore *store;

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
//        searchBar.showsCancelButton = YES;
        searchBar.delegate = self;
        [searchBar setBackgroundImage:[UIImage imageNamed:@"navigationBar_background"]];
        [searchBar setSearchFieldBackgroundImage:[[[UIImage alloc] init] imageWithColor:SearchBar_SeachTextField_BackgroundColor size:CGSizeMake(100, 30) cornerRadius:4.0] forState:UIControlStateNormal];
        [searchBar setContentMode:UIViewContentModeLeft];
        [self.searchBarBsckgroundView addSubview:searchBar];
        
        _searchBar = searchBar;
    }
    
    return _searchBar;
}

- (LZAutoScrollView *)homeRollingView
{
    if (_homeRollingView == nil)
    {
        CGFloat x                          = 0;
        CGFloat y                          = CGRectGetMaxY(self.searchBarBsckgroundView.frame);
        CGFloat width                      = LQScreen_Width;
        CGFloat height                     = (130 * LQScreen_Width)/320;
        CGRect frame                       = CGRectMake(x, y, width, height);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = [UIImage imageNamed:@"placehodeImage"];
        [self.view addSubview:imageView];

        LZAutoScrollView *homeRollingView = [[LZAutoScrollView alloc] initWithFrame:frame];
        homeRollingView.delegate = self;
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
        LQInformationBtnGroupView *btnGroupView = [LQInformationBtnGroupView informationBtnGroupViewWithFrame:CGRectZero];
        btnGroupView.btnGroupViewDelegate = self;
        [self.view addSubview:btnGroupView];
        
        [btnGroupView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.homeRollingView.mas_bottom);
            make.left.and.right.equalTo(self.view);
            make.height.equalTo(@10);
        }];
        
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

        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate     = self;
        tableView.dataSource   = self;
        [self.view addSubview:tableView];
        
        //设置tableview的分割线
        if([tableView respondsToSelector:@selector(setSeparatorInset:)])
        {
            [tableView setSeparatorInset:UIEdgeInsetsMake(0,12.5,0,12.5)];
        }
        
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.btnGroupView.mas_bottom).with.offset(5);
            make.left.bottom.and.right.equalTo(self.view);
        }];
        
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
    
    self.store = [[YTKKeyValueStore alloc] initDBWithName:SQL_Name];
    
    [self doLoading];
}

- (void)doLoading
{
    UIView *backgroundView           = [[UIView alloc] init];
    backgroundView.backgroundColor   = [UIColor whiteColor];
    backgroundView.frame             = CGRectMake(0, CGRectGetMaxY(self.homeRollingView.frame), LQScreen_Width, LQScreen_Height);
    [self.view addSubview:backgroundView];

    self.searchBar.hidden            = NO;
    self.homeRollingView.hidden      = NO;
    self.btnGroupView.hidden         = NO;
    self.informationTableView.hidden = NO;
    
    [self requestAllNewsClass];
    [self requestAdvertisementPhoto];
    
}

- (void)refreshTableView
{
    [self requestGetNewsList];
}

/**
 *  获取本地的列表数据
 */
- (NSMutableArray *)getNewsListArray
{
    NSString *tableName = @"NewsList";
    NSString *key       = self.classid;
    NSString *str       = [self.store getStringById:key fromTable:tableName];
    
    self.newsList      = [LQNewsList objectWithKeyValues:str];
    self.newsListArray = [NSMutableArray arrayWithArray:self.newsList.data];
    
    return self.newsListArray;
}

- (void)setSonclassArray
{
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
}

/**
 *  保存列表数据
 */
- (void)saveNewsList:(NSString *)str
{
    NSString *tableName = @"NewsList";
    [self.store createTableWithName:tableName];
    NSString *key       = self.classid;
    [self.store putString:str withId:key intoTable:tableName];
}

/**
 *  保存列表数据
 */
- (void)saveAllNewsClass:(NSString *)str
{
    NSString *tableName = @"AllNewsClass";
    [self.store createTableWithName:tableName];
    NSString *key       = @"AllNewsClass";
    [self.store putString:str withId:key intoTable:tableName];
}

#pragma mark - 网络请求
- (void)requestAllNewsClass
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr                       = @"http://old.meifashalong.com/e/api/getNewsClass.php";
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self saveAllNewsClass:operation.responseString];
        
        self.newsClass = [LQNewsClass objectWithKeyValues:operation.responseString];
        [self setSonclassArray];
        
        self.btnGroupView.sonclassArray = self.sonclassArray;
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        
        if ([self getNewsListArray].count == 0)
        {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        }else
        {
            [self.informationTableView reloadData];
        }
        
        [self requestGetNewsList];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LQLog(@"请求失败%@",error);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
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
    
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
//         LQLog(@"%@",operation.responseString);
        
        [self.newsListArray removeAllObjects];
        
        [self saveNewsList:operation.responseString];
        
        self.newsList      = [LQNewsList objectWithKeyValues:operation.responseString];
        self.newsListArray = [NSMutableArray arrayWithArray:self.newsList.data];
        [self.informationTableView reloadData];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        [self.informationTableView.header endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LQLog(@"请求失败%@",error);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
        
        [self.informationTableView.header endRefreshing];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = HTTPRequestErrer_Text;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.5];
    }];
}

/*
 获取广告图片
 */
- (void)requestAdvertisementPhoto
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr                       = @"http://old.meifashalong.com/e/api/getNewsList.php";
    
    NSString *advertisementPhotoClassid = @"";
    
    switch ([self.classid intValue])
    {
        case 81:
            advertisementPhotoClassid = @"134";
            break;
            
        case 94:
            advertisementPhotoClassid = @"134";
            break;
            
        default:
            return;
            break;
    }
    
    NSDictionary *parameters = @{@"classid":advertisementPhotoClassid};
    
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         LQAdvertisements *advertisements = [LQAdvertisements objectWithKeyValues:operation.responseString];
         
         NSMutableArray *imageArray = [NSMutableArray array];
         NSMutableArray *titleArray = [NSMutableArray array];
         for (LQAdvertisement *advertisement in advertisements.advertisements)
         {
             [imageArray addObject:advertisement.titlepic];
             [titleArray addObject:advertisement.title];
         }
    
         self.homeRollingView.titles = titleArray;
         self.homeRollingView.images = imageArray;
         self.homeRollingView.placeHolder = [UIImage imageNamed:@"placehodeImage"];
         [self.homeRollingView createViews];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         LQLog(@"请求失败%@",error);
         
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
        videoPlayerVC.ID = newsContent.ID;
        videoPlayerVC.classid = newsContent.classid;
        [self.navigationController pushViewController:videoPlayerVC animated:YES];
        
        return;
    }
    
    if ([self.newsList.table isEqualToString:@"shop"])
    {
        LQMallVC *mallVC = [[LQMallVC alloc] init];
        mallVC.ID = newsContent.ID;
        mallVC.classid = newsContent.classid;
        mallVC.navigationItem.title = newsContent.classname;
        [self.navigationController pushViewController:mallVC animated:YES];
        
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

#pragma  mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    LQLog(@"点击了搜索");
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    LQSearchController *searchVC = [[LQSearchController alloc] init];
    LQNavigationController *nav = [[LQNavigationController alloc] initWithRootViewController:searchVC];
    [appDelegate.LeftSlideVC presentViewController:nav animated:YES completion:nil];
    
    return NO;
}

@end
