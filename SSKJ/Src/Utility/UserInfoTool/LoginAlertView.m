//
//  LoginAlertView.m
//  ZYW_MIT
//
//  Created by GT on 2019/8/15.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "LoginAlertView.h"


@interface LoginAlertView()

@property (nonatomic ,strong) UIButton *sureBtn;
@property (nonatomic ,strong) UIButton *cancleBtn;

@end


@implementation LoginAlertView


- (instancetype)showLogInState:(NSString *)msg cancle:(NSString *)cancleStr sure:(NSString *)sureStr {
    
    UIWindow *kw = [UIApplication sharedApplication].keyWindow;
    
    UIView *bgView = [[UIView alloc] initWithFrame:kw.bounds];
    [kw addSubview:bgView];
    
    bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    LoginAlertView *alertV = [[LoginAlertView alloc] initWithFrame:CGRectMake(ScaleW(30), 0, ScreenWidth - ScaleW(60), ScaleW(145))];
    alertV.backgroundColor = kBgColor;
    
    alertV.layer.cornerRadius = ScaleW(10);
    alertV.layer.masksToBounds = YES;
    
    
    UILabel *titltLb = [UILabel new];
    UILabel *msgLb = [UILabel new];
    
    UIButton *cancleBtn = [UIButton new];
    UIButton *sureBtn = [UIButton new];
    
    [alertV addSubview:titltLb];
    [alertV addSubview:msgLb];
    [alertV addSubview:sureBtn];
    [alertV addSubview:cancleBtn];
    
    [bgView addSubview:alertV];
    alertV.center = bgView.center;

    msgLb.text = msg;
    [cancleBtn setTitle:SSKJLocalized(cancleStr, nil) forState:UIControlStateNormal];
    
    [sureBtn setTitle:SSKJLocalized(sureStr, nil) forState:UIControlStateNormal];
    
    msgLb.font = systemFont(ScaleW(15));
    msgLb.textAlignment = NSTextAlignmentCenter;
    msgLb.textColor = RGBCOLOR(136,141,157);
    msgLb.numberOfLines = 0;
    cancleBtn.titleLabel.font = sureBtn.titleLabel.font = systemFont(ScaleW(15));
    [cancleBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.backgroundColor = kBlueColor;
    cancleBtn.layer.cornerRadius = sureBtn.layer.cornerRadius = ScaleW(18);
    cancleBtn.layer.masksToBounds = sureBtn.layer.masksToBounds = YES;
    cancleBtn.layer.borderWidth = 1;
    cancleBtn.layer.borderColor = kBlueColor.CGColor;
    [msgLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(alertV.mas_top).offset(ScaleW(34));
        make.left.right.mas_equalTo(alertV);
    }];
    
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(alertV.mas_left).offset(ScaleW(37));
        make.bottom.mas_equalTo(alertV.mas_bottom).offset(ScaleW(-20));
        make.width.mas_equalTo(ScaleW(105));
        make.height.mas_equalTo(ScaleW(36));
    }];
    
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(alertV.mas_right).offset(ScaleW(-37));
        make.bottom.mas_equalTo(alertV.mas_bottom).offset(ScaleW(-20));
        make.width.mas_equalTo(ScaleW(105));
        make.height.mas_equalTo(ScaleW(36));
    }];
    
    sureBtn.tag = 101;
    cancleBtn.tag = 100;
    
    alertV.sureBtn = sureBtn;
    alertV.cancleBtn = cancleBtn;
    
    [sureBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [UIView animateWithDuration:0.3 animations:^{
        [UIColor colorWithWhite:0.0 alpha:0.6];
    } completion:^(BOOL finished) {
    }];
    return alertV;
    
}

- (void) clickBtn:(UIButton *)sender{
    NSInteger index = sender.tag - 100;

    if (index == 0) {
    }else{
        !self.sureCallback ? : self.sureCallback();
    }
    [sender.superview.superview removeFromSuperview];

}




@end
