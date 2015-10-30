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
#import "LQVideoModel.h"
#import "LQVideoNumberVC.h"
#import "LQNewsContent.h"

@interface LQVideoPlayerVC ()<UITableViewDataSource,UITableViewDelegate,LQVideoNumberCellDelegate,LQVideoPlayerTitleCellDelegate>

@property (nonatomic, strong) KrVideoPlayerController  *videoController;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) LQVideoModel *videoModel;
@property (nonatomic, strong) NSArray *videoArray;

/**
 *  记录播放的第几集
 */
@property (nonatomic, assign) int videoBtnSelecteNum;

@end

@implementation LQVideoPlayerVC

- (NSArray *)videoArray
{
    if (!_videoArray)
    {
        _videoArray = [NSArray array];
    }
    
    return _videoArray;
}

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

- (void)setID:(NSString *)ID
{
    _ID = ID;
}

- (void)setClassid:(NSString *)classid
{
    _classid = classid;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeVideoBtnSelecteNum:) name:KNotificationName_VideoBtnSelecteNum object:nil];
    
    [self doLoading];
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
    
    [self videoRequest];
}

//隐藏navigation tabbar 电池栏
- (void)toolbarHidden:(BOOL)Bool
{
    self.navigationController.navigationBar.hidden = Bool;
//    self.tabBarController.tabBar.hidden = Bool;
    [[UIApplication sharedApplication] setStatusBarHidden:Bool withAnimation:UIStatusBarAnimationFade];
}

- (void)changeVideoBtnSelecteNum:(NSNotification *)notification
{
    id obj = [notification object];
    
    self.videoBtnSelecteNum = [obj intValue];
    
    LQVideoNumberCell *cell = (LQVideoNumberCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];

    //判断所选集数是否小于6集，如果是，则在视频显示界面的相应集数按钮选中
    if (self.videoBtnSelecteNum <= 106)
    {
        UIButton *btn = (UIButton *)[cell viewWithTag:self.videoBtnSelecteNum];
        [cell buttonDidClick:btn];
    }
    
    self.videoController.contentURL = [NSURL URLWithString:self.videoArray[self.videoBtnSelecteNum - 101]];
    [self.videoController play];
}

#pragma mark - 网络请求
- (void)videoRequest
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *urlStr = @"http://old.meifashalong.com/e/api/movieSlider.php";
    NSDictionary *parameters = @{@"id":self.ID,@"classid":self.classid};
    
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        self.videoModel = [LQVideoModel objectWithKeyValues:operation.responseString];
        
        //默认第一个按钮选中
//        self.videoController.contentURL = [NSURL URLWithString:self.videoModel.onlinepath[0]];
//        self.videoBtnSelecteNum = 101;
        
        self.videoArray = [NSArray arrayWithArray:self.videoModel.onlinepath];
        
        [self.tableView reloadData];
        
        LQLog(@"视频地址以获取");
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LQLog(@"请求失败%@",error);
        
        hud.labelText = HTTPRequestErrer_Text;
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1.5];
    }];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        LQVideoPlayerTitleCell *cell = [LQVideoPlayerTitleCell cellWithTableView:tableView indexPath:indexPath];
        
        cell.delegate = self;
        cell.videoModel = self.videoModel;
        
        return cell;
    }
    
    if (indexPath.row == 1)
    {
        LQVideoNumberCell *cell = [LQVideoNumberCell cellWithTableView:tableView indexPath:indexPath];
        cell.delegate = self;
        cell.totalpath = (int)self.videoArray.count;
        
        return cell;
    }
    
    LQVideoExplainCell *cell = [LQVideoExplainCell cellWithTableView:tableView indexPath:indexPath];
        
    cell.videoModel = self.videoModel;
        
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 75;
    }
    else if (indexPath.row == 1)
    {
        return 100;
    }
    else if (indexPath.row == 2)
    {
        CGSize contentSize = [self.videoModel.briefIntroduction calculateStringSizeWithMaxSize:CGSizeMake(LQScreen_Width-30, MAXFLOAT) font:ContentLable_Font];
        
        return contentSize.height + 50;
    }
    else
    {
        CGSize contentSize = [self.videoModel.useHelp calculateStringSizeWithMaxSize:CGSizeMake(LQScreen_Width-30, MAXFLOAT) font:ContentLable_Font];
        
        return contentSize.height + 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
    {
        LQVideoNumberVC *videoNumVC = [[LQVideoNumberVC alloc] init];
        videoNumVC.videoBtnSelecteNum = self.videoBtnSelecteNum;
        videoNumVC.totalpath = (int)self.videoArray.count;
        [self.navigationController pushViewController:videoNumVC animated:YES];
    }
}

#pragma mark -
#pragma ================= LQVideoNumberCellDelegate =================
- (void)videoNumberCellDidClickBtnWithView:(LQVideoNumberCell *)view btn:(UIButton *)btn
{
    self.videoBtnSelecteNum = (int)btn.tag;
    
    LQLog(@"选中的集数按钮为%d",self.videoBtnSelecteNum);
    
    self.videoController.contentURL = [NSURL URLWithString:self.videoArray[self.videoBtnSelecteNum - 101]];
    [self.videoController play];
}

#pragma mark - LQVideoPlayerTitleCellDelegate
- (void)fenxiangBtnDidClickWithCell:(LQVideoPlayerTitleCell *)cell
{
    
}

#pragma mark -
#pragma ================= viewWillDisappear =================
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //判断是否点击返回按钮
    if (![[self.navigationController viewControllers] containsObject:self])
    {
        [self.videoController dismiss];
        
        LQLog(@"LQVideoPlayerVC --------- 点击了返回按钮");
    }
}

#pragma mark -
#pragma ================= dealloc =================
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
