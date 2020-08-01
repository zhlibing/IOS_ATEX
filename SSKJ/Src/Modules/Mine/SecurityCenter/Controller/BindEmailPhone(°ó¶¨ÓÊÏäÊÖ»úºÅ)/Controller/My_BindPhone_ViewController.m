//
//  My_BindPhone_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_BindPhone_ViewController.h"
#import "My_TitleAndInput_View.h"
#import "BIBindOptionView.h"
#import "BI_PhoneView.h"

#import "SSKJ_Default_ActionsheetView.h"


@interface My_BindPhone_ViewController ()
@property (nonatomic, strong) BIBindOptionView *phoneView;

@property (nonatomic, strong) BIBindOptionView *codeOptionView;  //!< 验证码
@property (nonatomic, strong) BIBindOptionView *pwdOptionView;  //!< 资金密码框

@property (nonatomic, strong) UIButton *smsCodeButton;
@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, copy) NSString *areaCode;

@property(nonatomic, strong)SSKJ_AreaCode_View *areaView;

@end


@implementation My_BindPhone_ViewController
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.view.backgroundColor = kBgColor;
    
    self.areaCode = @"86";

    self.title = SSKJLocalized(@"绑定手机号", nil);

    #pragma mark 添加视图
    
    UIView *topGrayView = [UIView new];
    topGrayView.backgroundColor = kSubBgColor;
    topGrayView.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(10));
    [self.view addSubview:topGrayView];
    
    
    [self areaView];

    [self.view addSubview:self.phoneView];
    [self.view addSubview:self.codeOptionView];
    [self.view addSubview:self.pwdOptionView];
    [self.view addSubview:self.smsCodeButton];
    [self.view addSubview:self.submitButton];
    
    if (self.from == 1) {
        self.title = SSKJLocalized(@"修改手机号", nil);
        self.pwdOptionView.frame = self.codeOptionView.frame;
        self.codeOptionView.hidden = YES;
        self.smsCodeButton.hidden = YES;
    }
}


- (SSKJ_AreaCode_View *)areaView{
    if (!_areaView) {
        _areaView = [[SSKJ_AreaCode_View alloc] initWithColor:kTitleColor];
        _areaView.hidden = ![SSTool isInternationalization];
        _areaView.frame = CGRectMake(ScaleW(5), ScaleW(26), ScreenWidth - ScaleW(10), ScaleW(50));
        [self.view addSubview:_areaView];
    }
    return _areaView;
}

#pragma mark - Getter / Setter
-(BIBindOptionView *)phoneView
{
    if (nil == _phoneView) {
        
        _phoneView = [[BIBindOptionView alloc]initWithFrame:CGRectMake(0, self.areaView.bottom, ScreenWidth, ScaleW(55)) placeHolder:@"请输入您的手机号" keyBoardType:UIKeyboardTypeNumberPad setSecureTextEntry:NO];
        [_phoneView setBackgroundColor:kBgColor];

    }
    return _phoneView;
    
}

-(BIBindOptionView *)codeOptionView
{
    if (!_codeOptionView)
    {
        _codeOptionView = [[BIBindOptionView alloc]initWithFrame:CGRectMake(0, self.phoneView.bottom, self.phoneView.width, ScaleW(55)) placeHolder:@"请输入验证码" keyBoardType:UIKeyboardTypeNumberPad setSecureTextEntry:NO];
        [_codeOptionView setBackgroundColor:kBgColor];
    }
    return _codeOptionView;
}

-(BIBindOptionView *)pwdOptionView
{
    if (!_pwdOptionView)
    {
        _pwdOptionView = [[BIBindOptionView alloc]initWithFrame:CGRectMake(0, self.codeOptionView.bottom, self.codeOptionView.width,self.codeOptionView.height) placeHolder:SSKJLocalized(@"请输入资金密码", nil) keyBoardType:UIKeyboardTypeDefault setSecureTextEntry:YES];
        [_pwdOptionView setBackgroundColor:kBgColor];
    }
    return _pwdOptionView;
}




-(UIButton *)smsCodeButton
{
    if (nil == _smsCodeButton) {
        _smsCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(12) - ScaleW(100), 0, ScaleW(100), ScaleW(30))];
        _smsCodeButton.centerY = self.codeOptionView.centerY;
        _smsCodeButton.backgroundColor = kBlueColor;
        [_smsCodeButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        [_smsCodeButton setTitleColor:kBgColor forState:UIControlStateNormal];
        _smsCodeButton.titleLabel.font = systemFont(ScaleW(12.5));
        _smsCodeButton.layer.masksToBounds = YES;
        _smsCodeButton.layer.cornerRadius = _smsCodeButton.height / 2;
//        _smsCodeButton.layer.borderColor = kBlueColor.CGColor;
//        _smsCodeButton.layer.borderWidth = 1;
        [_smsCodeButton addTarget:self action:@selector(getSmsCodeEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _smsCodeButton;
}

-(UIButton *)submitButton
{
    if (nil == _submitButton) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(12), self.view.bottom - ScaleW(290) - Height_NavBar, ScreenWidth - ScaleW(24), ScaleW(45))];
        [_submitButton setCornerRadius:ScaleW(22.5)];
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
    
    NSString *phone = self.phoneView.valueText;
    if (phone.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入手机号码", nil)];
        return;
    }
    if (phone.length != 11)
    {
        [MBProgressHUD showError:SSKJLocalized(@"手机号码格式错误", nil)];
        return;
    }
    [self getSMCode:phone];
  
}


#pragma mark 提交按钮响应事件
-(void)submitEvent
{
    NSString *phone = self.phoneView.valueText;
    NSString *code = self.codeOptionView.valueText;
    NSString *pwd = self.pwdOptionView.valueText;
    if (phone.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入手机号码", nil)];
        return;
    }
    
    if (phone.length != 11)
    {
        [MBProgressHUD showError:SSKJLocalized(@"手机号码格式错误", nil)];
        return;
    }
    
    if (self.from!=1) {
        if (code.length == 0)
        {
            [MBProgressHUD showError:SSKJLocalized(@"请输入手机验证码", nil)];
            return;
        }
    }
    
    if (pwd.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入资金密码", nil)];
        return;
    }
    
    [self bindPhoneNumber:phone withCode:code withPwd:pwd];
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
    [params setObject:self.areaView.getCode forKey:@"areaCode"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_GetCode_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
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

#pragma mark  绑定手机号请求
-(void)bindPhoneNumber:(NSString*)phone withCode:(NSString*)code withPwd:(NSString*)pwd
{

    WS(weakSelf);
    [MBHUD showHUDAddedTo:self.view];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    
    NSString *url;
    if (self.from != 1) {
        url = BI_BindTelOrEmail_URL;
        [params setObject:kUserID forKey:@"id"];
        [params setObject:phone forKey:@"account"];
        [params setObject:code forKey:@"code"];
        [params setObject:[WLTools md5:pwd] forKey:@"dealPswd"];
        [params setObject:self.areaView.getCode forKey:@"areaCode"];
    } else {
        url = BI_UpdataTelOrEmail_URL;
        [params setObject:kUserID forKey:@"id"];
        [params setObject:phone forKey:@"account"];
        [params setObject:[WLTools md5:pwd] forKey:@"tradePswd"];
    }
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:url RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBHUD hideHUDForView:weakSelf.view];
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == SUCCESSED) {
            if (weakSelf.successBlock) {
                weakSelf.successBlock(phone);
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBHUD hideHUDForView:weakSelf.view];

    }];
    
    
  
}



-(void)selectCountry
{
    WS(weakSelf);
    [SSKJ_Default_ActionsheetView showWithItems:@[@"中国",@"America"] title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
        if (selectIndex == 0) {
            weakSelf.areaCode = @"86";
        }else if (selectIndex == 1){
            weakSelf.areaCode = @"1";
        }
        
//        [weakSelf.phoneView setArea:weakSelf.areaCode];
        
    } cancleBlock:nil];
}

@end



