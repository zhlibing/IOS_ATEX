//
//  LoginAlertView.h
//  ZYW_MIT
//
//  Created by GT on 2019/8/15.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginAlertView : UIView

@property (nonatomic ,strong) void(^sureCallback)();

- (instancetype)showLogInState:(NSString *)msg cancle:(NSString *)cancleStr sure:(NSString *)sureStr;
@end

NS_ASSUME_NONNULL_END
