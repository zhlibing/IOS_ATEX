//
//  HeBi_Default_AlertView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSKJ_Default_AlertView : UIView

+(void)showWithTitle:(NSString *)title message:(NSString *)message cancleTitle:(NSString *)cancleTitle confirmTitle:(NSString *)confirmTitle confirmBlock:(void(^)(void))confirmblock;
@end

NS_ASSUME_NONNULL_END
