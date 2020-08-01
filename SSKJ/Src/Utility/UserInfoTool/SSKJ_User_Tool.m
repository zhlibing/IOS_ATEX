//
//  WL_LoginUser_Tool.m
//  明
//
//  Created by mac for csh on 16/6/3.
//  Copyright © 2016年 WeiLv Technology. All rights reserved.
//

#import "SSKJ_User_Tool.h"

@interface SSKJ_User_Tool()

@end

@implementation SSKJ_User_Tool

+(void)clearUserInfo
{
//    NSUserDefaults *settings=[NSUserDefaults standardUserDefaults];
    SSKJUserDefaultsSET(@"", @"token");
    SSKJUserDefaultsSET(@"", @"account");
    SSKJUserDefaultsSET(@"", @"mobile");
    SSKJUserDefaultsSET(@"", @"kAccount");
    SSKJUserDefaultsSET(@"0", @"kLogin");
    
}

+(SSKJ_User_Tool *)sharedUserTool
{
    
    static SSKJ_User_Tool *sharedSVC=nil;

        static dispatch_once_t onceToken;
        dispatch_once(&onceToken,
        ^{
            
            sharedSVC = [[self alloc] init];
        });
  
    return sharedSVC;
}

#pragma mark -保存登录信息
-(void)saveLoginInfoWithLoginModel:(SSKJ_Login_Model *)loginModel;
{
    NSUserDefaults *settings=[NSUserDefaults standardUserDefaults];
    
    if (![loginModel.mobile isEqual:[NSNull null]]){
        [settings setObject:loginModel.mobile forKey:@"mobile"];
    }
    
    if (![loginModel.token isEqual:[NSNull null]]){
        [settings setObject:loginModel.token forKey:@"token"];
    }
    
    if (![loginModel.account isEqual:[NSNull null]]) {
        [settings setObject:loginModel.account forKey:@"account"];
    }
    
    
    if (![loginModel.account isEqual:[NSNull null]]) {
        [settings setObject:loginModel.username forKey:@"username"];
    }
    
    
    if (![loginModel.account isEqual:[NSNull null]]) {
        [settings setObject:loginModel.nickname forKey:@"nickname"];
    }
    
    
    if (![loginModel.uid isEqual:[NSNull null]]) {
        [settings setObject:loginModel.uid forKey:@"uid"];
    }
    
    if (![loginModel.email isEqual:[NSNull null]]){
        [settings setObject:loginModel.email forKey:@"email"];
    }
    
    
    if (![loginModel.isShop isEqual:[NSNull null]]){
        [settings setObject:loginModel.isShop forKey:@"isShop"];
    }
    
    
    if (![loginModel.invitationCode isEqual:[NSNull null]]){
        [settings setObject:loginModel.invitationCode forKey:@"invitationCode"];
    }
    
    
    
    
    [settings setObject:@"1" forKey:@"kLogin"];
    [settings synchronize];
}

/**
 保存用户信息

 有需要可以保存用户一些属性信息

*/



#pragma mark 设置用户信息
-(void)setUserInfoModel:(SSKJ_UserInfo_Model *)userInfoModel
{
    _userInfoModel = userInfoModel;
    
   
}

#pragma mark - 获取手机号
-(NSString *)getMobile
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"mobile"];
    
}

#pragma mark - 获取token
-(NSString *)getToken
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"token"];
}


#pragma mark - 获取用户account
-(NSString *)getAccount
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"account"];
    
}

// 用户邮箱
-(NSString *)getUserName
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"username"];
}

#pragma mark - 获取用户id
-(NSString *)getUID
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"uid"];
    
}

-(NSString *)getEmail        // 用户邮箱
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"email"];
}


-(NSString *)getIsShop       // 是否是商家 0：false 不是商家  1：true 是商家
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"isShop"];
}



-(NSString*)getInvitationCode
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"invitationCode"];
}





-(MoneyType)currentMoneyType
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString *moneyType = [settings objectForKey:@"moneytype"];
    
    if (moneyType.integerValue == 1 || moneyType.integerValue == 0) {
        return MoneyTypeCNY;
    }else{
        return MoneyTypeUSDT;
    }
}

-(void)setMoneyType:(MoneyType)moneyType
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    if (moneyType == MoneyTypeCNY) {
        [settings setObject:@"1" forKey:@"moneytype"];
    }else{
        [settings setObject:@"2" forKey:@"moneytype"];
    }
    
}

+(void)setLoginType:(LoginType)loginType
{
    NSString *type;
    if (loginType == LoginTypeMobile) {
        type = @"1";
    }else{
        type = @"2";
    }
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings setObject:type forKey:@"logintype"];
}

+(LoginType)getLoginType
{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    
    NSString *type = [settings objectForKey:@"logintype"];
    
    if (type.integerValue == 1) {
        return LoginTypeMobile;
    }else{
        return LoginTypeEmail;
    }
}

@end




























