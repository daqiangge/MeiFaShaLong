//
//  LQCommodityIntroductionCellFrame.h
//  美发沙龙网
//
//  Created by admin on 15/8/27.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LQCommodity.h"

@interface LQCommodityIntroductionCellFrame : NSObject

@property (nonatomic, strong) LQCommodity *commodity;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGFloat contentLableHeight;

@end
