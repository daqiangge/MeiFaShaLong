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

//视频集数
@property (nonatomic, copy) NSString *totalpath;

//视频地址数组
@property (nonatomic, strong) NSArray *onlinepath;

@property (nonatomic, copy) NSString *info;

//简介
@property (nonatomic, copy) NSString *briefIntroduction;

//使用帮助
@property (nonatomic, copy) NSString *useHelp;

@end
