//
//  My_BindPhone_ViewController.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "SSKJ_BaseViewController.h"

typedef NS_ENUM(NSUInteger, BindType) {
    BindTypePhone,
    BindTypeEmail
};

NS_ASSUME_NONNULL_BEGIN

@interface Mine_BindPhone_ViewController : SSKJ_BaseViewController
@property (nonatomic, assign) BindType bindType;


/**
 0绑定 1.修改
 */
@property (nonatomic, assign)NSInteger from;

@property (nonatomic, copy) void (^successBlock)(NSString *account);
@end

NS_ASSUME_NONNULL_END
