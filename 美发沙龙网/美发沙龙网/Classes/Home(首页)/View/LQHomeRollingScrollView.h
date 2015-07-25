//
//  LQHomeRollingScrollView.h
//  美发沙龙网
//
//  Created by liqiang on 15/7/22.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LQHomeRollingScrollView;

@protocol LQHomeRollingScrollViewDelegate <NSObject>

@optional
- (void)homeRollingScrollViewDidUpdatePageControl:(LQHomeRollingScrollView *)scrollView currentPage:(NSInteger)currentPage;
- (void)homeRollingScrollViewDidClickImageView:(LQHomeRollingScrollView *)scrollView;

@end


@interface LQHomeRollingScrollView : UIScrollView

@property (nonatomic, weak) id<LQHomeRollingScrollViewDelegate> homeRollingScrollViewDelegate;

+ (instancetype)homeRollingScrollViewWithFrame:(CGRect)frame;

@end
