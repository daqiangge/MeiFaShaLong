//
//  LQVideoExplainCellFrame.m
//  美发沙龙网
//
//  Created by admin on 15/8/21.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import "LQVideoExplainCellFrame.h"
#import "LQVideoModel.h"

@implementation LQVideoExplainCellFrame

- (void)setVideoModel:(LQVideoModel *)videoModel
{
    _videoModel = videoModel;
    
    CGSize contentSize = [videoModel.content calculateStringSizeWithMaxSize:CGSizeMake(LQScreen_Height-30, MAXFLOAT) font:[UIFont systemFontOfSize:15]];
    
    self.contentHeight = contentSize.height;
    self.cellheight =  self.contentHeight + 55;
}

@end
