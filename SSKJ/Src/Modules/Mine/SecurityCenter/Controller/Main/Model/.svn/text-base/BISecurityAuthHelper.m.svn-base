//
//  BISecurityAuthHelper.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "BISecurityAuthHelper.h"
#import "My_PrimaryCertificate_ViewController.h"  //!< 实名认证
#import "My_AdvancedCertificate_ViewController.h"  //!<高级认证
#import "My_SetTPWD_ViewController.h"  //!< 设置交易密码
#import "BFEX_FBC_Apply_Bussiness_ViewController.h" //!< 申请成为商家




@implementation BISecurityAuthHelper



#pragma mark 如果所有条件都满足，返回YES，否则返回NO
-(BOOL)authWithObject:(UIViewController*)object
{
    /*
     逻辑顺序就是，
     首先判断的是否实名认证，如果未实名认证，就提示去实名认证
     其次判断是否已经高级认证，如果未认证，就提示去高级认证
     最后判断是否设置了支付密码，如果已经设置，就直接开启兑换。
     */
    
    #pragma mark => 首先判断的是否实名认证，如果未实名认证，就提示去实名认证
    if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.basicAuthenticationStatus isEqualToString:@"0"])
    {
        [SSKJ_Default_AlertView showWithTitle:SSKJLocalized(@"提示", nil) message:SSKJLocalized(@"您还未完成初级实名认证，去完成?", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确定", nil) confirmBlock:^{
            
            My_PrimaryCertificate_ViewController *primary = [[My_PrimaryCertificate_ViewController alloc]init];
            [object.navigationController pushViewController:primary animated:YES];
        }];
        
        
        
    }
    else if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.basicAuthenticationStatus isEqualToString:@"1"])
    {
        /**
         高级认证状态 1:未认证 2:待审核 3:已认证 4:审核未通过
         */
        #pragma mark => 其次判断是否已经高级认证，如果未认证，就提示去高级认证
        if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.highAuthenticationStatus isEqualToString:@"1"])
        {
            
            [SSKJ_Default_AlertView showWithTitle:SSKJLocalized(@"提示", nil) message:SSKJLocalized(@"您还未完成高级实名认证，去完成?", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确定", nil) confirmBlock:^{
                My_AdvancedCertificate_ViewController *primary = [[My_AdvancedCertificate_ViewController alloc]init];
                [object.navigationController pushViewController:primary animated:YES];
            }];
            
        }
        else if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.highAuthenticationStatus isEqualToString:@"2"])
        {
            [MBHUD showSuccess:SSKJLocalized(@"您的高级认证正在审核，请耐心等待", nil)];
        }
        else if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.highAuthenticationStatus isEqualToString:@"3"])
        {
            #pragma mark => 最后判断是否设置了支付密码，如果已经设置，就直接开启兑换
            /**
             资金密码设置状态  1已设置  0未设置
             */
            if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.tradePswdStatus isEqualToString:@"0"])
            {
                My_SetTPWD_ViewController *setPayPwdVC = [[My_SetTPWD_ViewController alloc] init];
                
                switch ([SSKJ_User_Tool getLoginType])
                {
                    case LoginTypeMobile:
                    {
                        [setPayPwdVC setPhoneNumber:[SSKJ_User_Tool sharedUserTool].getMobile];
                    }
                        break;
                    case LoginTypeEmail:
                    {
                        [setPayPwdVC setPhoneNumber:[SSKJ_User_Tool sharedUserTool].getEmail];
                    }
                        break;
                }
                [object.navigationController pushViewController:setPayPwdVC animated:YES];
            }
            else if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.tradePswdStatus isEqualToString:@"1"])
            {
                return YES;
            }
        }
        else if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.highAuthenticationStatus isEqualToString:@"4"])
        {
            
            [SSKJ_Default_AlertView showWithTitle:SSKJLocalized(@"提示", nil) message:SSKJLocalized(@"您的高级实名认证审核失败，请重新认证", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确定", nil) confirmBlock:^{
                My_AdvancedCertificate_ViewController *primary = [[My_AdvancedCertificate_ViewController alloc]init];
                [object.navigationController pushViewController:primary animated:YES];
            }];
        }
    }
    
    return NO;
}



#pragma mark 申请商家如果所有条件都满足，返回YES，否则返回NO
-(BOOL)authSellerWithObject:(UIViewController*)object
{
    if ([self authWithObject:object])
    {
//        if ([[SSKJ_User_Tool sharedUserTool].getIsShop integerValue] == 1)
//        {
//            return YES;
//        }
//        else
//        {
            if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.shopAuthenticationStatus isEqualToString:@"1"])
            {
                BFEX_FBC_Apply_Bussiness_ViewController *apply = [[BFEX_FBC_Apply_Bussiness_ViewController alloc] init];
                
                [object.navigationController pushViewController:apply animated:YES];
            }
            else if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.shopAuthenticationStatus isEqualToString:@"2"])
            {
                 [MBHUD showSuccess:SSKJLocalized(@"您的商家认证正在审核，请耐心等待", nil)];
            }
            else if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.shopAuthenticationStatus isEqualToString:@"3"])
            {
                return YES;
            }
            else if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.shopAuthenticationStatus isEqualToString:@"4"])
            {
                [SSKJ_Default_AlertView showWithTitle:SSKJLocalized(@"提示", nil) message:SSKJLocalized(@"您的商家认证审核失败，请重新认证", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确定", nil) confirmBlock:^{
                    
                    BFEX_FBC_Apply_Bussiness_ViewController *apply = [[BFEX_FBC_Apply_Bussiness_ViewController alloc] init];
                    [object.navigationController pushViewController:apply animated:YES];
                }];
            }
            
//        }
    }
    return NO;
}



#pragma mark 是否绑定谷歌验证器 返回YES，否则返回NO
-(BOOL)authGooleWithObject:(UIViewController*)object
{
    if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.googleAuthenticationStatus isEqualToString:@"0"])
    {
        return NO;
    }
    else if ([[SSKJ_User_Tool sharedUserTool].userInfoModel.googleAuthenticationStatus isEqualToString:@"1"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}




@end
