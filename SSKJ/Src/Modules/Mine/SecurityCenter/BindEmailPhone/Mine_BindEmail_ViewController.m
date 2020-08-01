//
//  BI_BindEmail_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/7/3.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "Mine_BindEmail_ViewController.h"
#import "Mine_TitleAndInput_View.h"
#import "Mine_BindOptionView.h"
@interface Mine_BindEmail_ViewController ()
@property (nonatomic, strong) Mine_TitleAndInput_View *phoneView;

@property (nonatomic, strong) Mine_BindOptionView *codeOptionView;  //!< 验证码
@property (nonatomic, strong) Mine_BindOptionView *pwdOptionView;  //!< 资金密码框

@property (nonatomic, strong) UIButton *smsCodeButton;
@property (nonatomic, strong) UIButton *submitButton;
@end

@implementation Mine_BindEmail_ViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.view.backgroundColor = kBgColor;
    
    UIView *topGrayView = [UIView new];
    topGrayView.backgroundColor = kSubBgColor;
    topGrayView.frame = CGRectMake(0, Height_NavBar, ScreenWidth, ScaleW(10));
    [self.view addSubview:topGrayView];
    
    
    self.title = SSKJLocalized(@"绑定邮箱", nil);
    
#pragma mark 添加视图
    [self.view addSubview:self.phoneView];
    [self.view addSubview:self.codeOptionView];
    [self.view addSubview:self.pwdOptionView];
    [self.view addSubview:self.smsCodeButton];
    [self.view addSubview:self.submitButton];
    
    if (self.from == 1) {
        self.title = SSKJLocalized(@"修改邮箱", nil);
        self.pwdOptionView.frame = self.codeOptionView.frame;
        self.codeOptionView.hidden = YES;
        self.smsCodeButton.hidden = YES;
    }
}



#pragma mark - Getter / Setter
-(Mine_TitleAndInput_View *)phoneView
{
    if (nil == _phoneView) {
        
        NSString *title = SSKJLocalized(@"邮箱地址", nil);
        NSString *placeHolder = SSKJLocalized(@"请输入您的邮箱地址", nil);
        UIKeyboardType keyBoardType = UIKeyboardTypeDefault;
        
        _phoneView = [[Mine_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, Height_NavBar + ScaleW(10), ScreenWidth, ScaleW(88)) title:title placeHolder:placeHolder keyBoardType:keyBoardType isSecure:NO];
        
    }
    return _phoneView;
    
}

-(Mine_BindOptionView *)codeOptionView
{
    if (!_codeOptionView)
    {
        _codeOptionView = [[Mine_BindOptionView alloc]initWithFrame:CGRectMake(0, self.phoneView.bottom, self.phoneView.width, ScaleW(55)) placeHolder:SSKJLocalized(@"请输入验证码",nil) keyBoardType:UIKeyboardTypeNumberPad setSecureTextEntry:NO];
        [_codeOptionView setBackgroundColor:kBgColor];
    }
    return _codeOptionView;
}

-(Mine_BindOptionView *)pwdOptionView
{
    if (!_pwdOptionView)
    {
        _pwdOptionView = [[Mine_BindOptionView alloc]initWithFrame:CGRectMake(0, self.codeOptionView.bottom, self.codeOptionView.width,self.codeOptionView.height) placeHolder:SSKJLocalized(@"请输入资金密码",nil) keyBoardType:UIKeyboardTypeDefault setSecureTextEntry:YES];
        [_pwdOptionView setBackgroundColor:kBgColor];
    }
    return _pwdOptionView;
}




-(UIButton *)smsCodeButton
{
    if (nil == _smsCodeButton) {
        _smsCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(12) - ScaleW(100), 0, ScaleW(100), ScaleW(30))];
        _smsCodeButton.centerY = self.codeOptionView.centerY;
        [_smsCodeButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        [_smsCodeButton setTitleColor:kBgColor forState:UIControlStateNormal];
        _smsCodeButton.titleLabel.font = systemFont(ScaleW(12.5));
        _smsCodeButton.layer.masksToBounds = YES;
        _smsCodeButton.layer.cornerRadius = _smsCodeButton.height / 2;
        _smsCodeButton.layer.borderColor = kBlueColor.CGColor;
        _smsCodeButton.layer.borderWidth = 1;
        _smsCodeButton.backgroundColor = kBlueColor;
        [_smsCodeButton addTarget:self action:@selector(getSmsCodeEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _smsCodeButton;
}

-(UIButton *)submitButton
{
    if (nil == _submitButton) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(12), self.view.bottom - ScaleW(290) - Height_NavBar, ScreenWidth - ScaleW(24), ScaleW(45))];
        _submitButton.layer.cornerRadius = _submitButton.height / 2;
        _submitButton.backgroundColor = kBlueColor;
        [_submitButton setTitle:SSKJLocalized(@"提交", nil)  forState:UIControlStateNormal];
        [_submitButton setTitleColor:kBgColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemFont(ScaleW(16));
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}




#pragma mark - Private Method
#pragma mark  获取验证码
-(void)getSmsCodeEvent:(UIButton*)sender
{

        NSString *email = self.phoneView.valueString;
        if (email == 0)
        {
            [MBProgressHUD showError:SSKJLocalized(@"请输入邮箱地址", nil)];
            return;
        }
        if (![RegularExpression validateEmail:email])
        {
            [MBProgressHUD showError:SSKJLocalized(@"邮箱格式错误", nil)];
            return;
        }
    
        [self getEmailCode:email];

    
}


#pragma mark 提交按钮响应事件
-(void)submitEvent
{
 
    NSString *email = self.phoneView.valueString;
    NSString *code = self.codeOptionView.valueText;
    NSString *pwd = self.pwdOptionView.valueText;
    if (email.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入邮箱地址", nil)];
        return;
    }
    
    if (![RegularExpression validateEmail:email]) {
        [MBProgressHUD showError:SSKJLocalized(@"邮箱格式错误", nil)];
        return;
    }
    if (self.from != 1) {
        if (code.length == 0)
        {
            [MBProgressHUD showError:SSKJLocalized(@"请输入邮箱验证码", nil)];
            return;
        }
    }

    if (pwd.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入资金密码", nil)];
        return;
    }
    
    [self bindEmail:email withCode:code withPwd:pwd];

}

// 倒计时
- (void)changeCheckcodeButtonState:(BOOL)state
{
    __block int timeout= 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.smsCodeButton setTitle:SSKJLocalized(@"重新发送", nil) forState:UIControlStateNormal];
                self.smsCodeButton.enabled = YES;
                
            });
            
        }else{
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:SSKJLocalized(@"%lds", nil), seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.smsCodeButton setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateDisabled];
                self.smsCodeButton.enabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}

#pragma mark - 网络请求
#pragma mark  请求手机验证码
-(void)getSMCode:(NSString*)phone
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:phone forKey:@"account"];
    [params setObject:@"3" forKey:@"codeType"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_GetSmsCode_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         if (net_model.status.integerValue == SUCCESSED)
         {
             [MBHUD showSuccess:SSKJLocalized(@"发送成功",nil)];
             [weakSelf changeCheckcodeButtonState:YES];
         }
         else
         {
             [MBHUD showError:net_model.msg];
         }
         
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         
     }];
}

#pragma mark  获取邮箱验证码
- (void)getEmailCode:(NSString*)email
{
    
    NSDictionary *params = @{
                             @"account":email,
                             @"codeType":@"3"
                             };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_GetEmailCode_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         
         if (net_model.status.integerValue == SUCCESSED)
         {
             [MBHUD showSuccess:SSKJLocalized(@"发送成功",nil)];
             [weakSelf changeCheckcodeButtonState:YES];
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


#pragma mark 绑定邮箱请求
- (void)bindEmail:(NSString*)email withCode:(NSString*)code withPwd:(NSString*)pwd
{
    
    WS(weakSelf);
    [MBHUD showHUDAddedTo:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *url;
    if (self.from != 1) {
        url = BI_BindTelOrEmail_URL;
        [params setObject:kUserID forKey:@"id"];
        [params setObject:email forKey:@"account"];
        [params setObject:code forKey:@"code"];
        [params setObject:[WLTools md5:pwd] forKey:@"dealPswd"];
    } else {
        url = BI_UpdataTelOrEmail_URL;
        [params setObject:kUserID forKey:@"id"];
        [params setObject:email forKey:@"account"];
        [params setObject:[WLTools md5:pwd] forKey:@"tradePswd"];
    }
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:url RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBHUD hideHUDForView:self.view];
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == SUCCESSED) {
            if (weakSelf.successBlock) {
                weakSelf.successBlock(email);
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBHUD hideHUDForView:self.view];
        
    }];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
