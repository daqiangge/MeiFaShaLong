//
//  LQNewsClass.h
//  美发沙龙网
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LQNewsClassData.h"

@interface LQNewsClass : NSObject

@property (nonatomic, copy  ) NSString        *err_msg;
@property (nonatomic, copy  ) NSString        *creat_at;
@property (nonatomic, copy  ) NSString        *info;
@property (nonatomic, strong) LQNewsClassData *data;

@end
