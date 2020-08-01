//
//  Heyue_OrderDdetail_Model.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/8/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Heyue_OrderDdetail_Model : NSObject



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
 1市价 2限价委托
 */
@property (nonatomic, copy) NSString *type;




/**
 委托时间
 */
@property(nonatomic, copy)NSString *created_at;


/**
 买入方向 1涨 2跌
 */
@property (nonatomic,copy) NSString *otype;

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


/**
 最新价(委托订单使用)
 */
@property(nonatomic, copy)NSString *market_price;


//持仓浮动盈亏
@property(nonatomic, copy)NSString *floating;


/**
 最新价
 */
//@property(nonatomic, copy)NSString *newPrice;


@end

NS_ASSUME_NONNULL_END
