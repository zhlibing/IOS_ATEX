//
//  BIAuthCodeHelper.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "BIAuthCodeHelper.h"

@implementation BIAuthCodeHelper




#pragma mark 获取验证码
/**
 获取验证码
 
 @param type 验证码类型（1注册2忘记密码3绑定4设置资金密码5谷歌验证6修改登录密码）
 */
-(void)authWithAccount:(NSString*)account withType:(NSString*)type
{
    [MBHUD showHUDAddedTo:AppWindow];
    
    NSDictionary *parameters = @{@"account":account,@"codeType":type,@"id":kUserID,
    };
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_GetSmsCode_URL RequestType:RequestTypeGet Parameters:parameters Success:^(NSInteger statusCode, id responseObject)
     {
         [MBHUD hideHUDForView:AppWindow];
         
         WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         if (net_model.status.integerValue == SUCCESSED)
         {
             if (self.SentSuccessfullyBlock)
             {
                 self.SentSuccessfullyBlock(YES);
             }
             [MBProgressHUD showError:SSKJLocalized(@"发送成功", nil)];
         }
         else
         {
             [MBHUD showError:net_model.msg];
             if (self.SentSuccessfullyBlock)
             {
                 self.SentSuccessfullyBlock(NO);
             }
         }
         
         
         
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBHUD hideHUDForView:AppWindow];
         [MBHUD showError:SSKJLocalized(@"网络错误", nil)];
         if (self.SentSuccessfullyBlock)
         {
             self.SentSuccessfullyBlock(NO);
         }
     }];
}


@end
