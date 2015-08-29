//
//  LQNewsListVC.m
//  美发沙龙网
//
//  Created by admin on 15/8/8.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQNewsListVC.h"
#import "LQInformationTableViewCell.h"
#import "LQNewsList.h"
#import "LQNewsListContent.h"
#import "LQNewsWebVC.h"
#import "LQVideoPlayerVC.h"
#import "LQMallVC.h"

@interface LQNewsListVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *newsListArray;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) LQNewsList *newsList;
@property (nonatomic, assign) int pagesize;

@end

@implementation LQNewsListVC

- (void)setClassid:(NSString *)classid
{
    _classid = classid;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.pagesize = 1;
    
    [self doLoading];
}

- (void)doLoading
{
    //获取存储的数据
    YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:SQL_Name];
    NSString *tableName = @"NewsList";
    NSString *key = self.classid;
    [store createTableWithName:tableName];
    NSString *str = [store getStringById:key fromTable:tableName];
    self.newsList = [LQNewsList objectWithKeyValues:str];
    self.newsListArray = [NSMutableArray arrayWithArray:self.newsList.data];
    
    CGFloat x              = 0;
    CGFloat y              = Navigation_Height;
    CGFloat width          = self.view.width;
    CGFloat height         = LQScreen_Height - y;
    CGRect frame           = CGRectMake(x, y, width, height);
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame        = frame;
    tableView.delegate     = self;
    tableView.dataSource   = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshTableView)];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshTableViewMore)];
    
    [self.tableView.footer noticeNoMoreData];
    
    if (!self.newsList)
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    
    [self RequsetNewsList];
    
}

- (void)refreshTableView
{
    self.pagesize = 1;
    [self RequsetNewsList];
}

- (void)refreshTableViewMore
{
    if (self.newsListArray.count >= self.pagesize*20)
    {
        self.pagesize ++;
        
        [self RequsetNewsList];
        [self.tableView.footer endRefreshing];
    }
    else
    {
        [self.tableView.footer noticeNoMoreData];
    }
    
}

#pragma mark - 网络请求
- (void)RequsetNewsList
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr = @"http://old.meifashalong.com/e/api/getNewsList.php";
    NSDictionary *parameters = @{@"classid":self.classid,@"pageSize":@"20",@"pageIndex":[NSNumber numberWithInt:self.pagesize]};
    
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        YTKKeyValueStore *store = [[YTKKeyValueStore alloc] initDBWithName:SQL_Name];
        NSString *tableName = @"NewsList";
        NSString *key = self.classid;
        [store createTableWithName:tableName];
        [store putString:operation.responseString withId:key intoTable:tableName];
    
        self.newsList = [LQNewsList objectWithKeyValues:operation.responseString];
        
        if (self.pagesize == 1)
        {
            [self.newsListArray removeAllObjects];
            self.newsListArray = [NSMutableArray arrayWithArray:self.newsList.data];
        }
        else
        {
            [self.newsListArray addObjectsFromArray:self.newsList.data];
        }
        
        [self.tableView reloadData];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        [self.tableView.header endRefreshing];
        [self.tableView.footer resetNoMoreData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LQLog(@"请求失败%@",error);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        [self.tableView.header endRefreshing];
        
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


@end
