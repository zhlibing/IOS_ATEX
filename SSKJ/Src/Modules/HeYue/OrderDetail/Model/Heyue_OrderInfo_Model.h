//
//  Heyue_OrderInfo_Model.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/8/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Heyue_OrderInfo_Model : NSObject

/**
 可用
 */
@property (nonatomic,copy) NSString * keyong_price;

/**
 冻结保证金
 */
@property (nonatomic,copy) NSString * totaldeposit;

/**
 风险度
 */
@property (nonatomic,copy) NSString * risk;

/**
 平仓盈亏
 */
@property (nonatomic,copy) NSString * pingcang;

/**
 动态权益
 */
@property (nonatomic,copy) NSString * totalusdt;

/**
 浮动盈亏
 */
@property (nonatomic,copy) NSString * yingkui;

@end

NS_ASSUME_NONNULL_END
