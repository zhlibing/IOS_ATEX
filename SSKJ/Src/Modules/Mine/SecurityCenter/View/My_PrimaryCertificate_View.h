//
//  My_PrimaryCertificate_View.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark 实名认证视图

NS_ASSUME_NONNULL_BEGIN

@interface My_PrimaryCertificate_View : UIControl

@property (nonatomic, copy) void (^clickBlock)(void);


-(void)setUserModel:(SSKJ_UserInfo_Model*)model;


@end

NS_ASSUME_NONNULL_END
