//
//  My_Default_AlertView.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface My_Default_AlertView : UIView
@property (nonatomic, copy) void (^confirmBlock)(void);
-(void)showWithTitle:(NSString *)title message:(NSString *)message;

-(void)hide;
@end

NS_ASSUME_NONNULL_END
