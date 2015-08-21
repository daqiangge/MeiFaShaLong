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

@interface LQNewsListVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *newsListArray;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) LQNewsList *newsList;

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
    
    [self doLoading];
    [self RequsetNewsList];
}

- (void)doLoading
{
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
    
}

#pragma mark - 网络请求
- (void)RequsetNewsList
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr = @"http://old.meifashalong.com/e/api/getNewsList.php";
    NSDictionary *parameters = @{@"classid":self.classid,@"pageSize":@"20"};
    
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.newsList = [LQNewsList objectWithKeyValues:operation.responseString];
        self.newsListArray = [NSMutableArray arrayWithArray:self.newsList.data];
        [self.tableView reloadData];
        
        [hud hide:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LQLog(@"请求失败%@",error);
        
        [hud hide:YES];
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
    
    if ([self.newsList.table isEqualToString:@"news"])
    {
        LQNewsWebVC *newWebVC = [[LQNewsWebVC alloc] init];
        newWebVC.urlStr = newsContent.titleurl;
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
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}


@end
