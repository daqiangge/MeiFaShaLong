//
//  LQNewsList.h
//  美发沙龙网
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQNewsList : NSObject

@property (nonatomic, copy  ) NSString *err_code;
@property (nonatomic, copy  ) NSString *err_msg;
@property (nonatomic, copy  ) NSString *table;
@property (nonatomic, copy  ) NSString *total;
@property (nonatomic, copy  ) NSString *pageTotal;
@property (nonatomic, copy  ) NSString *pageIndex;
@property (nonatomic, copy  ) NSString *pageSize;
@property (nonatomic, copy  ) NSString *info;
@property (nonatomic, strong) NSArray  *data;

@end

