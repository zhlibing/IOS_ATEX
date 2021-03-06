//
//  Lion_Forget_SetViewController.m
//  SSKJ
//
//  Created by cy5566 on 2020/3/13.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "Lion_Forget_SetViewController.h"
#import "LoginViewController.h"
#import "Login_Google_AlertView.h"
#import "Mine_TitleAndInput_View.h"


@interface Lion_Forget_SetViewController ()
@property (nonatomic,strong) Mine_TitleAndInput_View *passView;
@property (nonatomic,strong) Mine_TitleAndInput_View *againView;
@property (nonatomic,strong) Mine_TitleAndInput_View *accountView;

@property (nonatomic, strong) UIButton *getSmsButton;

@property (nonatomic,strong) Login_Google_AlertView *googleAlertView;
@property (nonatomic,strong) UIButton *commitBtn;
@property (nonatomic,strong) UILabel *accountLabel;

@end

@implementation Lion_Forget_SetViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];;
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
}


- (void)setupUI {
//    UIButton *navBtn = [WLTools allocButton:nil textColor:nil nom_bg:nil hei_bg:nil frame:CGRectZero];
//           [navBtn setImage:[UIImage imageNamed:@"mine_fanhui"] forState:UIControlStateNormal];
//           [navBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
//           [self.view addSubview:navBtn];
//               navBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//       [navBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//           make.top.equalTo(@(ScaleW(5) + Height_StatusBar));
//           make.left.equalTo(@(ScaleW(15)));
//           //        make.right.equalTo(@(-ScaleW(15)));
//           make.height.equalTo(@(ScaleW(44)));
//           make.width.equalTo(@(ScaleW(64)));
//       }];
    
    UILabel *label1 = [WLTools allocLabel:SSKJLocalized(@"重置密码",nil) font:kFont(22) textColor:kTitleColor frame:CGRectMake(ScaleW(15), ScaleW(125), ScaleW(200), ScaleW(22)) textAlignment:NSTextAlignmentLeft];
    [self.view addSubview:label1];
    
    UILabel *label2 = [WLTools allocLabel:[NSString stringWithFormat:SSKJLocalized(@"用户%@", nil),self.account] font:kFont(14) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), label1.bottom + ScaleW(10), ScaleW(300), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    [self.view addSubview:label2];
    self.accountLabel = label2;
    
    [self passView];
    
    [self againView];
    
    [self accountView];
    
    [self getSmsButton];
    
    [self commitBtn];
    
}


- (void)backBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)forgetRequset {
    
    NSDictionary *params = nil;
    
    if ([WLTools validateEmail:self.account])
    {
        params = @{
            @"email":self.account,
            @"code":self.accountView.textField.text,
            @"password":self.passView.textField.text,
            @"password_confirmation":self.againView.textField.text,
        };
    }
    else
    {
        params = @{
            @"phone":self.account,
            @"code":self.accountView.textField.text,
            @"password":self.passView.textField.text,
            @"password_confirmation":self.againView.textField.text,

        };
    }
       
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        WS(weakSelf);
        
        [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_ForgetPWD_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
            
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            
            WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
            
            if (netModel.status.integerValue == SUCCESSED)        {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:responseObject[@"msg"]];
                    // 重新去登录一次新密码
                    [self popToLoginVc];
                });
            }
            else
            {
                [MBProgressHUD showError:responseObject[@"msg"]];
            }
        } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
            [MBProgressHUD showError:SSKJLocalized(SSKJLocalized(@"网络出错", nil), nil)];
            
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        }];
}



- (void)commitBtnAction {
    if (self.passView.textField.text.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入新登录密码", nil)];
        return;
    }
    
    if (![RegularExpression validatePassword:self.passView.textField.text])
    {
           [MBProgressHUD showError:SSKJLocalized(@"密码格式不正确", nil)];
           return;
       }
    
    if (self.againView.textField.text.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请再次输入登录密码", nil)];
        return;
    }
    
    if (![self.againView.textField.text isEqualToString:self.againView.textField.text])
    {
        [MBProgressHUD showError:SSKJLocalized(@"两次密码输入不一致", nil)];
        return;
    }
    
    if (self.accountView.textField.text.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入验证码", nil)];
        return;
    }
    
    [self forgetRequset];
}

- (void)showGoogleView{
    [self.view addSubview:self.googleAlertView];
}

-(void)popToLoginVc
{
    for (SSKJ_BaseViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[LoginViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
}

// 点击获取验证码
-(void)getCodeEvent
{
    if ([RegularExpression validateEmail:self.account])
    {
        [self requestEmailCode];
    }
    else
    {
         [self requestSmsCode];
    }
}


#pragma mark --- 网络请求 ---
// 获取手机验证码
-(void)requestSmsCode{

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = self.account;
    params[@"type"] = @"2";
    
//    params[@"mcode"] = self.mcode;
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_GetSmsCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == SUCCESSED)                    {
            //                    weakSelf.login_dic = json;
            [weakSelf.view endEditing:YES];
            
            [WLTools countDownWithButton:weakSelf.getSmsButton];
            
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
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"email"] = self.account;
//    params[@"type"] = @"1";

    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_GetEmailCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == SUCCESSED)                    {
            //                    weakSelf.login_dic = json;
            [weakSelf.view endEditing:YES];
            [WLTools countDownWithButton:weakSelf.getSmsButton];
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

#pragma mark - 谷歌验证

-(void)requestGoogleWith:(NSString *)code
{
    
    NSDictionary *prams = @{
        @"account":self.account,
        @"pswd":Encrypt(self.passView.textField.text),
        @"googleCode":code,
                            };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_ForgetPWD_URL RequestType:RequestTypePost Parameters:prams Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (net_model.status.integerValue == SUCCESSED) {
            // 保存登录数据
            [weakSelf.googleAlertView hide];
            dispatch_async(dispatch_get_main_queue(), ^{
                    // 重新去登录一次新密码
                    [self popToLoginVc];
                });
        }
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        [MBProgressHUD showError:net_model.msg];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"服务器请求异常", nil)];
        
    }];
}

- (Mine_TitleAndInput_View *)passView {
    if (_passView == nil) {
        _passView = [[Mine_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.accountLabel.bottom + ScaleW(45), ScreenWidth, ScaleW(80)) title:SSKJLocalized(@"新登录密码", nil) placeHolder:SSKJLocalized(@"请输入8-20位字母与数字组合", nil) keyBoardType:UIKeyboardTypeASCIICapable isSecure:YES];
        [self.view addSubview:_passView];

    }
    return _passView;
}

- (Mine_TitleAndInput_View *)againView {
    if (_againView == nil) {
        _againView = [[Mine_TitleAndInput_View alloc]initWithFrame:CGRectMake(ScaleW(0), self.passView.bottom + ScaleW(15), ScreenWidth, ScaleW(80)) title:SSKJLocalized(@"确认密码", nil) placeHolder:SSKJLocalized(@"请再次输入登录密码", nil) keyBoardType:UIKeyboardTypeASCIICapable isSecure:YES];
        [self.view addSubview:_againView];

    }
    return _againView;
}


- (Mine_TitleAndInput_View *)accountView {
    if (_accountView == nil) {
        
        
        NSString *title;
        if ([RegularExpression validateEmail:self.account]) {
            title = [NSString stringWithFormat:@"%@：%@",SSKJLocalized(@"邮箱", nil),[WLTools hideEmailWithEmail:self.account]];
        }else{
            title = [NSString stringWithFormat:@"%@：%@",SSKJLocalized(@"手机号", nil),[WLTools hidePhoneMiddleNumberWithMobile:self.account]];
        }
        
        _accountView = [[Mine_TitleAndInput_View alloc]initWithFrame:CGRectMake(ScaleW(0), self.againView.bottom + ScaleW(15), ScreenWidth, ScaleW(80)) title:title placeHolder:SSKJLocalized(@"请输入验证码", nil) keyBoardType:UIKeyboardTypeASCIICapable isSecure:NO];
        [self.view addSubview:_accountView];
    }
    return _accountView;
}


-(UIButton *)getSmsButton
{
    if (nil == _getSmsButton) {
        _getSmsButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(80), 0, ScaleW(80), ScaleW(40))];
        [_getSmsButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        [_getSmsButton setTitleColor:kBlueColor forState:UIControlStateNormal];
        _getSmsButton.titleLabel.font = systemFont(ScaleW(13));
        _getSmsButton.centerY = self.accountView.textField.centerY;
        [_getSmsButton addTarget:self action:@selector(getCodeEvent) forControlEvents:UIControlEventTouchUpInside];
        [self.accountView addSubview:_getSmsButton];
    }
    return _getSmsButton;
}

- (UIButton *)commitBtn{
    if (_commitBtn == nil) {
        _commitBtn = [WLTools allocButton:SSKJLanguage(@"完成") textColor:kWhiteColor nom_bg:[UIImage imageNamed:@""] hei_bg:nil frame:CGRectZero];
        _commitBtn.backgroundColor = kBlueColor;
        _commitBtn.titleLabel.font = kFont(16);
        [_commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _commitBtn.layer.masksToBounds = YES;
        _commitBtn.layer.cornerRadius = ScaleW(5);
//        _commitBtn.backgroundColor = kBlueColor;
        [self.view addSubview:_commitBtn];
        
        [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(15)));
            make.right.equalTo(@(ScaleW(-15)));
            make.top.equalTo(self.accountView.mas_bottom).offset(ScaleW(55));
            make.height.equalTo(@(ScaleW(44)));
        }];
    }
    return _commitBtn;
}

-(Login_Google_AlertView *)googleAlertView
{
    if (nil == _googleAlertView) {
        _googleAlertView = [[Login_Google_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        WS(weakSelf);
        _googleAlertView.confirmBlock = ^(NSString * _Nonnull code) {
            [weakSelf requestGoogleWith:code];
        };
    }
    return _googleAlertView;
}
@end
