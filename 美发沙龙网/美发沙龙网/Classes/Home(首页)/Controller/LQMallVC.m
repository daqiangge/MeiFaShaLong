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

@interface LQMallVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIButton *shoppingCartBtn;
@property (nonatomic, weak) UIButton *favoritesBtn;
@property (nonatomic, strong) LQCommodityIntroductionCellFrame *commodityIntroductionCellFrame;
@property (nonatomic, strong) LQCommodityCommentCellFrame *commodityCommentCellFrame;

@end

@implementation LQMallVC

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
    NSDictionary *dic = @{@"introduction":@"* 全面升级水流技术，全方位洁净空间。三维大瀑布水流。大推力冲浪波轮+无孔不锈钢内桶+强力喷瀑，洗涤时内桶水位动态快速冲高回落，强力喷瀑加速洗涤液循环，有效增强衣物翻卷，推动衣物沉浮、发散、翻滚、降低缠绕。\n*人工智能（Fuzzy)，降低衣物的磨损，根据水位的高低，自动调节 波轮的转动角度和力度，在保证洗净衣物的前提下降低磨损。\n双水位，洗涤水量和漂洗水量分别可调\n*六种全自动程序。浸泡、标准、快洗、童装、大物、自洁、水循环七种程序互相切换，满足各种衣物的洗涤需求\n*水位细分：量衣定水、节水环保。拥有8段水位，无论衣服多少，都有适合的水位。在保证洗干净衣服、不损伤衣物和衣服洗涤剂残留降到最低的前提下将水位进一步细分来达到真正节水的效果。\n*预约洗涤：24小时预约洗涤，错开用水用电高峰，方便又节省。",@"comment":@{@"name":@"大强哥",@"content":@"环保。拥有8段水位，无论衣服多少，都有适合的水位。在保证洗干净衣服、不损伤衣物和衣服洗涤剂残留降到最低的前提下",@"iconUrl":@""}};
    
    LQCommodity *commodity = [LQCommodity objectWithKeyValues:dic];
    
    //商品介绍Model
    self.commodityIntroductionCellFrame = [[LQCommodityIntroductionCellFrame alloc] init];
    self.commodityIntroductionCellFrame.commodity = commodity;
    
    //商品评论Model
    self.commodityCommentCellFrame = [[LQCommodityCommentCellFrame alloc] init];
    self.commodityCommentCellFrame.commodityComment = commodity.comment;
    
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
        
        return cell;
    }
    else if (indexPath.section == 1)
    {
        LQCommodityIntroductionCell *cell = [LQCommodityIntroductionCell cellWithTableView:tableView indexPath:indexPath];
        cell.cellFrame = self.commodityIntroductionCellFrame;
        
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
        CGFloat cellHeight = (LQScreen_Width *2)/3 + 5 + 36 + 100 + 5;
        
        return cellHeight;
    }
    else if (indexPath.section == 1)
    {
        return self.commodityIntroductionCellFrame.cellHeight;
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

@end
