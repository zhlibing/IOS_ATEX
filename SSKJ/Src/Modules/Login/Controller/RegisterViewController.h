//
//  RegisterViewController.h
//  SSKJ
//
//  Created by zpz on 2019/6/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegisterViewController : SSKJ_BaseViewController
@property (nonatomic, copy) void (^registerSuccessBlock)(NSString *account);
@end

NS_ASSUME_NONNULL_END
