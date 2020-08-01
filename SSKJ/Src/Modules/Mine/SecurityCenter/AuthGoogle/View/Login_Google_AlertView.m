//
//  Login_Google_AlertView.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/2.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "Login_Google_AlertView.h"

@interface Login_Google_AlertView ()
@property (nonatomic, strong) UIView *alertView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *cancleButton;

@property(nonatomic, strong)UIButton *copyBtn;

@property (nonatomic, strong) UILabel *codeTitleLabel;
@property (nonatomic, strong) UITextField *codeTextField;

@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic ,strong) UIView *colorsView;
@end

@implementation Login_Google_AlertView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self setUI];
        

    }
    return self;
}



-(void)setUI
{
    [self addSubview:self.alertView];
    [self.alertView addSubview:self.titleLabel];
    [self.alertView addSubview:self.cancleButton];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _titleLabel.bottom + ScaleW(15), ScreenWidth, 0.5)];
    line.backgroundColor = kLineColor;
    [self.alertView addSubview:line];
    
    [self.alertView addSubview:self.codeTitleLabel];
    [self.alertView addSubview:self.codeTextField];
    [self.alertView addSubview:self.copyBtn];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(ScaleW(15), _codeTextField.bottom + ScaleW(5), ScreenWidth - ScaleW(30), 0.5)];
    line1.backgroundColor = kLineColor;
    [self.alertView addSubview:line1];
    
    [self.alertView addSubview:self.confirmButton];
    
    self.alertView.height = self.confirmButton.bottom + ScaleW(27);
    self.alertView.bottom = self.bottom;
    
    UIView *topV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - self.alertView.height)];
    topV.backgroundColor = [UIColor clearColor];
    [self addSubview:topV];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [topV addGestureRecognizer:tap];
    self.cancleButton.hidden = YES;
    self.copyBtn.hidden = YES;
    
    self.colorsView = [UIView new];
    self.colorsView.frame = self.confirmButton.frame;
    self.colorsView.layer.cornerRadius = ScaleW(5);
    [self.colorsView setCornerRadius:ScaleW(5) corners:UIRectCornerAllCorners colors:@[UIColorFromRGB(0x529CFE), UIColorFromRGB(0x1E4EBC)]];
    [self.alertView insertSubview:self.colorsView belowSubview:self.confirmButton];
    
}

-(UIView *)alertView
{
    if (nil == _alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        _alertView.backgroundColor = kBgColor;
//        _alertView.layer.cornerRadius = 8.0f;
    }
    return _alertView;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"安全验证", nil) font:systemFont(ScaleW(17)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), ScaleW(28), ScaleW(200), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(self.alertView.width - ScaleW(100), 0, ScaleW(100), ScaleW(40))];
        _cancleButton.centerY = self.titleLabel.centerY;
        [_cancleButton setTitle:SSKJLocalized(@"取消", nil) forState:UIControlStateNormal];
        [_cancleButton setTitleColor:kBlueColor forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = systemFont(ScaleW(14));
        [_cancleButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(UIButton *)copyBtn
{
    if (nil == _copyBtn) {
        _copyBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.alertView.width - ScaleW(80), 0, ScaleW(80), ScaleW(20))];
        _copyBtn.centerY = self.codeTextField.centerY;
        _copyBtn.centerX = self.cancleButton.centerX;
        [_copyBtn setTitle:SSKJLocalized(@"粘贴", nil) forState:UIControlStateNormal];
        [_copyBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
        _copyBtn.titleLabel.font = systemFont(ScaleW(14));
        [_copyBtn addTarget:self action:@selector(copygoogle) forControlEvents:UIControlEventTouchUpInside];
    }
    return _copyBtn;
}


-(UILabel *)codeTitleLabel
{
    if (nil == _codeTitleLabel) {
        _codeTitleLabel = [WLTools allocLabel:SSKJLocalized(@"谷歌验证码", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), self.titleLabel.bottom + ScaleW(40), ScaleW(200), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
    }
    return _codeTitleLabel;
}

-(UITextField *)codeTextField
{
    if (nil == _codeTextField) {
        _codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.codeTitleLabel.x, self.codeTitleLabel.bottom + ScaleW(15), self.alertView.width - ScaleW(100), ScaleW(40))];
        _codeTextField.backgroundColor = kBgColor;
        _codeTextField.textColor = kTitleColor;
        _codeTextField.placeholder = SSKJLocalized(@"请输入谷歌验证码", nil);
//        [_codeTextField setValue:kSubTitleColor forKeyPath:@"_placeholderLabel.textColor"];
        _codeTextField.font = systemFont(ScaleW(15));
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;

    }
    return _codeTextField;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.codeTextField.bottom + ScaleW(50), ScreenWidth - ScaleW(30), ScaleW(40))];
        _confirmButton.centerX = self.alertView.width / 2;
        _confirmButton.layer.cornerRadius = ScaleW(6);
        _confirmButton.backgroundColor = [UIColor clearColor];
        [_confirmButton setTitle:SSKJLocalized(@"确认", nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemFont(ScaleW(15));
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}


-(void)confirmEvent
{
    if (!self.codeTextField.text.length) {
        [SSTool error:self.codeTextField.placeholder];
        return;
    }
    
    if (self.confirmBlock) {
        self.confirmBlock(self.codeTextField.text);
    }
    
//    [self hide];
}

- (void)copygoogle{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    self.codeTextField.text = pasteboard.string;
}

-(void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

-(void)hide
{
    [self removeFromSuperview];
}

- (void)setIsApply{
    self.codeTitleLabel.text = SSKJLanguage(@"资金密码");
    self.codeTextField.placeholder = SSKJLanguage(@"请输入资金密码");
    self.codeTextField.keyboardType = UIKeyboardTypeDefault;
    self.codeTextField.secureTextEntry = YES;
    [self.confirmButton setTitle:SSKJLanguage(@"提交") forState:UIControlStateNormal];
}

@end
