//
//  LQHomeModularView.h
//  美发沙龙网
//
//  Created by liqiang on 15/7/22.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LQHomeModularView;

@protocol LQHomeModularViewDelegate <NSObject>

@optional
- (void)homeModularViewDidClickBtnWithView:(LQHomeModularView *)view btn:(UIButton *)btn;

@end


@interface LQHomeModularView : UIView

@property (nonatomic, weak) id<LQHomeModularViewDelegate> homeModularViewDelegate;

+ (instancetype)homeModularViewWithFrame:(CGRect)frame;

@end
