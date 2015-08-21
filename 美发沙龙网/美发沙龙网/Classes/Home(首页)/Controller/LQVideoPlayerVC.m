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

@interface LQVideoPlayerVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) KrVideoPlayerController  *videoController;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation LQVideoPlayerVC

- (UITableView *)tableView
{
    if (!_tableView)
    {
        CGFloat x = 0;
        CGFloat y = self.videoController.view.height + 20;
        CGFloat w = LQScreen_Width;
        CGFloat h = LQScreen_Height - y;
        
        UITableView *tableView    = [[UITableView alloc] init];
        tableView.frame           = CGRectMake(x, y, w, h);
        tableView.backgroundColor = [UIColor redColor];
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
    
    [self doLoading];
}

- (void)doLoading
{
    [self playVideo];
    
    self.tableView.hidden = NO;
}

- (void)playVideo
{
    NSURL *url = [NSURL URLWithString:@"http://krtv.qiniudn.com/150522nextapp"];
    [self addVideoPlayerWithURL:url];
}

- (void)addVideoPlayerWithURL:(NSURL *)url
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
    
    self.videoController.contentURL = url;
}

//隐藏navigation tabbar 电池栏
- (void)toolbarHidden:(BOOL)Bool
{
    self.navigationController.navigationBar.hidden = Bool;
    self.tabBarController.tabBar.hidden = Bool;
    [[UIApplication sharedApplication] setStatusBarHidden:Bool withAnimation:UIStatusBarAnimationFade];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
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
        
        return cell;
    }
    
    if (indexPath.row == 2)
    {
        LQVideoExplainCell *cell = [LQVideoExplainCell cellWithTableView:tableView indexPath:indexPath];
        
        return cell;
    }
    
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
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
    
    if (indexPath.row == 2)
    {
        NSString *str = @"我湿\n答答\n啊地\n\n方各位\n 啊的身\n份嘎\n\n的水电费人工费";
        CGSize size = [str calculateStringSizeWithMaxSize:CGSizeMake(LQScreen_Width-30, MAXFLOAT) font:[UIFont systemFontOfSize:15]];
        return size.height + 55;
    }
    
    return 100;
}

#pragma mark - viewWillDisappear
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.videoController dismiss];
}


@end
