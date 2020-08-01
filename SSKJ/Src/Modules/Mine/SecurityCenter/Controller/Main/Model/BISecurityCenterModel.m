//
//  BISecurityCenterModel.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "BISecurityCenterModel.h"

@implementation BISecurityCenterModel


-(void)setModelType:(BISecurityCenterModelType)modelType
{
    _modelType = modelType;
    switch (modelType)
    {
        case BISecurityCenterModelNormalType:
        {
            [self setHeight:ScaleW(60.0)];
        }
            break;
        case BISecurityCenterModelSwitchType:
        {
            [self setHeight:ScaleW(60.0)];
        }
            break;
        case BISecurityCenterModelSectionType:
        {
            [self setHeight:ScaleW(10.0)];
        }
            break;
        case BISecurityCenterModelTipType:
        {
            [self setHeight:ScaleW(100.0)];
        }
            break;
        case BISecurityCenterModelPaymentType:
        {
            [self setHeight:ScaleW(100.0)];
        }
            break;
    }
}



#pragma mark 设置数据内容
-(void)setItemObject:(NSDictionary*)object
{
    [self setPaymentType:(BISecurityCenterPaymentType)[[object objectForKey:@"payType"] integerValue]];
    [self setObjectid:[object objectForKey:@"id"]];
    [self setDescribe:[SSKJ_User_Tool sharedUserTool].userInfoModel.username];
    switch (self.paymentType)
    {
        case BISecurityCenterWeiXinType:
        {
            [self setTitle:SSKJLocalized(@"微信", nil)];
            [self setAccount:[object objectForKey:@"account"]];
            [self setQrCode:[object objectForKey:@"qrCode"]];
            [self setSwitchType:(BISecurityCenterSwitchType)[[object objectForKey:@"status"] integerValue]];
            
        }
            break;
        case BISecurityCenterAliPayType:
        {
            [self setTitle:@"支付宝"];
            [self setAccount:[object objectForKey:@"account"]];
            [self setQrCode:[object objectForKey:@"qrCode"]];
            [self setSwitchType:(BISecurityCenterSwitchType)[[object objectForKey:@"status"] integerValue]];
        }
            break;
        case BISecurityCenterBankCardType:
        {
            [self setTitle:@"银联"];
            [self setAccount:[object objectForKey:@"account"]];
            [self setBankCardOpenBank:[object objectForKey:@"bankCardOpenBank"]];
            [self setAccountOpeningBranch:[object objectForKey:@"AccountOpeningBranch"]];
            [self setSwitchType:(BISecurityCenterSwitchType)[[object objectForKey:@"status"] integerValue]];
        }
            break;
    }
    
    
    
    
    
    
   
}



@end
