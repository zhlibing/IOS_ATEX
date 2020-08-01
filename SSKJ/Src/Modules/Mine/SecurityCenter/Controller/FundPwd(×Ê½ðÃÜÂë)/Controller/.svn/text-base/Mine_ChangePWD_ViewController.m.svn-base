//
//  My_ChangePWD_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "Mine_ChangePWD_ViewController.h"
#import "SSKJ_TextFieldView.h"

#import "LoginViewController.h"
#import "SSKJ_TabbarController.h"
#import "SSKJ_BaseNavigationController.h"
#import "AppDelegate.h"

@interface Mine_ChangePWD_ViewController ()
@property (nonatomic, strong) SSKJ_TextFieldView *oldPwdView;
@property (nonatomic, strong) SSKJ_TextFieldView *pwdView;
@property (nonatomic, strong) SSKJ_TextFieldView *surePwdView;

@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation Mine_ChangePWD_ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = SSKJLocalized(@"修改登录密码", nil);
    self.view.backgroundColor = kBgColor;
    
    [self setUI];
}

#pragma mark - UI
-(void)setUI
{
    UIView *style = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth , ScaleW(10))];
    style.backgroundColor = kSubBgColor;
    [self.view addSubview:style];
    
    [self oldPwdView];
    
    [self pwdView];
    
    [self.view addSubview:self.surePwdView];
    
    [self.view addSubview:self.submitButton];

    
    [self.surePwdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdView.mas_bottom).offset(ScaleW(20));
        make.left.right.height.equalTo(self.oldPwdView);
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.surePwdView.mas_bottom).offset(ScaleW(50));
        make.left.equalTo(@(ScaleW(15)));
        make.right.equalTo(@(ScaleW(-15)));
        make.height.equalTo(@(ScaleW(45)));
    }];
}

#pragma mark - Getter / Setter
-(SSKJ_TextFieldView *)oldPwdView
{
    if (nil == _oldPwdView) {
        _oldPwdView = [[SSKJ_TextFieldView alloc] initWithTitle:SSKJLanguage(@"原登录密码") placeholder:SSKJLanguage(@"请输入原8-20位数字+字母登录密码") rightBtn:YES];
        [self.view addSubview:_oldPwdView];
        [_oldPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(ScaleW(30) + Height_NavBar));
            make.left.right.equalTo(@0);
            make.height.equalTo(@(ScaleW(70)));
        }];
    }
    return _oldPwdView;
}

-(SSKJ_TextFieldView *)pwdView
{
    if (nil == _pwdView) {
        _pwdView = [[SSKJ_TextFieldView alloc] initWithTitle:SSKJLanguage(@"新登录密码") placeholder:SSKJLanguage(@"请输入新8-20位数字+字母登录密码") rightBtn:YES];
        [self.view addSubview:_pwdView];

        [_pwdView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.oldPwdView.mas_bottom).offset(ScaleW(20));
            make.left.right.height.equalTo(self.oldPwdView);
        }];
        
        
    }
    return _pwdView;
}

-(SSKJ_TextFieldView *)surePwdView
{
    if (nil == _surePwdView) {
        _surePwdView = [[SSKJ_TextFieldView alloc] initWithTitle:SSKJLanguage(@"确认新登录密码") placeholder:SSKJLanguage(@"确认新登录密码") rightBtn:YES];
    }
    return _surePwdView;
}


-(UIButton *)submitButton
{
    if (nil == _submitButton) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectZero];
        _submitButton.layer.cornerRadius = ScaleW(5);
        _submitButton.backgroundColor = kBlueColor;
        [_submitButton setTitle:SSKJLocalized(@"提交", nil) forState:UIControlStateNormal];
        [_submitButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemFont(ScaleW(16));
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}



#pragma mark - Private Method
#pragma mark 提交按钮触发事件（做密码验证）
-(void)submitEvent
{
    if (self.oldPwdView.valueString.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入原登录密码", nil)];
        return;
    }
    
    if (self.pwdView.valueString.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入新登录密码", nil)];
        return;
    }
    
    if (self.surePwdView.valueString.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请确认新登录密码", nil)];
        return;
    }
    
    if (![self.surePwdView.valueString isEqualToString:self.pwdView.valueString])
    {
        [MBProgressHUD showError:SSKJLocalized(@"两次输入密码不一致", nil)];
        return;
    }
    
    if (![RegularExpression validatePassword:self.pwdView.valueString]) {
        [MBProgressHUD showError:SSKJLocalized(@"密码格式错误", nil)];
        return;
    }
    
    [self resetPwd:self.oldPwdView.valueString withNewPwd:self.pwdView.valueString];
}






#pragma mark 发起重置密码网络请求
/**
 重置密码
 */
- (void)resetPwd:(NSString*)originally withNewPwd:(NSString*)newPwd
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:kUserID forKey:@"id"];
//    [params setObject:[WLTools md5:originally] forKey:@"oldPswd"];
    [params setObject:Encrypt(originally) forKey:@"oldPswd"];

//    [params setObject:[WLTools md5:newPwd] forKey:@"pswd"];
    [params setObject:Encrypt(newPwd) forKey:@"pswd"];

    
    
    
    WS(weakSelf);
    [MBHUD showHUDAddedTo:weakSelf.view];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_UpdatePswd_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
    {
        [MBHUD hideHUDForView:weakSelf.view];
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == SUCCESSED)
        {
            [MBHUD showSuccess:SSKJLocalized(@"密码修改成功,请重新登录", nil)];
            
            [weakSelf logout:YES];
        }
        else
        {
            [MBHUD showError:network_Model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBHUD hideHUDForView:weakSelf.view];
     }];
}






#pragma mark 退出登录界面
-(void)logout:(BOOL)logout
{
    if (logout)
    {
        
        [SSKJ_User_Tool clearUserInfo];
        
//        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        SSKJ_TabbarController *tabbarVc = delegate.window.rootViewController;
//        SSKJ_BaseNavigationController *navc = tabbarVc.selectedViewController;

        [self.navigationController popToRootViewControllerAnimated:NO];
        
        LoginViewController *loginVc = [[LoginViewController alloc]init];
        loginVc.isLoginOut = YES;
        [self.navigationController pushViewController:loginVc animated:YES];
        
        
        
//        [self presentLoginController];
        
    }
}


@end
