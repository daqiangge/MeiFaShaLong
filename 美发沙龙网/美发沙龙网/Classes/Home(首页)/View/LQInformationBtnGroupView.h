//
//  LQInformationBtnGroupView.h
//  美发沙龙网
//
//  Created by admin on 15/7/25.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LQInformationBtnGroupView;

@protocol LQInformationBtnGroupViewDelegate <NSObject>

- (void)InformationBtnGroupViewDidClickBtn:(LQInformationBtnGroupView *)btnGroupView;

@end


@interface LQInformationBtnGroupView : UIView

@property (nonatomic, weak) id<LQInformationBtnGroupViewDelegate> btnGroupViewDelegate;

+ (instancetype)informationBtnGroupViewWithFrame:(CGRect)frame;

@end
