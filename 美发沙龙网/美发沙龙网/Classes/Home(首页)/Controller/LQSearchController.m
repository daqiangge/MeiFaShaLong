//
//  LQSearchController.m
//  美发沙龙网
//
//  Created by admin on 15/8/26.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQSearchController.h"
#import "LQInformationTableViewCell.h"
#import "LQNewsList.h"
#import "LQNewsWebVC.h"
#import "LQVideoPlayerVC.h"

@interface LQSearchController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *newsListArray;
@property (nonatomic, strong) LQNewsList *newsList;

@end

@implementation LQSearchController

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
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    
    [self doLoading];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
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
    [[UITextField appearanceWhenContainedIn:[searchBar class], nil] setTextColor:[UIColor whiteColor]];
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
    if (self.newsListArray.count != 0)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self searchRequest];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
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
        newWebVC.navigationController.navigationBarHidden = NO;
        
        return;
    }
    
    if ([self.newsList.table isEqualToString:@"movie"])
    {
        LQVideoPlayerVC *videoPlayerVC = [[LQVideoPlayerVC alloc] init];
        [self.navigationController pushViewController:videoPlayerVC animated:YES];
        videoPlayerVC.navigationController.navigationBarHidden = NO;
        
        return;
    }
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}

#pragma mark - 网络请求
- (void)searchRequest
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr                       = @"http://old.meifashalong.com/e/api/getNewsList.php";
    NSDictionary *parameters               = @{@"classid":@"58",@"pageSize":@"20"};
    
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.newsListArray removeAllObjects];
        
        self.newsList      = [LQNewsList objectWithKeyValues:operation.responseString];
        self.newsListArray = [NSMutableArray arrayWithArray:self.newsList.data];
        [self.tableView reloadData];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LQLog(@"请求失败%@",error);
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = HTTPRequestErrer_Text;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.5];
    }];
}

@end
