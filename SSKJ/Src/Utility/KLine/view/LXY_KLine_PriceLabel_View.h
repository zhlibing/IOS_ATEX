//
//  LXY_KLine_PriceView.h
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/25.
//  Copyright © 2018年 James. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXY_KLine_DataModel.h"
#import "LXY_KLine_StockChartPositionModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface LXY_KLine_PriceLabel_View : UIView

// 最大价格
@property (nonatomic, assign) double maxPrice;

// 最大价格
@property (nonatomic, assign) double minPrice;
//币种
@property (nonatomic, copy) NSString *coinName;

// 最后一条数据
@property (nonatomic, strong) LXY_KLine_DataModel *lastModel;

// 最后一条数据的位置model
@property (nonatomic, strong) LXY_KLine_StockChartPositionModel *lastPositionModel;

// 开始绘制的K线的下标
@property (nonatomic, assign) NSInteger startDrawIndex;
// 当前显示的K线点数量
@property (nonatomic, assign) NSInteger countOfShowCandle;

@property (nonatomic, strong) NSMutableArray<LXY_KLine_DataModel *> *dataSource;

-(void)longPressWithModel:(LXY_KLine_DataModel *)model positionY:(CGFloat)positionY;

-(void)hideLongPressLabel;

-(void)drawView;

-(void)refreshCurrentPricelabel;

-(void)hideCurrentPriceLabel;

@end

NS_ASSUME_NONNULL_END
