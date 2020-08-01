//
//  My_TitleAndInput_View.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Mine_TitleAndInput_View : UIView
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, copy) NSString *valueString;
-(instancetype)initWithFrame:(CGRect )frame title:(NSString *)title placeHolder:(NSString *)placeHolder keyBoardType:(UIKeyboardType)keyBoardType isSecure:(BOOL)isSecure;

@property (nonatomic ,assign) CGFloat space;//间距
@property (nonatomic ,assign) CGFloat tfWidth;//间距

@property (nonatomic ,strong) void(^tfValueChange)(NSString *text);


@end

NS_ASSUME_NONNULL_END
