//
//  LXY_KLine_DataModel.h
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/22.
//  Copyright © 2018年 James. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LXY_KLine_DataModel : NSObject

@property (nonatomic, strong) LXY_KLine_DataModel *previousKlineModel;  // 上一个model


@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *open;
@property (nonatomic, copy) NSString *close;
@property (nonatomic, copy) NSString *high;
@property (nonatomic, copy) NSString *low;
@property (nonatomic, copy) NSString *volume;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *datetime;
@property (nonatomic, copy) NSString *change;
@property (nonatomic, copy) NSString *timestamp;//推送时间
@property (nonatomic, copy) NSString *date;//接口时间

@property (nonatomic, copy) NSString *totalVolume;
@property (nonatomic, copy) NSString *changeRate;

@property (nonatomic, copy) NSString *buy;
@property (nonatomic, copy) NSString *sell;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, assign) double ma5;
@property (nonatomic, assign) double ma10;
@property (nonatomic, assign) double ma20;




/**
 *  该Model及其之前所有收盘价之和
 */
@property (nonatomic, assign) double SumOfLastClose;

/**
 *  该Model及其之前所有成交量之和
 */
@property (nonatomic, assign) double SumOfLastVolume;

@property (nonatomic, assign) double volume_MA5;

@property (nonatomic, assign) double volume_MA10;



#pragma BOLL线

//@property (nonatomic, copy) NSNumber *MA20;

// 标准差 二次方根【 下的 (n-1)天的 C-MA二次方 和】
@property (nonatomic, assign) double BOLL_MD;

// n-1 天的 MA
@property (nonatomic, assign) double BOLL_MB;

// MB + k * MD
@property (nonatomic, assign) double BOLL_UP;

// MB - k * MD
@property (nonatomic, assign) double BOLL_DN;

//  n 个 ( Cn - MA20)的平方和
@property (nonatomic, assign) double BOLL_SUBMD_SUM;

// 当前的 ( Cn - MA20)的平方
@property (nonatomic, assign) double BOLL_SUBMD;


#pragma 第一个EMA等于MA；即EMA(n) = MA(n)

// EMA（N）=2/（N+1）*（C-昨日EMA）+昨日EMA；
//@property (nonatomic, assign) CGFloat EMA7;
@property (nonatomic, assign) double EMA7;

// EMA（N）=2/（N+1）*（C-昨日EMA）+昨日EMA；
//@property (nonatomic, assign) CGFloat EMA30;
@property (nonatomic, assign) double EMA30;

// EMA（N）=2/（N+1）*（C-昨日EMA）+昨日EMA；
//@property (nonatomic, assign) CGFloat EMA7;
@property (nonatomic, assign) double EMA12;

// EMA（N）=2/（N+1）*（C-昨日EMA）+昨日EMA；
//@property (nonatomic, assign) CGFloat EMA30;
@property (nonatomic, assign) double EMA26;

//MACD主要是利用长短期的二条平滑平均线，计算两者之间的差离值，作为研判行情买卖之依据。MACD指标是基于均线的构造原理，对价格收盘价进行平滑处 理(求出算术平均值)后的一种趋向类指标。它主要由两部分组成，即正负差(DIF)、异同平均数(DEA)，其中，正负差是核心，DEA是辅助。DIF是 快速平滑移动平均线(EMA1)和慢速平滑移动平均线(EMA2)的差。

//在现有的技术分析软件中，MACD常用参数是快速平滑移动平均线为12，慢速平滑移动平均线参数为26。此外，MACD还有一个辅助指标——柱状线 (BAR)。在大多数技术分析软件中，柱状线是有颜色的，在低于0轴以下是绿色，高于0轴以上是红色，前者代表趋势较弱，后者代表趋势较强。

//MACD(12,26.9),下面以该参数为例说明计算方法。


//12日EMA的算式为
//EMA（12）=昨日EMA（12）*11/13+C*2/13＝(C－昨日的EMA)×0.1538＋昨日的EMA；   即为MACD指标中的快线-快速平滑移动平均线；
//26日EMA的算式为
//EMA（26）=昨日EMA（26）*25/27+C*2/27；   即为MACD指标中的慢线-慢速平滑移动平均线；

//DIF=EMA（12）-EMA（26）         DIF的值即为红绿柱；
//@property (nonatomic, assign) CGFloat DIF;
@property (nonatomic, assign) double DIF;

//今日的DEA值（即MACD值）=前一日DEA*8/10+今日DIF*2/10.
//@property (nonatomic, assign) CGFloat DEA;
@property (nonatomic, assign) double DEA;

//EMA（12）=昨日EMA（12）*11/13+C*2/13；   即为MACD指标中的快线；
//EMA（26）=昨日EMA（26）*25/27+C*2/27；   即为MACD指标中的慢线；
//@property (nonatomic, assign) CGFloat MACD;
@property (nonatomic, assign) double MACD;


/**
 *  9Clock内最低价
 */
//@property (nonatomic, assign) CGFloat NineClocksMinPrice;
@property (nonatomic, assign) double NineClocksMinPrice;


/**
 *  9Clock内最高价
 */
//@property (nonatomic, assign) CGFloat NineClocksMaxPrice;
@property (nonatomic, assign) double NineClocksMaxPrice;



//KDJ(9,3.3),下面以该参数为例说明计算方法。
//9，3，3代表指标分析周期为9天，K值D值为3天
//RSV(9)=（今日收盘价－9日内最低价）÷（9日内最高价－9日内最低价）×100
//K(3日)=（当日RSV值+2*前一日K值）÷3
//D(3日)=（当日K值+2*前一日D值）÷3
//J=3K－2D
//@property (nonatomic, assign) CGFloat RSV_9;
@property (nonatomic, assign) double RSV_9;

//@property (nonatomic, assign) CGFloat KDJ_K;
@property (nonatomic, assign) double KDJ_K;

//@property (nonatomic, assign) CGFloat KDJ_D;
@property (nonatomic, assign) double KDJ_D;

//@property (nonatomic, assign) CGFloat KDJ_J;
@property (nonatomic, assign) double KDJ_J;

// 相对前一天涨跌幅的变化
@property (nonatomic, assign) double CHG;
// 从第一天起涨幅之和
@property (nonatomic, assign) double CHG_TOTAL_UP;
// 从第一天起跌幅之和
@property (nonatomic, assign) double CHG_TOTAL_DN;

//@property (nonatomic, assign) CGFloat RSI6;
@property (nonatomic, assign) double RSI6;

//@property (nonatomic, assign) CGFloat RSI12;
@property (nonatomic, assign) double RSI12;

//@property (nonatomic, assign) CGFloat RSI24;
@property (nonatomic, assign) double RSI24;

//@property (nonatomic, assign) CGFloat WR14;
@property (nonatomic, assign) double WR14;


@property (nonatomic, copy)NSArray *dataSource;



-(void)setData;


@end

