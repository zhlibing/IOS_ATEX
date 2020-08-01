//
//  UILabel+WJUI.h
//  WJShaSengProject
//
//  Created by James on 2018/12/7.
//  Copyright © 2018年 JamesWu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (WJFUN)

#pragma mark - 添加Attributed属性,改变字体的颜色
- (void)text:(NSString *)str color:(UIColor *)color font:(UIFont *)font;

#pragma mark - 改变行间距
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

#pragma mark - 改变字间距
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

#pragma mark - 改变行间距和字间距
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

#pragma mark - 获取已调整区域
- (CGSize)contentSize;

#pragma mark - 设置区域
- (CGSize)textSizeIn:(CGSize)size;
@end

#pragma mark - 自定义偏移labelUI
@interface WJCustomInsetLabel : UILabel
@property (nonatomic, assign) UIEdgeInsets contentInset;

@end

NS_ASSUME_NONNULL_END
