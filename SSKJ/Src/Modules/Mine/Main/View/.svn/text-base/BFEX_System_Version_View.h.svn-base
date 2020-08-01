//
//  BFEX_System_Version_View.h
//  ZYW_MIT
//
//  Created by James on 2018/7/5.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFEX_System_Version_View : UIView

//弹出框
@property(nonatomic,strong)UIView *mainView;

@property (nonatomic,strong) UIView *alertView;

@property(nonatomic,strong)UIImageView *versionIMV;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UITextView *msgTextView;

@property(nonatomic,strong)UIButton *cancelButton;

@property(nonatomic,strong)UIButton *sureButton;

@property(nonatomic,strong)UIView *lineView;

@property(nonatomic,strong)UILabel *guanbilabel;


@property(nonatomic,copy)void (^sureButtonBlock)(void);
@property(nonatomic,copy)void (^cancleButtonBlock)(void);

/**
 * 设置隐藏/显示
 */
- (void)hide:(BOOL)hidden;

-(void)initWithTitle:(NSString *)title andMessage:(NSString *)message;

@end
