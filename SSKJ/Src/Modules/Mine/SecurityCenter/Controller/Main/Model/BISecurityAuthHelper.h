//
//  BISecurityAuthHelper.h
//  SSKJ
//
//  Created by 姚立志 on 2019/6/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//



#pragma mark 关于用户等级认证辅助类




#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BISecurityAuthHelper : NSObject



#pragma mark 如果所有条件都满足，返回YES，否则返回NO
-(BOOL)authWithObject:(UIViewController*)object;

#pragma mark 申请商家如果所有条件都满足，返回YES，否则返回NO
-(BOOL)authSellerWithObject:(UIViewController*)object;


#pragma mark 是否绑定谷歌验证器 返回YES，否则返回NO
-(BOOL)authGooleWithObject:(UIViewController*)object;

@end

NS_ASSUME_NONNULL_END
