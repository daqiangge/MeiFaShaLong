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

- (void)InformationBtnGroupViewDidClickBtnWithView:(LQInformationBtnGroupView *)btnGroupView btn:(UIButton *)btn;

@end


@interface LQInformationBtnGroupView : UIView

@property (nonatomic, weak) id<LQInformationBtnGroupViewDelegate> btnGroupViewDelegate;
@property (nonatomic, strong) NSArray *sonclassArray;

+ (instancetype)informationBtnGroupViewWithFrame:(CGRect)frame;

@end
