//
//  UncaughtExceptionHandler.h
//  ICC
//
//  Created by James on 2018/6/8.
//  Copyright © 2018年 WeiLv Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UncaughtExceptionHandler : NSObject
/*!
 *  异常的处理方法
 *
 *  @param install   是否开启捕获异常
 *  @param showAlert 是否在发生异常时弹出alertView
 */
+ (void)installUncaughtExceptionHandler:(BOOL)install showAlert:(BOOL)showAlert;
@end
