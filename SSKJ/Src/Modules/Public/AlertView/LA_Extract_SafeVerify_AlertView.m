//
//  LA_Extract_SafeVerify_AlertView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/7/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "LA_Extract_SafeVerify_AlertView.h"
#import "JB_VTitleAndInputView.h"

@interface LA_Extract_SafeVerify_AlertView ()
@property (nonatomic, strong) UIImageView *showView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) JB_VTitleAndInputView *payPWDView;

@property (nonatomic, strong) JB_VTitleAndInputView *googleView;
@property (nonatomic, strong) UIButton *pasteButton;

@property (nonatomic, strong) JB_VTitleAndInputView *smsCodeView;
@property (nonatomic, strong) UIButton *getSmsCodeButton;

@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, assign) BOOL isGoogleOpen;
@property (nonatomic, assign) BOOL isSmsOpen;


@end
@implementation LA_Extract_SafeVerify_AlertView



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        [self addSubview:self.showView];
        [self.showView addSubview:self.titleLabel];
        [self.showView addSubview:self.cancleButton];
        [self.showView addSubview:self.lineView];
        
        [self.showView addSubview:self.payPWDView];
        
        [self.showView addSubview:self.googleView];
        [self.googleView addSubview:self.pasteButton];
        
        [self.showView addSubview:self.smsCodeView];
        [self.smsCodeView addSubview:self.getSmsCodeButton];
        
        [self.showView addSubview:self.confirmButton];
        
        // 添加通知监听见键盘弹出/退出// 键盘出现的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
        // 键盘消失的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapEvent)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}



-(UIImageView *)showView
{
    if (nil == _showView) {
        _showView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, ScaleW(190))];
        //        _showView.image = [UIImage imageNamed:@"etf_alert"];
        _showView.backgroundColor  = kSubBgColor;
        _showView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endEditEvent)];
        [_showView addGestureRecognizer:tap];
    }
    return _showView;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"安全验证",nil) font:systemBoldFont(ScaleW(18)) textColor:kBlueColor frame:CGRectMake(ScaleW(27), ScaleW(20), ScaleW(200), ScaleW(50)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}


-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(85), 0, ScaleW(85), ScaleW(50))];
        _cancleButton.centerY = self.titleLabel.centerY;
        _cancleButton.layer.masksToBounds = YES;
        //        _cancleButton.layer.cornerRadius = _cancleButton.height / 2;
        //        _cancleButton.layer.borderColor = kTextBlueColor.CGColor;
        //        _cancleButton.layer.borderWidth = 0.5;
        [_cancleButton setTitle:SSKJLocalized(@"取消", nil)  forState:UIControlStateNormal];
        [_cancleButton setTitleColor:kSubTitleColor forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = systemFont(ScaleW(15));
        [_cancleButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}


-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.titleLabel.bottom, ScreenWidth, 0.5)];
        _lineView.backgroundColor = kLightLineColor;
    }
    return _lineView;
}


-(JB_VTitleAndInputView *)payPWDView
{
    if (nil == _payPWDView) {
        _payPWDView = [[JB_VTitleAndInputView alloc]initWithFrame:CGRectMake(0,self.lineView.bottom , ScreenWidth, ScaleW(98)) leftGap:ScaleW(27) title:SSKJLocalized(@"资金密码", nil) placeHolder:SSKJLocalized(@"请输入资金密码", nil) font:systemFont(ScaleW(13)) keyBoardType:UIKeyboardTypeDefault isShowSecured:YES];
    }
    return _payPWDView;
}


-(JB_VTitleAndInputView *)googleView
{
    if (nil == _googleView) {
        _googleView = [[JB_VTitleAndInputView alloc]initWithFrame:CGRectMake(0,self.smsCodeView.bottom , ScreenWidth, ScaleW(98)) leftGap:ScaleW(27) title:SSKJLocalized(@"谷歌验证码", nil) placeHolder:SSKJLocalized(@"请输入6位谷歌验证码", nil) font:systemFont(ScaleW(13)) keyBoardType:UIKeyboardTypeNumberPad isShowSecured:NO];
    }
    return _googleView;
}

- (UIButton *)pasteButton
{
    if (nil == _pasteButton) {
        _pasteButton = [WLTools allocButton:SSKJLocalized(@"粘贴", nil) textColor:kBlueColor nom_bg:nil hei_bg:nil frame:CGRectMake(ScreenWidth - ScaleW(80), 0, ScaleW(80), self.googleView.height)];
        _pasteButton.titleLabel.font = systemFont(ScaleW(14));
        _pasteButton.centerY = self.googleView.textField.centerY;
        [_pasteButton addTarget:self action:@selector(pasteEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pasteButton;
}

-(JB_VTitleAndInputView *)smsCodeView
{
    if (nil == _smsCodeView) {
                
        NSString *title;
        if ([RegularExpression validateEmail:kAccount])
        {
            title = [NSString stringWithFormat:@"%@:%@",SSKJLocalized(@"邮箱地址", nil),[WLTools hideEmailWithEmail:kAccount]];
        }
        else
        {
            title = [NSString stringWithFormat:@"%@:%@",SSKJLocalized(@"手机号", nil),[WLTools hidePhoneMiddleNumberWithMobile:kAccount]];
        }
        
        _smsCodeView = [[JB_VTitleAndInputView alloc]initWithFrame:CGRectMake(0, self.payPWDView.bottom, ScreenWidth, ScaleW(98)) leftGap:ScaleW(27) title:title placeHolder:SSKJLocalized(@"请输入验证码", nil) font:systemFont(ScaleW(13)) keyBoardType:UIKeyboardTypeNumberPad isShowSecured:NO];
    }
    return _smsCodeView;
}



-(UIButton *)getSmsCodeButton
{
    if (nil == _getSmsCodeButton) {
        _getSmsCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(self.smsCodeView.width - ScaleW(97) - ScaleW(22), 0, ScaleW(97), ScaleW(31))];
        _getSmsCodeButton.centerY = self.smsCodeView.textField.centerY;
        _getSmsCodeButton.layer.masksToBounds = YES;
        _getSmsCodeButton.layer.cornerRadius = _getSmsCodeButton.height / 2;
        [_getSmsCodeButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        [_getSmsCodeButton setTitleColor:kBlueColor forState:UIControlStateNormal];
        _getSmsCodeButton.titleLabel.font = systemFont(ScaleW(13.5));
        [_getSmsCodeButton addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getSmsCodeButton;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(27), self.googleView.bottom + ScaleW(35), ScreenWidth - ScaleW(54), ScaleW(45))];
        [_confirmButton setTitle:SSKJLocalized(@"确认", nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kTitleColor forState:UIControlStateNormal];
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.layer.cornerRadius = ScaleW(4);
        _confirmButton.titleLabel.font = systemBoldFont(ScaleW(15));
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
        _confirmButton.backgroundColor = kBlueColor;
    }
    return _confirmButton;
}



-(void)showWithIsGoogleOpen:(BOOL)isGoogleOpen isSmsOpen:(BOOL)isSmsOpen
{
    self.isGoogleOpen = isGoogleOpen;
    self.isSmsOpen = isSmsOpen;
    
    self.googleView.hidden = !isGoogleOpen;
    self.smsCodeView.hidden = !isSmsOpen;
    
    CGFloat startY = self.payPWDView.bottom;
    if (isSmsOpen) {
        startY = self.smsCodeView.bottom;
    }
    
    if (isGoogleOpen) {
        self.googleView.y = startY;
        startY = self.googleView.bottom;
    }
    
    self.confirmButton.y = startY + ScaleW(35);
    
    self.showView.height = self.confirmButton.bottom + ScaleW(27);
    
    [self show];
}


-(void)show
{
    self.showView.y = ScreenHeight;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.showView.y = ScreenHeight - weakSelf.showView.height;
    }];
}

// 隐藏
-(void)hide
{
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.showView.y = ScreenHeight;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
    
    
    self.smsCodeView.valueString = nil;
    self.googleView.valueString = nil;
    self.payPWDView.valueString = nil;
}


-(void)confirmEvent
{
    if (self.isGoogleOpen && self.googleView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入谷歌验证码", nil)];
        return;
    }
    
    if (self.isSmsOpen && self.smsCodeView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入短信验证码", nil)];
        return;
    }
    
    if (self.confirmBlock) {
        self.confirmBlock(self.payPWDView.valueString,self.googleView.valueString, self.smsCodeView.valueString);
    }
}


-(void)endEditEvent
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

-(void)tapEvent
{
    if ([self.googleView.textField isFirstResponder] || self.smsCodeView.textField.isFirstResponder) {
        [self endEditEvent];
        return;
    }
    
    [self hide];
}

// 粘贴谷歌验证码
-(void)pasteEvent
{
    UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
    self.googleView.valueString = pasteboard.string;
}


// 获取短信验证码
-(void)getCode
{
    if ([RegularExpression validateEmail:kAccount])
    {
        [self requestEmailCode];
    }
    else
    {
        [self requestSmsCode];
    }
}


#pragma mark -键盘监听方法
- (void)keyboardWasShown:(NSNotification *)notification
{
    UIView *backView;
    
    if (self.googleView.textField.isFirstResponder) {
        backView = self.googleView;
    }else{
        backView = self.smsCodeView;
    }
    // 获取键盘的高度
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat textFieldY = ScreenHeight - (ScreenHeight - self.showView.height / 2 + backView.bottom);
    
    if (frame.size.height > textFieldY) {
        CGFloat yscale = frame.size.height - textFieldY;
        self.showView.y = ScreenHeight - self.showView.height / 2 - yscale;
    }
    
}


- (void)keyboardWillBeHiden:(NSNotification *)notification
{
    self.showView.y = self.height - self.showView.height;;
}


#pragma mark - 请求手机验证码



#pragma mark --- 网络请求 ---
// 获取手机验证码
-(void)requestSmsCode{

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = kAccount;
    params[@"type"] = @"4";

//    params[@"mcode"] = self.mcode;
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_GetSmsCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == SUCCESSED)                    {
            //                    weakSelf.login_dic = json;
            [weakSelf endEditing:YES];
            
            [WLTools countDownWithButton:weakSelf.getSmsCodeButton];
            
        }
        else
        {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
        
        [MBProgressHUD showError:SSKJLocalized(@"服务器请求异常", nil)];
        
    }];
}
//获取邮箱验证码
- (void)requestEmailCode
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"email"] = kAccount;
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_GetEmailCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == SUCCESSED)                    {
            //                    weakSelf.login_dic = json;
            [weakSelf endEditing:YES];
            [WLTools countDownWithButton:weakSelf.getSmsCodeButton];
        }
        else
        {
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
        
        [MBProgressHUD showError:SSKJLocalized(@"服务器请求异常", nil)];
        
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
