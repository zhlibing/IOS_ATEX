//
//  My_Yuanli_Model.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/1.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface My_Yuanli_Model : NSObject
//@property (nonatomic, strong) NSString *memo;
//@property (nonatomic, strong) NSString *price;
//@property (nonatomic, strong) NSString *realname;
//@property (nonatomic, strong) NSString *dtime;
//@property (nonatomic, strong) NSString *addtime;


#pragma java
@property (nonatomic, copy) NSString *userReturnFee; // 佣金
@property (nonatomic, copy) NSString *createTime; // 注册时间
@property (nonatomic, copy) NSString *username; // 姓名
@property (nonatomic, copy) NSString *tel; // 电话
@property (nonatomic, copy) NSString *email; // 邮箱
@property (nonatomic, copy) NSString *code; // 币种
//@property (nonatomic, copy) NSString *userUid;
@property (nonatomic, copy) NSString *stockUserId;// 用户ID

@property (nonatomic, copy) NSString *money;//  操作金额
@property (nonatomic, copy) NSString *marketLevel;//  返佣等级
@property (nonatomic, copy) NSString *userUid;//  用户UID

@property (nonatomic, copy) NSString *userReturnRatio;//  返佣等级


@end

NS_ASSUME_NONNULL_END
