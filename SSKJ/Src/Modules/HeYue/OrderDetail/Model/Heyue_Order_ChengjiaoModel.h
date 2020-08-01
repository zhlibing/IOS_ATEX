//
//  Heyue_Order_ChengjiaoModel.h
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/16.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Heyue_Order_ChengjiaoModel : NSObject


@property (nonatomic, copy) NSString *ID;

/**
 过夜费
 */
@property (nonatomic, copy) NSString *dayfee;


/**
 币种代码
 */
@property (nonatomic, copy) NSString *code;

/**
 委托订单ID
 */
@property (nonatomic,copy) NSString * hold_num;


/**
 持仓价
 */
@property (nonatomic,copy) NSString * buyprice;
/**
 平仓价
 */
@property (nonatomic,copy) NSString * sellprice;




/**
 1市价 2限价委托
 */
@property (nonatomic, copy) NSString *type;



/**
 建仓时间
 */
@property(nonatomic, copy)NSString *jiancang_at;


/**
 平仓时间
 */
@property(nonatomic, copy)NSString *created_at;

/**
 买入方向 1涨 2跌
 */
@property (nonatomic,copy) NSString * otype;

/**
 成手手数(买入数量）
 */
@property(nonatomic, copy)NSString *buynum;

/**
 成手手数(买入张数）
 */
@property(nonatomic, copy)NSString *hands;




/**
 杠杆倍数
 */
@property (nonatomic,copy) NSString * leverage;

/**
 手续费
 */
@property (nonatomic,copy) NSString * fee;



/**
 止损价格
 */
@property (nonatomic,copy) NSString * stoploss;

/**
 止盈价格
 */
@property (nonatomic,copy) NSString * stopwin;

/**
 保证金
 */
@property (nonatomic,copy) NSString * totalprice;

/**
 最新价
 */
@property(nonatomic, copy)NSString *marketPrice;


//盈亏
@property(nonatomic, copy)NSString *profit;

////平仓类型 1手动平仓 2止盈平仓 3止损平仓 4爆仓
@property(nonatomic, copy)NSString *pc_type;



@end

NS_ASSUME_NONNULL_END
