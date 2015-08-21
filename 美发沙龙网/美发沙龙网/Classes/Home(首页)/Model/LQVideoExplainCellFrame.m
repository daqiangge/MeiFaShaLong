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
    
    CGSize contentSize = [videoModel.content calculateStringSizeWithMaxSize:CGSizeMake(LQScreen_Width-30, MAXFLOAT) font:ContentLable_Font];
    
    self.contentHeight = contentSize.height;
    self.cellheight =  self.contentHeight + 50;
}

@end
