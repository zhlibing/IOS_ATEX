//
//  My_SetTPWD_ViewController.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/1.
//  Copyright © 2019年 Wang. All rights reserved.
//


#pragma mark - 设置交易密码

#import "SSKJ_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface Mine_SetFundPwd_ViewController : SSKJ_BaseViewController


@property (nonatomic, copy) void (^statusBlock)(void);
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic) BOOL isEdit;
@end

NS_ASSUME_NONNULL_END
