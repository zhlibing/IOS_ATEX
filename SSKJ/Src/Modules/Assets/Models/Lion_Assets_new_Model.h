//
//  Lion_Assets_new_Model.h
//  SSKJ
//
//  Created by mac on 2020/4/3.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 {
     "usableFund": 1E+3,//可用资产
     "usdFund": 1E+3,//usd折合
     "codeName": "USDT",//币种
     "hasUsedFund": 4575086.748//冻结
     "allFund"  //总数
 },
 
 */


@interface Lion_Assets_new_Model : NSObject


@property (nonatomic ,copy) NSString *frost;  //!< 冻结
@property (nonatomic, copy) NSString *total_rmb;  //!< 可用人民币
@property (nonatomic, copy) NSString *balance; //!<  可用总USDT

@end

NS_ASSUME_NONNULL_END
