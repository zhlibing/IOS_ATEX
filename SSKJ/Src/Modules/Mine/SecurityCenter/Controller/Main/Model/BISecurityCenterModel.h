//
//  BISecurityCenterModel.h
//  SSKJ
//
//  Created by 姚立志 on 2019/6/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM (NSInteger , BISecurityCenterModelAuthType)
{
    BISecurityCenterNOAuthType = 1, //!< 未认证
    BISecurityCenterAuthType = 2, //!< 已经认证
};

typedef NS_ENUM (NSInteger , BISecurityCenterModelType)
{
    BISecurityCenterModelNormalType = 1, //!< 普通类型
    BISecurityCenterModelSwitchType = 2, //!< 开关类型
    BISecurityCenterModelSectionType = 3, //!< 章节分区类型
    BISecurityCenterModelTipType = 4, //!< 提示类型
    BISecurityCenterModelPaymentType = 5, //!< 支付方式类型
};

typedef NS_ENUM (NSInteger , BISecurityCenterSwitchType)
{
    BISecurityCenterOnType = 0, //!< 开类型
    BISecurityCenterOffType = 1, //!< 关类型
};

typedef NS_ENUM (NSInteger , BISecurityCenterPaymentType)
{
    BISecurityCenterWeiXinType = 1, //!< 微信类型
    BISecurityCenterAliPayType = 2, //!< 支付宝类型
    BISecurityCenterBankCardType = 3, //!< 银行卡类型
};

NS_ASSUME_NONNULL_BEGIN

@interface BISecurityCenterModel : NSObject



@property (nonatomic, copy) NSString *objectid; //!< 支付方式id
@property (nonatomic, copy) NSString *title; //!< 标题
@property (nonatomic, copy) NSString *describe; //!< 描述 / 支付方姓名
@property (nonatomic, copy) NSString *account; //!< 账号
@property (nonatomic, copy) NSString *tip; //!< 提示描述
@property (nonatomic, copy) NSString *qrCode; //!< 二维码url地址
@property (nonatomic, copy) NSString *accountOpeningBranch; //!< 开户支行
@property (nonatomic, copy) NSString *bankCardOpenBank; //!< 开户行




@property (nonatomic, assign) CGFloat height; //!< 行高

@property (nonatomic, assign) BISecurityCenterModelType modelType; //!< 数据模型类型
@property (nonatomic, assign)  BISecurityCenterSwitchType switchType; //!< 开关切换类型
@property (nonatomic, assign) BISecurityCenterPaymentType paymentType; //!< 支付类型
@property (nonatomic, assign) BISecurityCenterModelAuthType authType; //!< 是否认证




#pragma mark 设置数据内容
-(void)setItemObject:(NSDictionary*)object;




@end

NS_ASSUME_NONNULL_END
