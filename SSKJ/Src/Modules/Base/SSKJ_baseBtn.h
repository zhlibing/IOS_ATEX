//
//  SSKJ_baseBtn.h
//  SSKJ
//
//  Created by mac on 2019/11/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ButtonType) {
    ButtonType_Default,//登录按钮等
    ButtonType_Radius,//半圆角 渐变色按钮等
    ButtonType_Border,//边框  注册按钮等
};


@interface SSKJ_baseBtn : UIButton

+ (instancetype) creatBtnWithFrame:(CGRect)fraqme title:(NSString *)title font:(UIFont *)font titleColor:(UIColor*)titleColor btnType:(ButtonType)btnType;
+ (instancetype) creatBtnWithFrame:(CGRect)fraqme bgImgeStr:(NSString *)bgImgStr title:(NSString *)title font:(UIFont *)font titleColor:(UIColor*)titleColor btnType:(ButtonType)btnType;



@end

NS_ASSUME_NONNULL_END
