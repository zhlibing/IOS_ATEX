//
//  HeBi_ConvertRecord_Index_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/18.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_ConvertRecord_Index_Model : NSObject
@property (nonatomic, copy) NSString *dealNum;  //兑换数量
@property (nonatomic, copy) NSString *baseCode;    // 兑换币种名称
@property (nonatomic, copy) NSString *dealMoney;  //兑换成的币数量
@property (nonatomic, copy) NSString *dealCode;  //兑换成的币种名称
//@property (nonatomic, copy) NSString *memo;  //备注
@property (nonatomic, copy) NSString *createTime;  //兑换时间


/*
"num": "100.0000",
"exnum": "10.0000",
"pname": "USDT",
"expname": "KT",
"memo": "USDT兑换KT",
"addtime": "1542698606"
 */

@end

NS_ASSUME_NONNULL_END
