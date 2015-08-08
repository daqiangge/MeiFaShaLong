//
//  LQHomeRollingView.h
//  美发沙龙网
//
//  Created by admin on 15/7/25.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQHomeRollingScrollView.h"
#import "LQHomePageControlView.h"

@interface LQHomeRollingView : UIView

@property (weak, nonatomic) LQHomeRollingScrollView *homeRollingScrollView;
@property (nonatomic, weak) LQHomePageControlView *homePageControlView;

+ (instancetype)homeRollingViewWithFrame:(CGRect)frame;

@end
