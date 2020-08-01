//
//  SSKJ_Login_Model.h
//  SSKJ
//
//  Created by 刘小雨 on 2018/12/10.
//  Copyright © 2018年 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSKJ_Login_Model : NSObject
// 手机号
@property (nonatomic, copy) NSString *mobile;

//邮箱
@property (nonatomic, copy) NSString *email;

// token
@property (nonatomic, copy) NSString *token;

// account
@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *username; //!< 用户名称

@property (nonatomic, copy) NSString *nickname; //!< 用户昵称

@property (nonatomic, copy) NSString *invitationCode; //!< 邀请码

// uid
@property (nonatomic, copy) NSString *uid;


//'1:未认证 2:待审核 3:已认证 4:审核未通过  高级认证'
@property (nonatomic, copy) NSString *inspectAuthStatus;

// 是否是商家 0：false 不是商家  1：true 是商家',
@property (nonatomic, copy) NSString *isShop;

// 成为商家冻结保证金
@property (nonatomic, copy) NSString *shopFrostFund;

// 0未绑定  1已绑定   谷歌验证,
@property (nonatomic, copy) NSString *isGoogleAuthentication;

// 0未开启  1已开启    谷歌验证是否开启
@property (nonatomic, copy) NSString *isGoogleOpenClose;

@end

NS_ASSUME_NONNULL_END
