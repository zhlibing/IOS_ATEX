//
//  My_SetTPWD_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/1.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_SetTPWD_ViewController.h"
#import "My_TitleAndInput_View.h"
#import "BIAuthCodeHelper.h"
#import "My_InputView.h"




@interface My_SetTPWD_ViewController ()

@property (nonatomic, strong) SSKJ_TextFieldView *pwdView;
@property (nonatomic, strong) SSKJ_TextFieldView *surePwdView;
@property (nonatomic, strong) My_InputView *phoneView;

@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UIView *codeBackView;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UIButton *smsCodeButton;
@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation My_SetTPWD_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.isEdit) {
        self.title = SSKJLocalized(@"修改资金密码", nil);
    } else {
        self.title = SSKJLocalized(@"设置资金密码", nil);
    }
    
    [self.view addSubview:[self getLineView]];
    [self pwdView];
    [self surePwdView];
    [self.view addSubview:self.phoneLabel];
    [self.view addSubview:self.codeBackView];
    [self.codeBackView addSubview:self.codeTextField];
    [self.codeBackView addSubview:self.smsCodeButton];
    [self.view addSubview:self.submitButton];
    
   
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark 根据邮箱或者手机号设置相应的数据
-(void)setPhoneNumber:(NSString *)phoneNumber
{
    _phoneNumber = phoneNumber;
    
    NSString *string = @"";
    if ([RegularExpression validateEmail:self.phoneNumber])
    {
        
        string = [NSString stringWithFormat:@"%@：%@",SSKJLocalized(@"邮箱地址", nil),self.phoneNumber];
        self.codeTextField.placeholder = SSKJLocalized(@"请输入邮箱验证码", nil);

    }
    else
    {
        NSString *phoneNumber = [self.phoneNumber stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        
        string = [NSString stringWithFormat:@"%@：%@",SSKJLocalized(@"手机号", nil),phoneNumber];\
        
        self.codeTextField.placeholder = SSKJLocalized(@"请输入短信验证码", nil);
    }
    
    [self.phoneLabel setText:string];
    
}



#pragma mark - Getter / Setter
- (SSKJ_TextFieldView *)pwdView
{
    if (nil == _pwdView)
    {
        _pwdView = [[SSKJ_TextFieldView alloc] initWithTitle:SSKJLanguage(@"资金密码") placeholder:SSKJLanguage(@"请输入8-20位字母+数字资金密码") rightBtn:YES];
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

        _surePwdView = [[SSKJ_TextFieldView alloc] initWithTitle:SSKJLanguage(@"确认资金密码") placeholder:SSKJLanguage(@"请再次输入资金密码") rightBtn:YES];
        [self.view addSubview:_surePwdView];
        
        [_surePwdView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.pwdView.mas_bottom).offset(ScaleW(20));
            make.left.right.height.equalTo(self.pwdView);
        }];
        
    }
    return _surePwdView;
}
- (My_InputView *)phoneView
{
    if (nil == _phoneView)
    {
        //        _surePwdView = [[My_InputView alloc]initWithFrame:CGRectMake(0, self.pwdView.bottom, ScreenWidth, ScaleW(50)) title:nil placeHolder:SSKJLocalized(@"确认资金密码", nil) keyBoardType:UIKeyboardTypeDefault];
        //        _surePwdView.textField.secureTextEntry = YES;
        _phoneView = [[My_InputView alloc]initWithFrame:CGRectMake(0, Height_NavBar + ScaleW(190), ScreenWidth, ScaleW(50)) placeHolder:SSKJLocalized(@"手机号", nil) keyboardType:UIKeyboardTypeDefault isSecured:YES];
        NSString *str = kAccount;
        
        NSMutableString* str1 = [[NSMutableString alloc]initWithString:str];
        
        NSString *mobileStr;
        

            mobileStr = [str1 stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];

        _phoneView.textField.text=[NSString stringWithFormat:@"手机号:%@",mobileStr];
        
        
        _phoneView.textField.enabled=NO;
        
        [_phoneView.textField setSecureTextEntry:NO];
        
        _phoneView.secretButton.selected=YES;
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), _phoneView.height-0.5, ScreenWidth-ScaleW(30), 0.5)];
        line.backgroundColor=kLineColor;
        [_phoneView addSubview:line];
        
    }
    return _phoneView;
}
-(UILabel *)phoneLabel
{
    if (!_phoneLabel)
    {
        _phoneLabel = [FactoryUI createLabelWithFrame:CGRectMake(ScaleW(15), Height_NavBar + ScaleW(210), ScreenWidth - ScaleW(30), ScaleW(16)) text:@"" textColor:kTitleColor font:systemFont(ScaleW(18))];
    }
    return _phoneLabel;
}


-(UIView *)codeBackView
{
    if (nil == _codeBackView) {
        _codeBackView = [[UIView alloc]initWithFrame:CGRectMake(0, self.phoneView.bottom, ScreenWidth, ScaleW(60))];
        _codeBackView.backgroundColor = kBgColor;
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), _codeBackView.height-0.5, ScreenWidth-ScaleW(30), 0.5)];
        line.backgroundColor=kLineColor;
        [_codeBackView addSubview:line];
        
        UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScreenWidth-ScaleW(30), 0.5)];
        line1.backgroundColor=kLineColor;
        [_codeBackView addSubview:line1];
        
    }
    return _codeBackView;
}

-(UITextField *)codeTextField
{
    if (nil == _codeTextField) {
        _codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScaleW(200), ScaleW(60))];
        _codeTextField.textColor = kTitleColor;
        _codeTextField.placeholder = SSKJLocalized(@"请输入短信验证码", nil);
//        [_codeTextField setValue:kSubTitleColor forKeyPath:@"_placeholderLabel.textColor"];
        _codeTextField.font = systemFont(ScaleW(14));
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _codeTextField;
}


-(UIButton *)smsCodeButton
{
    if (nil == _smsCodeButton) {
        _smsCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(12) - ScaleW(100), 0, ScaleW(100), ScaleW(32))];
        _smsCodeButton.centerY = self.codeTextField.centerY;
        [_smsCodeButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        _smsCodeButton.backgroundColor=kBlueColor;
        
        [_smsCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _smsCodeButton.titleLabel.font = systemFont(ScaleW(13));
        _smsCodeButton.layer.masksToBounds = YES;
        _smsCodeButton.layer.cornerRadius = ScaleW(5);
//        _smsCodeButton.layer.borderColor = kBlueColor.CGColor;
//        _smsCodeButton.layer.borderWidth = 1;
        [_smsCodeButton addTarget:self action:@selector(codeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _smsCodeButton;
}

-(UIButton *)submitButton
{
    if (nil == _submitButton) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(12), self.codeBackView.bottom +ScaleW(50) , ScreenWidth - ScaleW(24), ScaleW(44))];
        _submitButton.layer.cornerRadius = ScaleW(5);
        _submitButton.backgroundColor = kBlueColor;
        [_submitButton setTitle:SSKJLocalized(@"提交",nil) forState:UIControlStateNormal];
        [_submitButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemFont(ScaleW(16));
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}




#pragma mark - Private Method
#pragma mark 获取验证码

- (void)codeBtnAction{
    
    [self.view endEditing:YES];
    [[WYVerifyTool sharedInstance] startVerifyCompletion:^(BOOL result, NSString * _Nullable validate, NSString * _Nonnull message) {
        if (result) {
            [self getSmsCodeEvent:validate];
        }
    }];
    
}

-(void)getSmsCodeEvent:(NSString *)sender
{
    
    NSDictionary *params = @{
                                @"account":self.phoneNumber,
                                @"codeType":@"4",
                                @"areaCode":[SSTool myAreaCode],
                                @"sliderCode":sender
                                };
       //[NSString stringWithFormat:@"%@%@",ProductBaseServer,@"/app/user/checkSlide"]
       MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_GetCode_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
        {
            [hud hideAnimated:YES];
            WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];

            if (network_Model.status.integerValue == SUCCESSED)
            {
                [SSTool success:network_Model.msg];

                [self changeCheckcodeButtonState];
            }else{
                [SSTool error:network_Model.msg];
            }


        } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
        {
            [hud hideAnimated:YES];
            [SSTool error:SSKJLanguage(@"网络异常")];
        }];

   
}

#pragma mark 时间倒计时
- (void)changeCheckcodeButtonState
{
    __block int timeout= 59; //倒计时时间
    WS(weakSelf);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.smsCodeButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
                weakSelf.smsCodeButton.enabled = YES;
                
            });
            
        }else{
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%ds", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.smsCodeButton setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateDisabled];
                weakSelf.smsCodeButton.enabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}


#pragma mark 提交设置交易密码
-(void)submitEvent
{
    if (self.pwdView.valueString.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入资金密码",nil)];
        return;
    }
    
    if (self.surePwdView.valueString.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请再次输入资金密码",nil)];
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

    if (self.codeTextField.text.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入验证码", nil)];
        return;
    }

    if (self.codeTextField.text.length != 6) {
        [MBProgressHUD showError:SSKJLocalized(@"验证码错误", nil)];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:kUserID forKey:@"id"];
    [params setObject:[WLTools md5:self.pwdView.valueString] forKey:@"dealPswd"];
    [params setObject:self.codeTextField.text forKey:@"code"];
    [params setObject:kAccount forKey:@"account"];
    
    WS(weakSelf);
    [MBHUD showHUDAddedTo:self.view];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_UpdateTradePswd_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         [MBHUD hideHUDForView:weakSelf.view];

         if (net_model.status.integerValue == SUCCESSED)
         {
             [SSKJ_User_Tool sharedUserTool].userInfoModel.tradePswdStatus = @"1";
             if (weakSelf.statusBlock) {
                 weakSelf.statusBlock();
             }
             [weakSelf.navigationController popViewControllerAnimated:YES];
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
