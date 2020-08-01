//
//  SSKJ_BaseViewController.h
//  SSKJ
//
//  Created by 刘小雨 on 2018/12/6.
//  Copyright © 2018年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSKJ_BaseViewController : UIViewController

/*
 * 修改导航栏字体颜色
 */
-(void)setTitleColor:(UIColor *)titleColor;

/*
 * 修改导航栏字体
 */
-(void)setTitleFont:(UIFont *)font;

/*
 * 修改导航栏背景色
 */
-(void)setNavgationBackgroundColor:(UIColor *)navigationBackgroundColor alpha:(CGFloat)alpha;

/*
 * 修改导航栏左侧按钮
 */
- (void)addLeftNavItemWithImage:(UIImage*)image;

/*
 * 修改导航栏左侧按钮
 */
- (void)addLeftNavItemWithTitle:(NSString*)title color:(UIColor *)color font:(UIFont *)font;

/*
 * 返回按钮点击事件
 */
- (void)leftBtnAction:(id)sender;

/*
 * 添加导航栏右侧按钮
 */
- (void)addRightNavItemWithTitle:(NSString*)title color:(UIColor *)color font:(UIFont *)font;

/*
 * 添加导航栏右侧按钮
 */
- (void)addRightNavgationItemWithImage:(UIImage*)image;

/*
 * 导航栏右侧按钮点击事件
 */
- (void)rigthBtnAction:(id)sender;

/*
 * 导航栏是否隐藏
 */
-(void)setNavigationBarHidden:(BOOL)isHidden;


-(void)changeTitle:(NSString *)title;

// 弹出登录提示框
-(void)showLoginAlert;
// 直接弹出登录页面
-(void)presentLoginController;

// 判断是设置资金密码。没有则跳转到设置资金密码页面
-(BOOL)judgePayPassword;

// 判断一级认证
-(BOOL)judgeFristCertificate;



- (UIView *)getLineView;
- (UIView *)getLine;

@end

NS_ASSUME_NONNULL_END
