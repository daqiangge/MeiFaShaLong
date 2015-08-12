//
//  ViewController.m
//  RMCalendar
//
//  Created by 迟浩东 on 15/7/1.
//  Copyright (c) 2015年 迟浩东. All rights reserved.
//

#import "ViewController.h"
#import "RMCalendarController.h"
#import "MJExtension.h"
#import "TicketModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    LQCalendarView *c = [LQCalendarView calendarWithDays:-300 showType:CalendarShowTypeSingle singleShowMonth:1 frame:CGRectMake(0, 100, self.view.frame.size.width, 400)];
//    
//    // 此处用到MJ大神开发的框架，根据自己需求调整是否需要
//    c.modelArr = [TicketModel objectArrayWithKeyValuesArray:@[@{@"year":@2015, @"month":@7, @"day":@1,
//                                                                @"ticketCount":@194, @"ticketPrice":@283},
//                                                              @{@"year":@2015, @"month":@9, @"day":@7,
//                                                                @"ticketCount":@91, @"ticketPrice":@223},
//                                                              @{@"year":@2015, @"month":@10, @"day":@4,
//                                                                @"ticketCount":@91, @"ticketPrice":@23},
//                                                              @{@"year":@2015, @"month":@9, @"day":@8,
//                                                                @"ticketCount":@2, @"ticketPrice":@203},
//                                                              @{@"year":@2015, @"month":@8, @"day":@28,
//                                                                @"ticketCount":@2, @"ticketPrice":@103},
//                                                              @{@"year":@2015, @"month":@8, @"day":@18,
//                                                                @"ticketCount":@0, @"ticketPrice":@153}]]; //最后一条数据ticketCount 为0时不显示
//    c.isEnable = YES;
//    c.calendarBlock = ^(RMCalendarModel *model) {
//        if (model.ticketModel) {
//            NSLog(@"%lu-%lu-%lu-票价%.1f",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day, model.ticketModel.ticketPrice);
//        } else {
//            NSLog(@"%lu-%lu-%lu",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day);
//        }
//    };
//    [self.view addSubview:c];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClick {
    RMCalendarController *c = [RMCalendarController calendarWithDays:-300 showType:CalendarShowTypeSingle singleShowMonth:1];
    
    // 此处用到MJ大神开发的框架，根据自己需求调整是否需要
    c.modelArr = [TicketModel objectArrayWithKeyValuesArray:@[@{@"year":@2015, @"month":@7, @"day":@1,
                                                                @"ticketCount":@194, @"ticketPrice":@283},
                                                              @{@"year":@2015, @"month":@9, @"day":@7,
                                                                @"ticketCount":@91, @"ticketPrice":@223},
                                                              @{@"year":@2015, @"month":@10, @"day":@4,
                                                                @"ticketCount":@91, @"ticketPrice":@23},
                                                              @{@"year":@2015, @"month":@9, @"day":@8,
                                                                @"ticketCount":@2, @"ticketPrice":@203},
                                                              @{@"year":@2015, @"month":@8, @"day":@28,
                                                                @"ticketCount":@2, @"ticketPrice":@103},
                                                              @{@"year":@2015, @"month":@8, @"day":@18,
                                                                @"ticketCount":@0, @"ticketPrice":@153}]]; //最后一条数据ticketCount 为0时不显示
    c.isEnable = YES;
    c.title = @"单价日历 软曼网";
    c.calendarBlock = ^(RMCalendarModel *model) {
        if (model.ticketModel) {
            NSLog(@"%lu-%lu-%lu-票价%.1f",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day, model.ticketModel.ticketPrice);
        } else {
            NSLog(@"%lu-%lu-%lu",(unsigned long)model.year,(unsigned long)model.month,(unsigned long)model.day);
        }
    };
    [self.navigationController pushViewController:c animated:YES];
}

@end
