//
//  LQNewsClassId.h
//  美发沙龙网
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LQNewsBClass.h"
#import "LQNewsSonClass.h"

@interface LQNewsClassId : NSObject

@property (nonatomic, strong) LQNewsBClass *bclass;
@property (nonatomic, strong) NSArray *sonclass;

@end
