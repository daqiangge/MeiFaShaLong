//
//  LQVideoExplainCellFrame.h
//  美发沙龙网
//
//  Created by admin on 15/8/21.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ContentLable_Font ([UIFont systemFontOfSize:14])

@class LQVideoModel;

@interface LQVideoExplainCellFrame : NSObject

@property (nonatomic, assign) CGFloat cellheight;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, strong) LQVideoModel *videoModel;

@end
