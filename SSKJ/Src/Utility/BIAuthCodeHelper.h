//
//  BIAuthCodeHelper.h
//  SSKJ
//
//  Created by 姚立志 on 2019/6/21.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BIAuthCodeHelper : NSObject



@property (nonatomic,copy) void (^SentSuccessfullyBlock)(BOOL Sucess);
#pragma mark 获取验证码
/**
 获取验证码
 
 @param type 验证码类型（1注册2忘记密码3绑定4设置资金密码5谷歌验证6修改登录密码）
 */
-(void)authWithAccount:(NSString*)account withType:(NSString*)type;



@end

NS_ASSUME_NONNULL_END
