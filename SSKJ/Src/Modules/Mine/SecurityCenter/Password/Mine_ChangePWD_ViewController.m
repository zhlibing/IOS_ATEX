//
//  My_ChangePWD_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "Mine_ChangePWD_ViewController.h"
#import "Mine_TitleAndInput_View.h"
#import "BIAuthCodeHelper.h"
#import "Mine_BindGoogle_AlertView.h"


@interface Mine_ChangePWD_ViewController ()

@property (nonatomic, strong) SSKJ_TextFieldView *pwdView;
@property (nonatomic, strong) SSKJ_TextFieldView *surePwdView;
@property (nonatomic, strong) SSKJ_TextFieldView *phoneView;
@property (nonatomic, strong) UIButton *smsCodeButton;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) Mine_BindGoogle_AlertView *googleAlertView;


@end

@implementation Mine_ChangePWD_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = SSKJLocalized(@"修改登录密码", nil);
    [self pwdView];
    [self surePwdView];
    [self phoneView];
    [self.phoneView addSubview:self.smsCodeButton];
    [self.view addSubview:self.submitButton];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}



#pragma mark - Getter / Setter
- (SSKJ_TextFieldView *)pwdView
{
    if (nil == _pwdView)
    {
        _pwdView = [[SSKJ_TextFieldView alloc] initWithTitle:SSKJLanguage(@"新登录密码") placeholder:SSKJLanguage(@"请输入8-20位字母与数字组合") rightBtn:YES];
        [self.view addSubview:_pwdView];
        [_pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(ScaleW(30) + Height_NavBar));
            make.left.right.equalTo(@0);
            make.height.equalTo(@(ScaleW(70)));
        }];
    }
    return _pwdView;
}

#pragma mark - Getter / Setter
- (SSKJ_TextFieldView *)surePwdView
{
    if (nil == _surePwdView)
    {

        _surePwdView = [[SSKJ_TextFieldView alloc] initWithTitle:SSKJLanguage(@"确认登录密码") placeholder:SSKJLanguage(@"请再次输入登录密码") rightBtn:YES];
        [self.view addSubview:_surePwdView];
        
        [_surePwdView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.pwdView.mas_bottom).offset(ScaleW(20));
            make.left.right.height.equalTo(self.pwdView);
        }];
        
    }
    return _surePwdView;
}
- (SSKJ_TextFieldView *)phoneView
{
    if (nil == _phoneView)
    {

        NSString *string = @"";
        if ([RegularExpression validateEmail:self.phoneNumber])
        {
            
            string = [NSString stringWithFormat:@"%@：%@",SSKJLocalized(@"邮箱地址", nil),[WLTools hideEmailWithEmail:self.phoneNumber]];

        }
        else
        {
            
            string = [NSString stringWithFormat:@"%@：%@",SSKJLocalized(@"手机号", nil),[WLTools hidePhoneMiddleNumberWithMobile:self.phoneNumber]];
            
        }
        _phoneView = [[SSKJ_TextFieldView alloc] initWithTitle:string placeholder:SSKJLanguage(@"请输入验证码") rightBtn:NO];
        [self.view addSubview:_phoneView];
        
        [_phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.surePwdView.mas_bottom).offset(ScaleW(20));
            make.left.right.height.equalTo(self.pwdView);
        }];
        
    }
    return _phoneView;
}



-(UIButton *)smsCodeButton
{
    if (nil == _smsCodeButton) {
        _smsCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(12) - ScaleW(100), 0, ScaleW(100), ScaleW(32))];
        _smsCodeButton.centerY = self.phoneView.field.centerY;
        [_smsCodeButton setTitle:SSKJLocalized(@"发送验证码", nil) forState:UIControlStateNormal];
        [_smsCodeButton setTitleColor:kBlueColor forState:UIControlStateNormal];
        _smsCodeButton.titleLabel.font = systemFont(ScaleW(13));
        [_smsCodeButton addTarget:self action:@selector(codeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.phoneView addSubview:_smsCodeButton];
        [_smsCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(ScaleW(-15)));
            make.centerY.equalTo(self.phoneView.field);
        }];
    }
    return _smsCodeButton;
}

-(UIButton *)submitButton
{
    if (nil == _submitButton) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(12), ScreenHeight - ScaleW(44) - ScaleW(30) , ScreenWidth - ScaleW(24), ScaleW(44))];
        _submitButton.layer.cornerRadius = ScaleW(5);
        _submitButton.backgroundColor = kBlueColor;
        [_submitButton setTitle:SSKJLocalized(@"提交",nil) forState:UIControlStateNormal];
        [_submitButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemFont(ScaleW(16));
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

-(Mine_BindGoogle_AlertView *)googleAlertView
{
    if (nil == _googleAlertView) {
        _googleAlertView = [[Mine_BindGoogle_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        [_googleAlertView setType:GOOGLETYPEBIND];
        WS(weakSelf);
        _googleAlertView.submitBlock = ^(NSString * _Nonnull googleCode, NSString * _Nonnull smsCode) {
            [weakSelf requestGoogleSafty:googleCode];
        };
    }
    return _googleAlertView;
}
//谷歌安全验证
- (void) requestGoogleSafty:(NSString *)code{
    NSDictionary *params = @{
        @"code" : code,
        @"stockUserId" : kUserID,
    };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_GoginGoogleAuthVerify_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == SUCCESSED) {
            //提交数据
            [weakSelf submitEvent];
            [weakSelf.googleAlertView hide];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
    
}

#pragma mark - Private Method
#pragma mark 获取验证码

- (void)codeBtnAction{
    
    [self.view endEditing:YES];

    if ([RegularExpression validateEmail:self.phoneNumber]) {
        [self getEmailCodeEvent];
    }else{
        [self getSmsCodeEvent];
    }
    
}

-(void)getSmsCodeEvent
{
    
    NSDictionary *params = @{
                                @"phone":kAccount,
                                @"type":@"2"
                                };
    WS(weakSelf);
       //[NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/checkSlide"]
       MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_GetSmsCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
        {
            [hud hideAnimated:YES];
            WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];

            if (network_Model.status.integerValue == SUCCESSED)
            {
                [SSTool error:network_Model.msg];

                [WLTools countDownWithButton:weakSelf.smsCodeButton];
            }else{
                [SSTool error:network_Model.msg];
            }


        } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
        {
            [hud hideAnimated:YES];
            [SSTool error:SSKJLanguage(@"网络异常")];
        }];

}


-(void)getEmailCodeEvent
{
    
    NSDictionary *params = @{
                                @"email":kAccount,
                                };
    WS(weakSelf);
       //[NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/checkSlide"]
       MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_GetEmailCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
        {
            [hud hideAnimated:YES];
            WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];

            if (network_Model.status.integerValue == SUCCESSED)
            {
                [SSTool error:network_Model.msg];

                [WLTools countDownWithButton:weakSelf.smsCodeButton];
            }else{
                [SSTool error:network_Model.msg];
            }


        } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
        {
            [hud hideAnimated:YES];
            [SSTool error:SSKJLanguage(@"网络异常")];
        }];

}


#pragma mark 提交设置登录密码

- (void) showGoogleAuth{

    [self submitEvent];
}

-(void)submitEvent
{
    if (self.pwdView.valueString.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入登录密码",nil)];
        return;
    }
    
    if (self.surePwdView.valueString.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请再次输入登录密码",nil)];
        return;
    }
    
    if (![self.pwdView.valueString isEqualToString:self.surePwdView.valueString]) {
        [MBProgressHUD showError:SSKJLocalized(@"两次密码输入不一致",nil)];
        return;
    }
    
    if (![RegularExpression validatePassword:_pwdView.valueString])
    {
        [MBProgressHUD showError:SSKJLocalized(@"密码格式错误", nil)];
        return;
    }
    if (self.phoneView.field.text.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入验证码", nil)];
        return;
    }

    if (self.phoneView.field.text.length != 6) {
        [MBProgressHUD showError:SSKJLocalized(@"验证码错误", nil)];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if ([RegularExpression validateEmail:kAccount]) {
        [params setObject:kAccount forKey:@"email"];
    }else{
        [params setObject:kAccount forKey:@"phone"];
    }
    [params setObject:self.pwdView.valueString forKey:@"password"];
    [params setObject:self.surePwdView.valueString forKey:@"password_confirmation"];
    [params setObject:self.phoneView.field.text forKey:@"code"];
    
    WS(weakSelf);
    [MBHUD showHUDAddedTo:self.view];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_ForgetPWD_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         [MBHUD hideHUDForView:weakSelf.view];
        
         if (net_model.status.integerValue == SUCCESSED)
         {
             [MBHUD showError:SSKJLanguage(@"修改成功")];
//             [SSKJ_User_Tool sharedUserTool].userInfoModel.tradePswdStatus = @"1";
//             if (weakSelf.statusBlock) {
//                 weakSelf.statusBlock();
//             }
//             [weakSelf.navigationController popViewControllerAnimated:YES];
             [SSKJ_User_Tool clearUserInfo];
             [weakSelf presentLoginController];
         }
         else
         {
             [MBHUD showError:net_model.msg];
         }
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
    {
        [MBHUD hideHUDForView:weakSelf.view];
    }];
    
}


@end
