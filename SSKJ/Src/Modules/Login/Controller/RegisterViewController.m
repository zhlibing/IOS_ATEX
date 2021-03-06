//
//  RegisterViewController.m
//  SSKJ
//
//  Created by zpz on 2019/6/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "RegisterViewController.h"

#import "GoCoin_Login_BGView.h"

#import "VerifyCodeButton.h"

#import "Register_Choose_Country_View.h"

//#import "GlobalProtocolViewController.h"

#import "SSKJ_Protocol_ViewController.h"
#import "Choose_AreaCode_View.h"

@interface RegisterViewController ()


@property (nonatomic,strong) UIScrollView *scrollView;


@property (nonatomic,strong) Register_Choose_Country_View *countryView;
@property (nonatomic,strong) UILabel * titlelabel;

@property (nonatomic,strong) GoCoin_Login_BGView * accountVGView;

@property (nonatomic,strong) UIView * typeBgView;
@property (nonatomic,strong) UIButton * phoneBtn;
@property (nonatomic,strong) UIButton * emailBtn;
@property (nonatomic,strong) UIView * lineView;
@property (nonatomic,strong) UIView * linetwoView;

@property (nonatomic,strong) UIView * codeBgView;
@property (nonatomic,strong) UIImageView *codeimgV;
@property (nonatomic,strong) UITextField *codetextField;
@property (nonatomic,strong) VerifyCodeButton * codeBtn;

@property (nonatomic,strong) GoCoin_Login_BGView * pwdBgView;
@property (nonatomic,strong) GoCoin_Login_BGView * twoPwdBgView;
@property (nonatomic,strong) GoCoin_Login_BGView * yaoqingBgView;


@property (nonatomic,strong) UIButton * tongyiBtn;

@property (nonatomic,strong) UIButton * xieyiBtn;


@property (nonatomic,strong) UIButton * sureBtn;

@property (nonatomic,assign) NSInteger index;//1 手机号  2邮箱

@property (nonatomic,assign) NSInteger isSeleted;//1 选中  0未选中

@property (nonatomic,strong) Choose_AreaCode_View *areaCodeView;

@property (nonatomic,copy) NSString * mcode;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self scrollView];
    
    [self typeBgView];
    [self phoneBtn];
    [self emailBtn];
    [self lineView];
    [self linetwoView];
    
//    [self countryView];
//    [self titlelabel];
    
    [self accountVGView];
    
    [self codeBgView];
    [self codeimgV];
    [self codeBtn];
    [self codetextField];
    
    [self pwdBgView];
    
    [self twoPwdBgView];
    
    [self yaoqingBgView];
    
    [self tongyiBtn];
    
    [self xieyiBtn];
    
    [self sureBtn];
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.sureBtn.bottom + ScaleW(50));
    
    self.index = 1;
    
    self.isSeleted = 0;
    
    self.mcode = @"86";
}

#pragma mark --- 点击事件 ---
//返回
- (void)backBtClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//请求sh输入框
- (void)cleanBtnAction{
    self.accountVGView.textField.text = @"";
}

//手机号注册
- (void)phoneBtnClick{
    self.accountVGView.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.accountVGView.textField resignFirstResponder];
    [self.accountVGView.textField becomeFirstResponder];
    [self.phoneBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
    [self.emailBtn setTitleColor:kTitleColor forState:UIControlStateNormal];
    [WLTools textField:_accountVGView.textField setPlaceHolder:SSKJLocalized(@"请输入手机号", nil) color:kSubTitleColor];
    self.accountVGView.imgV.image = [UIImage imageNamed:@"shouji-icon"];
    self.lineView.hidden = NO;
    self.linetwoView.hidden = YES;
    
//    self.countryView.hidden = NO;
//    self.titlelabel.hidden = NO;
//    self.accountVGView.y = self.countryView.bottom + ScaleW(30);
//    self.codeBgView.y = self.accountVGView.bottom + ScaleW(1);
//    self.pwdBgView.y = self.codeBgView.bottom + ScaleW(10);
//    self.twoPwdBgView.y = self.pwdBgView.bottom + ScaleW(1);
//    self.yaoqingBgView.y = self.twoPwdBgView.bottom + ScaleW(1);
//    self.tongyiBtn.y = self.yaoqingBgView.bottom + ScaleW(10);
//    self.xieyiBtn.y = self.yaoqingBgView.bottom + ScaleW(10);
//    self.sureBtn.y = self.tongyiBtn.bottom + ScaleW(40);
    self.index = 1;
}
//邮箱注册
- (void)emailbBtnClick{
    self.accountVGView.textField.keyboardType = UIKeyboardTypeASCIICapable;
    [self.accountVGView.textField resignFirstResponder];
    [self.accountVGView.textField becomeFirstResponder];
    [self.emailBtn setTitleColor:kBlueColor forState:UIControlStateNormal];
    [self.phoneBtn setTitleColor:kTitleColor forState:UIControlStateNormal];
    [WLTools textField:_accountVGView.textField setPlaceHolder:SSKJLocalized(@"请输入邮箱地址", nil) color:kSubTitleColor];
    self.accountVGView.imgV.image = [UIImage imageNamed:@"youxiang-icon"];
    self.lineView.hidden = YES;
    self.linetwoView.hidden = NO;
    
//    self.countryView.hidden = YES;
//    self.titlelabel.hidden = YES;
//    self.accountVGView.y = self.typeBgView.bottom + ScaleW(20);
//    self.codeBgView.y = self.accountVGView.bottom + ScaleW(1);
//    self.pwdBgView.y = self.codeBgView.bottom + ScaleW(10);
//    self.twoPwdBgView.y = self.pwdBgView.bottom + ScaleW(1);
//    self.yaoqingBgView.y = self.twoPwdBgView.bottom + ScaleW(1);
//    self.tongyiBtn.y = self.yaoqingBgView.bottom + ScaleW(10);
//    self.xieyiBtn.y = self.yaoqingBgView.bottom + ScaleW(10);
//    self.sureBtn.y = self.tongyiBtn.bottom + ScaleW(40);
    self.index = 2;
}

// 获取验证码点击事件
- (void)codeBtnVerification:(UIButton *)sender {
    if (self.index == 1) {
        if (self.accountVGView.textField.text.length == 0) {
            [MBProgressHUD showError:SSKJLocalized(@"请输入正确的手机号或邮箱", nil)];
            return;
        }
    }
    if (self.index == 2) {
        if (![RegularExpression validateEmail:self.accountVGView.textField.text]){
            [MBProgressHUD showError:SSKJLocalized(@"请输入正确的手机号或邮箱", nil)];
            return;
        }
    }
    
    if (self.index == 1){
        [self requestSmsCode];
    }else{
        [self requestEmailCode];
    }

    
}

//明密文转换
- (void)showBtnAction{
    self.pwdBgView.rightBtn.selected = !self.pwdBgView.rightBtn.selected;
    if (self.pwdBgView.rightBtn.selected) {
        self.pwdBgView.textField.secureTextEntry = NO;
        [self.pwdBgView.rightBtn setImage:[UIImage imageNamed:@"login_show"] forState:UIControlStateNormal];
    }else{
        self.pwdBgView.textField.secureTextEntry = YES;
        [self.pwdBgView.rightBtn setImage:[UIImage imageNamed:@"login_hide"] forState:UIControlStateNormal];
    }
}
//明密文转换
- (void)twpshowBtnAction{
    self.twoPwdBgView.rightBtn.selected = !self.twoPwdBgView.rightBtn.selected;
    if (self.twoPwdBgView.rightBtn.selected) {
        self.twoPwdBgView.textField.secureTextEntry = NO;
        [self.twoPwdBgView.rightBtn setImage:[UIImage imageNamed:@"login_show"] forState:UIControlStateNormal];
    }else{
        self.twoPwdBgView.textField.secureTextEntry = YES;
        [self.twoPwdBgView.rightBtn setImage:[UIImage imageNamed:@"login_hide"] forState:UIControlStateNormal];
    }
}
//用户注册协议
- (void)xieyiBtnAcion{
    SSKJ_Protocol_ViewController *protocolVC = [[SSKJ_Protocol_ViewController alloc] init];
    protocolVC.type = @"6";
    [self.navigationController pushViewController:protocolVC animated:YES];
}
//同意按钮点击事件
- (void)tongyiBtnAction
{
    if (self.isSeleted == 1) {
        [self.tongyiBtn setImage:[UIImage imageNamed:@"login_weixuanze"] forState:UIControlStateNormal];
        self.isSeleted = 0;
    }else{
        [self.tongyiBtn setImage:[UIImage imageNamed:@"login_xuanze"] forState:UIControlStateNormal];
        self.isSeleted = 1;
    }
}
//注册请求
- (void)nextBtnAction{
    if (self.index == 1) {
        if (self.accountVGView.textField.text.length == 0) {
            [MBProgressHUD showError:SSKJLocalized(@"请输入正确的手机号或邮箱", nil)];
            return;
        }
    }
    if (self.index == 2) {
        if (![RegularExpression validateEmail:self.accountVGView.textField.text]){
            [MBProgressHUD showError:SSKJLocalized(@"请输入正确的手机号或邮箱", nil)];
            return;
        }
    }
    if (self.codetextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入验证码", nil)];
        return;
    }
    if (![RegularExpression validatePassword:self.pwdBgView.textField.text]) {
        [MBProgressHUD showError:SSKJLocalized(@"密码提示", nil)];
        
        return;
    }
    if (![self.pwdBgView.textField.text isEqualToString:self.twoPwdBgView.textField.text]) {
        [MBProgressHUD showError:SSKJLocalized(@"两次密码输入不一致", nil)];
        return;
    }
    if (self.yaoqingBgView.textField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入邀请码", nil)];
        return;
    }
    
    [self requestRegisterUrl];
}

#pragma mark --- 网络请求 ---
// 获取手机验证码
-(void)requestSmsCode{

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = self.accountVGView.textField.text;
    params[@"from"] = @"register";
    params[@"type"] = @"1";

//    params[@"mcode"] = self.mcode;
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_GetSmsCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == SUCCESSED)                    {
            //                    weakSelf.login_dic = json;
            [weakSelf.view endEditing:YES];
            
            [weakSelf.codeBtn timeFailBeginFrom:61];
            
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
- (void)requestEmailCode{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"email"] = self.accountVGView.textField.text;
    params[@"from"] = @"register";
//    params[@"type"] = @"1";

    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_GetEmailCode_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == SUCCESSED)                    {
            //                    weakSelf.login_dic = json;
            [weakSelf.view endEditing:YES];
            [weakSelf.codeBtn timeFailBeginFrom:61];
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
//注册请求
- (void)requestRegisterUrl
{
    NSString *account;
    if (self.index == 1)
    {
        //手机
        account = @"phone";
    }
    else
    {
        //邮箱
        account = @"email";
    }
    
    if (self.isSeleted == 0)
    {
        [MBProgressHUD showError:@"请阅读并同意协议"];
        return;
    }
    
    
    
    NSDictionary *params = @{@"area_code":@"+86",
                            account:self.accountVGView.textField.text,
                            @"code":self.codetextField.text,
                            @"recommend":self.yaoqingBgView.textField.text,
                            @"password":self.pwdBgView.textField.text,
                            @"password_confirmation":
                                 self.twoPwdBgView.textField.text,
                            };
    
    
    
    NSLog(@"%@\n%@",self.pwdBgView.textField.text,self.twoPwdBgView.textField.text);
    NSLog(@"%@",params);
    
    
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_Register_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {

        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];

        if (netModel.status.integerValue == SUCCESSED)
        {
            if (weakSelf.registerSuccessBlock) {
                weakSelf.registerSuccessBlock(weakSelf.accountVGView.textField.text);
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
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

#pragma mark --- 创建UI ---


- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, ScreenHeight - Height_NavBar)];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIView *)typeBgView{
    if (_typeBgView == nil) {
        _typeBgView = [FactoryUI createViewWithFrame:CGRectMake(ScaleW(15), ScaleW(30), ScreenWidth - ScaleW(30), ScaleW(50)) Color:kSubBgColor];
        _typeBgView.backgroundColor = kSubBgColor;
        _typeBgView.layer.cornerRadius = ScaleW(4);
        _typeBgView.layer.masksToBounds = YES;
        [self.scrollView addSubview:_typeBgView];
    }
    return _typeBgView;
}

-  (UIButton *)phoneBtn{
    if (_phoneBtn == nil) {
        _phoneBtn = [FactoryUI createButtonWithFrame:CGRectZero title:SSKJLocalized(@"手机号注册", nil) titleColor:kBlueColor imageName:nil backgroundImageName:nil target:self selector:@selector(phoneBtnClick) font:systemFont(ScaleW(15))];
        [self.typeBgView addSubview:_phoneBtn];
        [_phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(@(0));
            make.width.equalTo(@(ScreenWidth / 2 - ScaleW(30)));
        }];
    }
    return _phoneBtn;
}

-  (UIButton *)emailBtn{
    if (_emailBtn == nil) {
        _emailBtn = [FactoryUI createButtonWithFrame:CGRectZero title:SSKJLocalized(@"邮箱注册", nil) titleColor:kTitleColor imageName:nil backgroundImageName:nil target:self selector:@selector(emailbBtnClick) font:systemFont(ScaleW(15))];
        [self.typeBgView addSubview:_emailBtn];
        [_emailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(@(0));
            make.width.equalTo(@(ScreenWidth / 2 - ScaleW(30)));
        }];
    }
    return _emailBtn;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [FactoryUI createViewWithFrame:CGRectMake(0, ScaleW(48), ScaleW(50), ScaleW(2)) Color:kBlueColor];
        [self.typeBgView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@0);
            make.centerX.equalTo(self.phoneBtn.mas_centerX);
            make.height.equalTo(@(ScaleW(3)));
            make.width.equalTo(@(ScaleW(50)));
        }];
    }
    return _lineView;
}

- (UIView *)linetwoView{
    if (_linetwoView == nil) {
        _linetwoView = [FactoryUI createViewWithFrame:CGRectMake(0, ScaleW(48), ScaleW(50), ScaleW(2)) Color:kBlueColor];
        _linetwoView.hidden = YES;
        [self.typeBgView addSubview:_linetwoView];
        [_linetwoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@0);
            make.centerX.equalTo(self.emailBtn.mas_centerX);
            make.height.equalTo(@(ScaleW(3)));
            make.width.equalTo(@(ScaleW(50)));
        }];
    }
    return _linetwoView;
}

- (Register_Choose_Country_View *)countryView{
    if (_countryView == nil) {
        _countryView = [[Register_Choose_Country_View alloc]initWithFrame:CGRectMake(ScaleW(15), self.typeBgView.bottom + ScaleW(10), ScreenWidth - ScaleW(30), ScaleW(50))];
        WS(weakSelf);
        _countryView.ChooseCountryBlock = ^{
            [weakSelf.areaCodeView showAlertView];
        };
        [self.scrollView addSubview:_countryView];
    }
    return _countryView;
}

- (UILabel *)titlelabel{
    if (_titlelabel == nil) {
        _titlelabel = [FactoryUI createLabelWithFrame:CGRectMake(ScaleW(15), self.countryView.bottom, ScreenWidth - ScaleW(30), ScaleW(30)) text:SSKJLocalized(@"*国家信息注册后不可修改，请务必如实选择", nil) textColor:kSubTitleColor font:systemFont(ScaleW(12))];
        _titlelabel.adjustsFontSizeToFitWidth = YES;
        [self.scrollView addSubview:_titlelabel];
    }
    return _titlelabel;
}

- (GoCoin_Login_BGView *)accountVGView{
    if (_accountVGView == nil) {
//        _accountVGView = [[GoCoin_Login_BGView alloc]initWithFrame:CGRectMake(ScaleW(15), self.typeBgView.bottom + ScaleW(10), ScreenWidth - ScaleW(30), ScaleW(50))];
        _accountVGView = [[GoCoin_Login_BGView alloc]initWithFrame:CGRectMake(ScaleW(15),self.typeBgView.bottom + ScaleW(20), ScreenWidth - ScaleW(30), ScaleW(50))];

        _accountVGView.imgV.image = [UIImage imageNamed:@"shouji-icon"];
        [_accountVGView.rightBtn setImage:[UIImage imageNamed:@"Login_shanchu"] forState:UIControlStateNormal];
        [_accountVGView.rightBtn addTarget:self action:@selector(cleanBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [WLTools textField:_accountVGView.textField setPlaceHolder:SSKJLocalized(@"请输入手机号", nil) color:kSubTitleColor];
        _accountVGView.textField.keyboardType = UIKeyboardTypeNumberPad;
        [self.scrollView addSubview:_accountVGView];
    }
    return _accountVGView;
}

- (UIView *)codeBgView{
    if (_codeBgView == nil) {
        _codeBgView = [FactoryUI createViewWithFrame:CGRectMake(ScaleW(15), self.accountVGView.bottom + ScaleW(1), ScreenWidth - ScaleW(30), ScaleW(50)) Color:kSubBgColor];
        _codeBgView.layer.cornerRadius = ScaleW(5);
        _codeBgView.layer.masksToBounds = YES;
        [self.scrollView addSubview:_codeBgView];
    }
    return _codeBgView;
}

- (UIImageView *)codeimgV{
    if (_codeimgV == nil) {
        _codeimgV = [FactoryUI createImageViewWithFrame:CGRectZero imageName:@"yanzhengma"];
        [self.codeBgView addSubview:_codeimgV];
        [_codeimgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.codeBgView.mas_centerY);
            make.left.equalTo(@(ScaleW(20)));
            make.height.equalTo(@(ScaleW(20)));
            make.width.equalTo(@(ScaleW(20)));
        }];
    }
    return _codeimgV;
}

- (UITextField *)codetextField{
    if (_codetextField == nil) {
        _codetextField = [FactoryUI createTextFieldWithFrame:CGRectZero text:@"" placeHolder:SSKJLocalized(@"请输入账号", nil)];
        [WLTools textField:_codetextField setPlaceHolder:SSKJLocalized(@"请输入验证码", nil) color:kSubTitleColor];
        _codetextField.font = systemFont(ScaleW(14));
        _codetextField.textColor = kTitleColor;
        _codetextField.keyboardType = UIKeyboardTypeNumberPad;
        [self.codeBgView addSubview:_codetextField];
        [_codetextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@(0));
            make.left.equalTo(self.codeimgV.mas_right).offset(ScaleW(20));
            make.right.equalTo(self.codeBtn.mas_left);
        }];
    }
    return _codetextField;
}


- (VerifyCodeButton *)codeBtn{
    if (_codeBtn == nil) {
        _codeBtn = [VerifyCodeButton buttonWithType:UIButtonTypeCustom];
        _codeBtn.backgroundColor = kBlueColor;
        [_codeBtn setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        [_codeBtn setTitleColor:kTitleColor forState:UIControlStateNormal];
        _codeBtn.cornerRadius = ScaleW(30)/2;
        [_codeBtn addTarget:self action:@selector(codeBtnVerification:) forControlEvents:UIControlEventTouchUpInside];
        [self.codeBgView addSubview:_codeBtn];
        [_codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(ScaleW(10)));
            make.bottom.equalTo(@(ScaleW(-10)));
            make.right.equalTo(@(-10));
            make.width.equalTo(@(ScaleW(90)));
        }];
    }
    return _codeBtn;
}

- (GoCoin_Login_BGView *)pwdBgView{
    if (_pwdBgView == nil) {
        _pwdBgView = [[GoCoin_Login_BGView alloc]initWithFrame:CGRectMake(ScaleW(15), self.codeBgView.bottom + ScaleW(10), ScreenWidth - ScaleW(30), ScaleW(50))];
        _pwdBgView.imgV.image = [UIImage imageNamed:@"login_pwd"];
        [_pwdBgView.rightBtn setImage:[UIImage imageNamed:@"login_hide"] forState:UIControlStateNormal];
        [_pwdBgView.rightBtn addTarget:self action:@selector(showBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _pwdBgView.textField.secureTextEntry = YES;
        _pwdBgView.textField.keyboardType = UIKeyboardTypeASCIICapable;
        [WLTools textField:_pwdBgView.textField setPlaceHolder:SSKJLocalized(@"请输入8-20位字母与数字组合", nil) color:kSubTitleColor];
        [self.scrollView addSubview:_pwdBgView];
    }
    return _pwdBgView;
}

- (GoCoin_Login_BGView *)twoPwdBgView{
    if (_twoPwdBgView == nil) {
        _twoPwdBgView = [[GoCoin_Login_BGView alloc]initWithFrame:CGRectMake(ScaleW(15), self.pwdBgView.bottom + ScaleW(1), ScreenWidth - ScaleW(30), ScaleW(50))];
        _twoPwdBgView.imgV.image = [UIImage imageNamed:@"login_pwd"];
        [_twoPwdBgView.rightBtn setImage:[UIImage imageNamed:@"login_hide"] forState:UIControlStateNormal];
        [_twoPwdBgView.rightBtn addTarget:self action:@selector(twpshowBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _twoPwdBgView.textField.secureTextEntry = YES;
        _twoPwdBgView.textField.keyboardType = UIKeyboardTypeASCIICapable;
        [WLTools textField:_twoPwdBgView.textField setPlaceHolder:SSKJLocalized(@"请输入确认密码", nil) color:kSubTitleColor];
        [self.scrollView addSubview:_twoPwdBgView];
    }
    return _twoPwdBgView;
}

- (GoCoin_Login_BGView *)yaoqingBgView{
    if (_yaoqingBgView == nil) {
        _yaoqingBgView = [[GoCoin_Login_BGView alloc]initWithFrame:CGRectMake(ScaleW(15), self.twoPwdBgView.bottom + ScaleW(1), ScreenWidth - ScaleW(30), ScaleW(50))];
        _yaoqingBgView.imgV.image = [UIImage imageNamed:@"login_yq"];
        _yaoqingBgView.textField.secureTextEntry = NO;
        _yaoqingBgView.textField.keyboardType = UIKeyboardTypeNumberPad;
        [WLTools textField:_yaoqingBgView.textField setPlaceHolder:SSKJLocalized(@"请输入邀请码", nil) color:kSubTitleColor];
        [self.scrollView addSubview:_yaoqingBgView];
    }
    return _yaoqingBgView;
}

- (UIButton *)tongyiBtn
{
    if (_tongyiBtn == nil) {
        
        _tongyiBtn = [FactoryUI createButtonWithFrame:CGRectMake(ScaleW(35), self.yaoqingBgView.bottom + ScaleW(10), ScaleW(90), ScaleW(20)) title:SSKJLocalized(@"已阅读并同意", nil) titleColor:kTitleColor imageName:@"login_weixuanze" backgroundImageName:nil target:self selector:@selector(tongyiBtnAction) font:systemFont(ScaleW(12))];
        
        [self.scrollView addSubview:_tongyiBtn];
        [_tongyiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(self.yaoqingBgView.bottom + ScaleW(10)));
            make.left.equalTo(@(ScaleW(33)));
            make.height.equalTo(@(ScaleW(20)));
        }];
    }
    return _tongyiBtn;
}

- (UIButton *)xieyiBtn{
    if (_xieyiBtn == nil) {
        _xieyiBtn = [FactoryUI createButtonWithFrame:CGRectMake(self.tongyiBtn.maxX, self.tongyiBtn.y, ScaleW(100), ScaleW(20)) title:SSKJLocalized(@"用户注册协议", nil) titleColor:kBlueColor imageName:@"" backgroundImageName:nil target:self selector:@selector(xieyiBtnAcion) font:systemFont(ScaleW(12))];
        [self.scrollView addSubview:_xieyiBtn];
        [_xieyiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(self.yaoqingBgView.bottom + ScaleW(10)));
            make.left.equalTo(self.tongyiBtn.mas_right).offset(ScaleW(5));
            make.height.equalTo(@(ScaleW(20)));
        }];
    }
    return _xieyiBtn;
}


- (UIButton *)sureBtn{
    if (_sureBtn == nil) {
        _sureBtn = [FactoryUI createButtonWithFrame:CGRectMake(ScaleW(15), self.yaoqingBgView.bottom + ScaleW(70), ScreenWidth - ScaleW(30), ScaleW(50)) title:SSKJLocalized(@"注册", nil) titleColor:kTitleColor imageName:nil backgroundImageName:nil target:self selector:@selector(nextBtnAction) font:systemFont(ScaleW(16))];
        _sureBtn.backgroundColor = kBlueColor;
        _sureBtn.layer.cornerRadius = ScaleW(5);
        
        [self.scrollView addSubview:_sureBtn];
    }
    return _sureBtn;
}


- (Choose_AreaCode_View *)areaCodeView{
    if (_areaCodeView == nil) {
        _areaCodeView = [[Choose_AreaCode_View alloc]initWithFrame:self.view.bounds];
        WS(weakSelf);
        _areaCodeView.SeletedAreaCodeBlock = ^(NSString * _Nonnull logo, NSString * _Nonnull name, NSString * _Nonnull code) {
            weakSelf.countryView.areaLabel.text = [NSString stringWithFormat:@"+%@",code];
            [weakSelf.countryView.countryBtn setTitle:name forState:UIControlStateNormal];
            weakSelf.mcode = code;
        };
    }
    return _areaCodeView;
}
@end
