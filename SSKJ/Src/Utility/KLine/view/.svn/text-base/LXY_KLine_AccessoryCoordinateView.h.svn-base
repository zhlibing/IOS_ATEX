//
//  LXY_KLine_AccessoryLabelView.h
//  SSKJ
//
//  Created by 刘小雨 on 2018/11/9.
//  Copyright © 2018年 James. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXY_KLine_DataModel.h"
#import "LXY_KLine_StockChartPositionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXY_KLine_AccessoryCoordinateView : UIView

// 最大值
@property (nonatomic, assign) double maxValue;

// 最大值
@property (nonatomic, assign) double minValue;

// 最后一条数据
@property (nonatomic, strong) LXY_KLine_DataModel *lastModel;

// 最后一条数据的位置model
@property (nonatomic, strong) LXY_KLine_StockChartPositionModel *lastPositionModel;

// 开始绘制的K线的下标
@property (nonatomic, assign) NSInteger startDrawIndex;
// 当前显示的K线点数量
@property (nonatomic, assign) NSInteger countOfShowCandle;
@property (nonatomic, strong) NSMutableArray<LXY_KLine_DataModel *> *dataSource;


-(void)drawView;


@property(nonatomic, strong)UILabel *maxLabel;
@property(nonatomic, strong)UILabel *minLabel;

@end

NS_ASSUME_NONNULL_END
