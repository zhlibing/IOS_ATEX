//
//  ATEX_Extract_IndexModel.h
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/16.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATEX_Extract_IndexModel : NSObject
@property (nonatomic, copy) NSString *address;  // 提币地址
@property (nonatomic, copy) NSString *money;  // 提笔金额
@property (nonatomic, copy) NSString *handling_fee;  // 提笔手续费
@property (nonatomic, copy) NSString *actual;  // 实际到账
@property (nonatomic, copy) NSString *created_at;  // 创建时间
@property (nonatomic, copy) NSString *checked_at;  // 审核时间
@property (nonatomic, copy) NSString *status;  // 1 待审核 2到账中 3已拒绝 4已到账 5失败

@property (nonatomic, copy) NSString *refuse_reason;    // 失败原因
@end

NS_ASSUME_NONNULL_END
