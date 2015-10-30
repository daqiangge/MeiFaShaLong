//
//  LQVideoModel.h
//  美发沙龙网
//
//  Created by admin on 15/8/21.
//  Copyright (c) 2015年 美发沙龙网. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQVideoModel : NSObject

@property (nonatomic, copy) NSString *err_msg;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *classid;
@property (nonatomic, copy) NSString *tbname;
@property (nonatomic, copy) NSString *totalpath;
@property (nonatomic, strong) NSArray *onlinepath;
@property (nonatomic, copy) NSString *info;

@end
