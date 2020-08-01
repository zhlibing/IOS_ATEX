//
//  LXY_KLineView.h
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/22.
//  Copyright © 2018年 James. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXY_KLine_MainView.h"
#import "LXY_KLine_AccessoryView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXY_KLineView : UIView

/*
 * 时间间隔
 * 如果收到的推送时间和最后一条数据的时间对比大于时间间隔z，则再加一条数据
 * 默认0，不加数据
 */
@property (nonatomic, assign) NSInteger refreshTimeCount;

@property (nonatomic, assign) LXY_ACCESSORYTYPE accessoryType;

@property (nonatomic, assign) LXY_KMAINACCESSORYTYPE mainAccessoryType;


// 初始化k线图，设置初始主k线图指标类型，和指标图指标类型
-(instancetype)initWithFrame:(CGRect)frame accessoryType:(LXY_ACCESSORYTYPE)accessoryType mainAccessoryType:(LXY_KMAINACCESSORYTYPE)mainAccessoryType;


// 设置数据源，k线图类型，和时间格式，开始绘图
-(void)setData:(NSArray *)dataArray klineType:(LXY_KLINETYPE)klineType timeFormatter:(NSString *)timeFormatter;


// 根据socket推送，跳动
-(void)refreshWithSocketData:(LXY_KLine_DataModel *)socketModel minuteInvital:(NSInteger)minuteInvital;

- (void)setCurrentPrice:(NSString *)price;
@end

NS_ASSUME_NONNULL_END
