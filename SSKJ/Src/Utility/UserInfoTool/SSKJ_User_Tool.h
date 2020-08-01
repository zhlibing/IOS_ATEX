//
//  WL_LoginUser_Tool.h
//  明
//
//  Created by mac for csh on 16/6/3.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "WL_Network_Model.h"

#import "SSKJ_Login_Model.h"

#import "SSKJ_UserInfo_Model.h"

#define kUserDefaults [NSUserDefaults standardUserDefaults]

#define kLogin [[kUserDefaults objectForKey:@"kLogin"]boolValue]    // 是否登录

#define kAccount [kUserDefaults objectForKey:@"kAccount"]?:@""  // 登录账号

#define kUserID [kUserDefaults objectForKey:@"uid"]?:@""        // uid








typedef NS_ENUM(NSUInteger, MoneyType)
{
    MoneyTypeCNY,
    MoneyTypeUSDT
};

typedef NS_ENUM(NSUInteger, LoginType)
{
    LoginTypeMobile,
    LoginTypeEmail
};

@interface SSKJ_User_Tool : NSObject


@property (nonatomic, strong) SSKJ_UserInfo_Model *userInfoModel; //!< 保存用户信息

//  清除本地保存的用户信息
+(void)clearUserInfo;

// 单例
+(SSKJ_User_Tool *)sharedUserTool;


// 保存登录信息
-(void)saveLoginInfoWithLoginModel:(SSKJ_Login_Model *)loginModel;


-(NSString *)getMobile; // 用户手机号

-(NSString *)getToken;  // 用户token

-(NSString *)getAccount;  // 用户acount

-(NSString *)getUID;        // 用户id

-(NSString *)getEmail;        // 用户邮箱

-(NSString *)getUserName;        // 用户邮箱

-(NSString *)getIsShop;        // 是否是商家 0：false 不是商家  1：true 是商家

-(NSString*)getInvitationCode; //!< 邀请码



// 计价方式
-(MoneyType)currentMoneyType;

-(void)setMoneyType:(MoneyType)moneyType;


// 登录方式
+(void)setLoginType:(LoginType)loginType;

+(LoginType)getLoginType;


@end

















