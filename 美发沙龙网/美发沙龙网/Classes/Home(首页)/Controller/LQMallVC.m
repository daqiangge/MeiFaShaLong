//
//  LQMallVC.m
//  美发沙龙网
//
//  Created by admin on 15/8/27.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQMallVC.h"
#import "LQCommodityCell.h"
#import "LQCommodityIntroductionCell.h"
#import "LQCommodityCommentCell.h"
#import "LQCommodityCommentCellFrame.h"
#import "LQNewsWebVC.h"

@interface LQMallVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIButton *shoppingCartBtn;
@property (nonatomic, weak) UIButton *favoritesBtn;
//@property (nonatomic, strong) LQCommodityIntroductionCellFrame *commodityIntroductionCellFrame;
@property (nonatomic, strong) LQCommodityCommentCellFrame *commodityCommentCellFrame;
@property (nonatomic, strong) LQNewsContent *content;

@end

@implementation LQMallVC

- (void)setID:(NSString *)ID
{
    _ID = ID;
}

- (void)setClassid:(NSString *)classid
{
    _classid = classid;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableView.frame = CGRectMake(0,Navigation_Height, LQScreen_Width, LQScreen_Height - self.favoritesBtn.height - Navigation_Height);
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        
        _tableView = tableView;
    }
    
    return _tableView;
}

- (UIButton *)shoppingCartBtn
{
    if (!_shoppingCartBtn)
    {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(0, LQScreen_Height-50, LQScreen_Width/2, 50);
        btn.backgroundColor = RGB(228, 145, 35);
        [btn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        
        _shoppingCartBtn = btn;
    }
    
    return _shoppingCartBtn;
}

- (UIButton *)favoritesBtn
{
    if (!_favoritesBtn)
    {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(CGRectGetMaxX(self.shoppingCartBtn.frame), self.shoppingCartBtn.y, self.shoppingCartBtn.width, self.shoppingCartBtn.height);
        btn.backgroundColor = RGB(220, 80, 17);
        [btn setTitle:@"放入收藏夹" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        
        _favoritesBtn = btn;
    }
    
    return _favoritesBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self doLoading];
    [self requestCommodity];
}

- (void)doLoading
{
    self.tableView.hidden = NO;
}

#pragma mark - 网络请求
- (void)requestCommodity
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr = @"http://old.meifashalong.com/e/api/getNewsContent.php";
    NSDictionary *parameters = @{@"id":self.ID,@"classid":self.classid};
    
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.content = [LQNewsContent objectWithKeyValues:operation.responseString];
        
        [self.tableView reloadData];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LQLog(@"请求失败%@",error);
        
        hud.labelText = HTTPRequestErrer_Text;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.5];
    }];
    
    
    NSDictionary *dic = @{@"name":@"大强哥",@"content":@"环保。拥有8段水位，无论衣服多少，都有适合的水位。在保证洗干净衣服、不损伤衣物和衣服洗涤剂残留降到最低的前提下",@"iconUrl":@""};
    
    LQCommodityComment *commodityComment = [LQCommodityComment objectWithKeyValues:dic];
    
    //商品评论Model
    self.commodityCommentCellFrame = [[LQCommodityCommentCellFrame alloc] init];
    self.commodityCommentCellFrame.commodityComment = commodityComment;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        LQCommodityCell *cell = [LQCommodityCell cellWithTableView:tableView indexPath:indexPath];
        
        if (self.content) {
            cell.content = self.content;
        }
        
        return cell;
    }
    else if (indexPath.section == 1)
    {
        LQCommodityIntroductionCell *cell = [LQCommodityIntroductionCell cellWithTableView:tableView indexPath:indexPath];
        
        return cell;
    }
    else
    {
        LQCommodityCommentCell *cell = [LQCommodityCommentCell cellWithTableView:tableView indexPath:indexPath];
        cell.cellFrame = self.commodityCommentCellFrame;
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        CGFloat cellHeight = (LQScreen_Width *2)/3 + 5 + 36 + 100 + 25;
        
        return cellHeight;
    }
    else if (indexPath.section == 1)
    {
        return CellHeight;
    }
    else
    {
        return self.commodityCommentCellFrame.cellHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        LQNewsWebVC *webVC = [[LQNewsWebVC alloc] init];
        webVC.newstext = self.content.newstext;
        webVC.navigationItem.title = @"商品介绍";
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

@end
