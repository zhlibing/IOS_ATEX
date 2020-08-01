//
//  BI_BindEmail_ViewController.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/7/3.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BI_BindEmail_ViewController : SSKJ_BaseViewController
@property (nonatomic, copy) void (^successBlock)(NSString *account);
@property (nonatomic, assign)NSInteger from;

@end

NS_ASSUME_NONNULL_END
