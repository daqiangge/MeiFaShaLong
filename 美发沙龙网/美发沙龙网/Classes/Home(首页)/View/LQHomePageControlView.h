//
//  LQHomePageControlView.h
//  美发沙龙网
//
//  Created by admin on 15/7/23.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQHomePageControlView : UIView

@property (nonatomic, weak) UILabel *titleLable;
@property (nonatomic, weak) UIPageControl *pageControl;

+ (instancetype)homePageControlViewWithFrame:(CGRect)frame;

@end
