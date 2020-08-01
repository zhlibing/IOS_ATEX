//
//  LXY_KLinePositionTool.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/22.
//  Copyright © 2018年 James. All rights reserved.
//



/**
 *  K线图的宽度，默认5
 */
static CGFloat LXY_StockChartKLineWidth = 5;

/**
 *  K线图的间隔，默认3
 */
static CGFloat LXY_StockChartKLineGap = 2;


static CGFloat LXY_DotNumber = 4;

static CGFloat LXY_CoinNumber = 4;

#import "LXY_KLinePositionTool.h"

@implementation LXY_KLinePositionTool



/**
 *  K线图的宽度，默认20
 */
+(CGFloat)kLineWidth
{
    return LXY_StockChartKLineWidth;
}
+(void)setkLineWith:(CGFloat)kLineWidth
{
    if (kLineWidth > LXY_StockChartKLineMaxWidth) {
        kLineWidth = LXY_StockChartKLineMaxWidth;
    }else if (kLineWidth < LXY_StockChartKLineMinWidth){
        kLineWidth = LXY_StockChartKLineMinWidth;
    }
    LXY_StockChartKLineWidth = kLineWidth;
}


/**
 *  K线图的间隔，默认1
 */
+(CGFloat)kLineGap
{
    return LXY_StockChartKLineGap;
}

+(void)setkLineGap:(CGFloat)kLineGap
{
    LXY_StockChartKLineGap = kLineGap;
}

+(NSInteger)getDotNumber
{
    return LXY_DotNumber;
}

+(NSInteger)getCoinNumber{
    return LXY_CoinNumber;
}

+(void)setDotNumber:(NSInteger)dotNumber
{
    LXY_DotNumber = dotNumber;
}

+(void)setCoin:(NSString *)coin{
    LXY_DotNumber = [SSTool MarketPrice:coin];
    LXY_CoinNumber = [SSTool MarketNum:coin];
}
@end
