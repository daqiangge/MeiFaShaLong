//
//  LQLQCommodityCommentCellFrame.m
//  美发沙龙网
//
//  Created by admin on 15/8/27.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQCommodityCommentCellFrame.h"

@implementation LQCommodityCommentCellFrame

- (void)setCommodityComment:(LQCommodityComment *)commodityComment
{
    _commodityComment = commodityComment;
    
    CGSize contentLableSize = [commodityComment.content calculateStringSizeWithMaxSize:CGSizeMake(LQScreen_Width - 20, 35) font:[UIFont systemFontOfSize:13]];
    self.contentLableHeight = contentLableSize.height;
    
    self.cellHeight = self.contentLableHeight + 100;
}

@end
