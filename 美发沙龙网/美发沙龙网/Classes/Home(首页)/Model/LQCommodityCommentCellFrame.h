//
//  LQLQCommodityCommentCellFrame.h
//  美发沙龙网
//
//  Created by admin on 15/8/27.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LQCommodityComment.h"

@interface LQCommodityCommentCellFrame : NSObject

@property (nonatomic, strong) LQCommodityComment *commodityComment;
@property (nonatomic, assign) CGFloat contentLableHeight;
@property (nonatomic, assign) CGFloat cellHeight;

@end
