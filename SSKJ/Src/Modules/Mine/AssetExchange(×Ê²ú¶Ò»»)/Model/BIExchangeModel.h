//
//  BIExchangeModel.h
//  SSKJ
//
//  Created by 姚立志 on 2019/6/27.
//  Copyright © 2019 刘小雨. All rights reserved.
//


typedef NS_ENUM(NSInteger,BIExchangeModelType)
{
    BIExchangeModelLeftType = 1, //!< 左侧用户持有币种
    BIExchangeModelRightType = 2, //!< 右侧要兑换币种
};


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BIExchangeModel : NSObject

@property (nonatomic, copy) NSString *objectid; //!< 对象id


#pragma mark 用户持有资产
@property (nonatomic, copy) NSString *stockCode;
@property (nonatomic, copy) NSString *stockName;
@property (nonatomic, copy) NSString *stockType;
@property (nonatomic, copy) NSString *usableFund; //!<可用**
@property (nonatomic, copy) NSString *frostFund; //!<冻结
@property (nonatomic, copy) NSString *inAllFee;
@property (nonatomic, copy) NSString *outAllFee;



#pragma mark 兑换币
@property (nonatomic, copy) NSString *ex_rate; //!< 兑换汇率
@property (nonatomic, copy) NSString *baseCode; //!< 持有币种
@property (nonatomic, copy) NSString *dealCode; //!< 兑换币种
@property (nonatomic, copy) NSString *exchangeCoinMax; //!< 最大兑换量
@property (nonatomic, copy) NSString *exchangeCoinMin; //!< 最小兑换量
@property (nonatomic, copy) NSString *exchangeFee; //!< 兑换费用







@property (nonatomic, assign) BIExchangeModelType type; 






@end

NS_ASSUME_NONNULL_END
