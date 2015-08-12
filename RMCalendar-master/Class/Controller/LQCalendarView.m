//
//  LQCalendarView.m
//  RMCalendar
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 迟浩东. All rights reserved.
//

#import "LQCalendarView.h"
#import "RMCalendarCollectionViewLayout.h"
#import "RMCollectionCell.h"
#import "RMCalendarMonthHeaderView.h"
#import "RMCalendarLogic.h"

@interface LQCalendarView()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation LQCalendarView

static NSString *MonthHeader = @"MonthHeaderView";

static NSString *DayCell = @"DayCell";

/**
 *  初始化模型数组对象
 */
- (NSMutableArray *)calendarMonth {
    if (!_calendarMonth) {
        _calendarMonth = [NSMutableArray array];
    }
    return _calendarMonth;
}

- (RMCalendarLogic *)calendarLogic {
    if (!_calendarLogic) {
        _calendarLogic = [[RMCalendarLogic alloc] init];
    }
    return _calendarLogic;
}


+ (instancetype)calendarWithDays:(int)days showType:(CalendarShowType)type singleShowMonth:(int)singleShowMonth frame:(CGRect)frame
{
    return [[self alloc] initWithDays:days showType:type singleShowMonth:singleShowMonth frame:frame];
}

- (instancetype)initWithDays:(int)days showType:(CalendarShowType)type singleShowMonth:(int)singleShowMonth frame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.days = days;
        self.type = type;
        self.calendarLogic.singleShowMonth = singleShowMonth;
    }
    
    return self;
}

- (void)setModelArr:(NSMutableArray *)modelArr
{
    _modelArr = modelArr;
}

-(void)setIsEnable:(BOOL)isEnable {
    _isEnable = isEnable;
}

- (void)layoutSubviews
{
    [self doLoading];
}

- (void)doLoading
{
    // 定义Layout对象
    RMCalendarCollectionViewLayout *layout = [[RMCalendarCollectionViewLayout alloc] init];
    
    // 初始化CollectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    
    // 注册CollectionView的Cell
    [self.collectionView registerClass:[RMCollectionCell class] forCellWithReuseIdentifier:DayCell];
    
    [self.collectionView registerClass:[RMCalendarMonthHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader];
    
    //    self.collectionView.bounces = NO;//将网格视图的下拉效果关闭
    
    self.collectionView.delegate = self;//实现网格视图的delegate
    
    self.collectionView.dataSource = self;//实现网格视图的dataSource
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.collectionView];
    
    self.calendarMonth = [self getMonthArrayOfDays:self.days showType:self.type isEnable:self.isEnable modelArr:self.modelArr];
}


/**
 *  获取Days天数内的数组
 *
 *  @param days 天数
 *  @param type 显示类型
 *  @param arr  模型数组
 *  @return 数组
 */
- (NSMutableArray *)getMonthArrayOfDays:(int)days showType:(CalendarShowType)type isEnable:(BOOL)isEnable modelArr:(NSArray *)arr
{
    NSDate *date = [NSDate date];
    NSDate *selectdate  = [NSDate date];
    //返回数据模型数组
    return [self.calendarLogic reloadCalendarView:date selectDate:selectdate needDays:days showType:type isEnable:isEnable priceModelArr:arr];
}

#pragma mark - CollectionView 数据源

// 返回组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.calendarMonth.count;
}
// 返回每组行数
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *arrary = [self.calendarMonth objectAtIndex:section];
    return arrary.count;
}

#pragma mark - CollectionView 代理

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    RMCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DayCell forIndexPath:indexPath];
    NSArray *months = [self.calendarMonth objectAtIndex:indexPath.section];
    RMCalendarModel *model = [months objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        NSMutableArray *month_Array = [self.calendarMonth objectAtIndex:indexPath.section];
        RMCalendarModel *model = [month_Array objectAtIndex:15];
        
        RMCalendarMonthHeaderView *monthHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader forIndexPath:indexPath];
        monthHeader.masterLabel.text = [NSString stringWithFormat:@"%lu年 %lu月",(unsigned long)model.year,(unsigned long)model.month];//@"日期";
        monthHeader.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
        reusableview = monthHeader;
    }
    return reusableview;
    
}

- (void)collectionView:(nonnull UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSArray *months = [self.calendarMonth objectAtIndex:indexPath.section];
    RMCalendarModel *model = [months objectAtIndex:indexPath.row];
    if (model.style == CellDayTypeClick || model.style == CellDayTypeFutur || model.style == CellDayTypeWeek) {
        [self.calendarLogic selectLogic:model];
        if (self.calendarBlock) {
            self.calendarBlock(model);
        }
    }
    [self.collectionView reloadData];
}

- (BOOL)collectionView:(nonnull UICollectionView *)collectionView shouldSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return YES;
}

@end