//
//  LQCommodityIntroductionCellFrame.m
//  美发沙龙网
//
//  Created by admin on 15/8/27.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQCommodityIntroductionCellFrame.h"

@implementation LQCommodityIntroductionCellFrame

- (void)setCommodity:(LQCommodity *)commodity
{
    _commodity = commodity;
    
    CGSize contentLableSize = [commodity.introduction calculateStringSizeWithMaxSize:CGSizeMake(LQScreen_Width - 20, MAXFLOAT) font:[UIFont systemFontOfSize:13]];
    self.contentLableHeight = contentLableSize.height;
    
    self.cellHeight = self.contentLableHeight + 45;
}

@end
