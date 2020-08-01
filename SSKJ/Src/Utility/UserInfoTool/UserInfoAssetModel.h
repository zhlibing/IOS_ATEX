//
//  UserInfoAssetModel.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2020/3/25.
//  Copyright © 2020 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoAssetModel : NSObject
@property (nonatomic, copy) NSString *balance;  // usdt账户余额
@property (nonatomic, copy) NSString *frost;  //    冻结的usdt金额
@property (nonatomic, copy) NSString *fee;  //      手续费佣金余额
@property (nonatomic, copy) NSString *integral;  // 用户SK余额
@property (nonatomic, copy) NSString *total_recharge;  //   总充值
@property (nonatomic, copy) NSString *total_withdraw;  //   总提现
@property (nonatomic, copy) NSString *total_commission;  // 总佣金
@property (nonatomic, copy) NSString *rmb;  // 人民币

@property (nonatomic, copy) NSString *uid;  //

@property (nonatomic, copy) NSString *experience;// 体验金

@end

NS_ASSUME_NONNULL_END
