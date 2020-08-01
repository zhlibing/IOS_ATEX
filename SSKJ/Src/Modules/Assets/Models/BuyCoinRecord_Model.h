//
//  BuyCoinRecord_Model.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2020/3/23.
//  Copyright © 2020 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BuyCoinRecord_Model : NSObject
@property (nonatomic, copy) NSString *usdt;  // 充值的USDT数量
@property (nonatomic, copy) NSString *arrival_at;// 到账时间
@property (nonatomic, copy) NSString *created_at;//created_at
@property (nonatomic, copy) NSString *status;        //1确认中（未支付）2已支付

@end

NS_ASSUME_NONNULL_END
