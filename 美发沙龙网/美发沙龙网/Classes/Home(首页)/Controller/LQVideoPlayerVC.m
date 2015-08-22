//
//  LQVideoPlayerVC.m
//  美发沙龙网
//
//  Created by admin on 15/8/21.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQVideoPlayerVC.h"
#import "KrVideoPlayerController.h"
#import "LQVideoPlayerTitleCell.h"
#import "LQVideoNumberCell.h"
#import "LQVideoExplainCell.h"
#import "LQVideoExplainCellFrame.h"
#import "LQVideoModel.h"
#import "LQVideoModels.h"
#import "LQVideoNumberVC.h"

@interface LQVideoPlayerVC ()<UITableViewDataSource,UITableViewDelegate,LQVideoNumberCellDelegate>

@property (nonatomic, strong) KrVideoPlayerController  *videoController;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) LQVideoModels *videoModels;

/**
 *  记录播放的第几集
 */
@property (nonatomic, assign) int videoBtnSelecteNum;

@end

@implementation LQVideoPlayerVC

- (UITableView *)tableView
{
    if (!_tableView)
    {
        CGFloat x = 0;
        CGFloat y = LQScreen_Width*(9.0/16.0) + 20;
        CGFloat w = LQScreen_Width;
        CGFloat h = LQScreen_Height - y;
        
        UITableView *tableView    = [[UITableView alloc] init];
        tableView.frame           = CGRectMake(x, y, w, h);
        tableView.backgroundColor = RGB(246, 246, 246);
        tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        tableView.delaysContentTouches = NO;//使列表上按钮出现高亮状态
        tableView.dataSource = self;
        tableView.delegate = self;
        [self.view addSubview:tableView];

        _tableView                = tableView;
        
    }
    
    return _tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self doLoading];
    [self videoRequest];
}

- (void)doLoading
{
    self.tableView.hidden = NO;
    [self playVideo];
}

- (void)playVideo
{
    [self addVideoPlayer];
}

- (void)addVideoPlayer
{
    if (!self.videoController)
    {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.videoController = [[KrVideoPlayerController alloc] initWithFrame:CGRectMake(0, 20, width, width*(9.0/16.0))];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController setWillBackOrientationPortrait:^{
            [weakSelf toolbarHidden:NO];
        }];
        [self.videoController setWillChangeToFullscreenMode:^{
            [weakSelf toolbarHidden:YES];
        }];
        [self.view addSubview:self.videoController.view];
    }
}

//隐藏navigation tabbar 电池栏
- (void)toolbarHidden:(BOOL)Bool
{
    self.navigationController.navigationBar.hidden = Bool;
//    self.tabBarController.tabBar.hidden = Bool;
    [[UIApplication sharedApplication] setStatusBarHidden:Bool withAnimation:UIStatusBarAnimationFade];
}

#pragma mark - 网络请求
- (void)videoRequest
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSDictionary *dic1 = @{@"title":@"简介",@"content":@"所需点数：25点/集（VIP卡用户或VIP会员无需点数）\n上传时间：2015年07月08日\n影片类型：2015剪发 托尼盖美发 剪发理论 汤尼盖教学\n影片简介：2015路易斯托尼盖时尚剪裁课程教学，时尚剪裁理论+全新安得卡特发型剪裁）"};
        NSDictionary *dic2 = @{@"title":@"影片介绍",@"content":@"所需点数：25点/集（VIP卡用户或VIP会员无需点数）\n上传时间：2015年07月08日\n影片类型：2015剪发 托尼盖美发 剪发理论 汤尼盖教学\n影片简介：2015路易斯托尼盖时尚剪裁课程教学，时尚剪裁理论+全新安得卡特发型剪裁）"};
        NSDictionary *dic3 = @{@"title":@"使用帮助",@"content":@"所需点数：25点/集（VIP卡用户或VIP会员无需点数）\n上传时间：2015年07月08日\n影片类型：2015剪发 托尼盖美发 剪发理论 汤尼盖教学\n影片简介：2015路易斯托尼盖时尚剪裁课程教学，时尚剪裁理论+全新安得卡特发型剪裁）"};
        
        NSDictionary *videoModels = @{@"videoModels":@[dic1,dic2,dic3]};
        
        
        self.videoController.contentURL = [NSURL URLWithString:@"http://krtv.qiniudn.com/150522nextapp"];
        
        self.videoModels = [LQVideoModels objectWithKeyValues:videoModels];
        
        [self.tableView reloadData];
        
        self.videoBtnSelecteNum = 1;
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    });
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.videoModels.videoModels count] + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        LQVideoPlayerTitleCell *cell = [LQVideoPlayerTitleCell cellWithTableView:tableView indexPath:indexPath];
        
        return cell;
    }
    
    if (indexPath.row == 1)
    {
        LQVideoNumberCell *cell = [LQVideoNumberCell cellWithTableView:tableView indexPath:indexPath];
        cell.delegate = self;
        
        return cell;
    }
    
    LQVideoExplainCell *cell = [LQVideoExplainCell cellWithTableView:tableView indexPath:indexPath];
        
    LQVideoExplainCellFrame * cellFrame = [[LQVideoExplainCellFrame alloc] init];
    cellFrame.videoModel = self.videoModels.videoModels[indexPath.row - 2];
    
    cell.cellFrame = cellFrame;
        
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 75;
    }
    
    if (indexPath.row == 1)
    {
        return 100;
    }
    
    LQVideoExplainCellFrame * cellFrame = [[LQVideoExplainCellFrame alloc] init];
    cellFrame.videoModel = self.videoModels.videoModels[indexPath.row - 2];
        
    return cellFrame.cellheight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
    {
        LQVideoNumberVC *videoNumVC = [[LQVideoNumberVC alloc] init];
        videoNumVC.videoBtnSelecteNum = self.videoBtnSelecteNum;
        [self.navigationController pushViewController:videoNumVC animated:YES];
    }
}

#pragma mark - LQVideoNumberCellDelegate
- (void)videoNumberCellDidClickBtnWithView:(LQVideoNumberCell *)view btn:(UIButton *)btn
{
    self.videoBtnSelecteNum = (int)btn.tag - 100;
}

#pragma mark - viewWillDisappear
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.videoController dismiss];
}


@end
