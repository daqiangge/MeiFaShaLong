//
//  LQHomeRollingScrollView.h
//  美发沙龙网
//
//  Created by liqiang on 15/7/22.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LQHomeRollingScrollView;
@class LQNewsListContent;

@protocol LQHomeRollingScrollViewDelegate <NSObject>

@optional
- (void)homeRollingScrollViewDidUpdatePageControl:(LQHomeRollingScrollView *)scrollView currentPage:(NSInteger)currentPage titleName:(NSString *)titleName;
- (void)homeRollingScrollViewDidClickImageView:(LQHomeRollingScrollView *)scrollView newsListContent:(LQNewsListContent *)newsContent;

@end


@interface LQHomeRollingScrollView : UIScrollView

@property (nonatomic, weak) id<LQHomeRollingScrollViewDelegate> homeRollingScrollViewDelegate;
@property (nonatomic, strong) NSMutableArray *imageUrlArray;

+ (instancetype)homeRollingScrollViewWithFrame:(CGRect)frame;

@end
