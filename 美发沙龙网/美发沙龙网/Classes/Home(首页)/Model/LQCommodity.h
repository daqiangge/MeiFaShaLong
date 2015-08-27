//
//  LQCommodity.h
//  美发沙龙网
//
//  Created by admin on 15/8/27.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LQCommodityComment.h"

@interface LQCommodity : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *marketPrice;
@property (nonatomic, copy) NSString *DiscountPrice;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *brand;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, strong) LQCommodityComment *comment;

@end
