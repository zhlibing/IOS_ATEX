//
//  LXY_KLine_MainView.h
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/22.
//  Copyright © 2018年 James. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LXY_KLine_DataModel.h"
#import "LXY_KLine_StockChartPositionModel.h"


typedef NS_ENUM(NSUInteger, LXY_KLINETYPE) {
    LXY_KLINETYPETIME,              // 分时图
    LXY_KLINETYPEKLINE              // K线图
};

typedef NS_ENUM(NSUInteger, LXY_KMAINACCESSORYTYPE) {
    LXY_KMAINACCESSORYTYPENONE,         //  不显示
    LXY_KMAINACCESSORYTYPEMA,           //  MA5 MA10 MA20
    LXY_KMAINACCESSORYTYPEBOLL,         //  BOLL线
};

NS_ASSUME_NONNULL_BEGIN




@protocol LXY_KLine_MineView_Porotcol <NSObject>

-(void)getMaxPrice:(double)maxprice minPirce:(double)minPrice lastModel:(LXY_KLine_DataModel *)model lastPositionModel:(LXY_KLine_StockChartPositionModel *)lastPositionModel;

-(void)drawFinishedWithLastModel:(LXY_KLine_DataModel *)model lastPositionModel:(LXY_KLine_StockChartPositionModel *)positionModel lastIndex:(NSInteger)index;

@end

@interface LXY_KLine_MainView : UIView

@property (nonatomic, assign) LXY_KLINETYPE klineType;

@property (nonatomic, assign) LXY_KMAINACCESSORYTYPE accessoryType;


// 开始绘制的K线的下标
@property (nonatomic, assign) NSInteger startDrawIndex;
// 当前显示的K线点数量
@property (nonatomic, assign) NSInteger countOfShowCandle;


@property (nonatomic, assign) CGFloat scrollGap;

@property (nonatomic, strong) NSMutableArray<LXY_KLine_DataModel *> *dataSource;

@property (nonatomic, weak) id <LXY_KLine_MineView_Porotcol> delegate;


@property (nonatomic, copy) void (^getMaxAndMinPriceBlock)(double maxprice,double minPrice);

-(LXY_KLine_StockChartPositionModel *)positionModelWithIndex:(NSInteger)index;

-(NSInteger)indexWithPositionX:(CGFloat)positionX;

-(void)drawView;
@end



NS_ASSUME_NONNULL_END
