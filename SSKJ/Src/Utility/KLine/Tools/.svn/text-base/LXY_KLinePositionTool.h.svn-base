//
//  LXY_KLinePositionTool.h
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/22.
//  Copyright © 2018年 James. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LXY_StockState) {
    LXY_StockStateRise,     // 涨
    LXY_StockStateFall,     // 跌
};

@interface LXY_KLinePositionTool : NSObject

/**
 *  K线图的宽度，默认20
 */
+(CGFloat)kLineWidth;

+(void)setkLineWith:(CGFloat)kLineWidth;

/**
 *  K线图的间隔，默认1
 */
+(CGFloat)kLineGap;

+(void)setkLineGap:(CGFloat)kLineGap;

+(NSInteger)getDotNumber;
+(NSInteger)getCoinNumber;

+(void)setDotNumber:(NSInteger)dotNumber;

+(void)setCoin:(NSString *)coin;

@end

NS_ASSUME_NONNULL_END
