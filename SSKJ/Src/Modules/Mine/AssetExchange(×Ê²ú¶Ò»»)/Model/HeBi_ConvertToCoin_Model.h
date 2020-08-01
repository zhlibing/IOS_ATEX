//
//  HeBi_ConvertToCoin_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_ConvertToCoin_Model : NSObject
@property (nonatomic, strong) NSString *baseCode;   // 持有币种
@property (nonatomic, strong) NSString *dealCode;//被兑换的币种名字
@property (nonatomic, strong) NSString *exchangeFee;//汇率

@property (nonatomic, strong) NSString *exchangeCoinMin;    //最小兑换数量
@property (nonatomic, strong) NSString *exchangeCoinMax;    //最大兑换数量






@end

NS_ASSUME_NONNULL_END
