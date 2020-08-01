//
//  My_BindPhone_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//



@interface ArenModel : NSObject

@property (nonatomic ,strong) NSString *areaCode;
@property (nonatomic ,strong) NSString *areaName;

@property (nonatomic,copy) NSString *area; //大区名
@property (nonatomic,copy) NSString *mobilePrefix; //地区区号数字
@property (nonatomic,copy) NSString *country; //区名





@end

@implementation ArenModel



@end







#import "Mine_BindPhone_ViewController.h"
#import "Mine_TitleAndInput_View.h"
#import "Mine_BindOptionView.h"

#import "SSKJ_Default_ActionsheetView.h"
#import "Mine_BindGoogle_AlertView.h"

@interface Mine_BindPhone_ViewController ()
@property (nonatomic, strong) Mine_BindOptionView *phoneView;

@property (nonatomic, strong) Mine_BindOptionView *codeOptionView;  //!< 验证码
@property (nonatomic, strong) Mine_BindOptionView *pwdOptionView;  //!< 资金密码框

@property (nonatomic, strong) UIButton *smsCodeButton;
@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, copy) NSString *areaCode;

@property(nonatomic, strong)SSKJ_AreaCode_View *areaView;
@property (nonatomic ,strong) UIView *colorsView;
@property (nonatomic ,strong) UIView *lineV;
@property (nonatomic ,strong) UIButton *arenBtn;//手机区号
@property (nonatomic ,strong) NSMutableArray <ArenModel *>*arenArr;//区号数组

@property (nonatomic, strong) Mine_BindGoogle_AlertView *googleAlertView;

@end


@implementation Mine_BindPhone_ViewController
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.view.backgroundColor = kBgColor;
    
    self.areaCode = @"86";

    self.title = SSKJLocalized(@"绑定手机号", nil);

    #pragma mark 添加视图
    
    UIView *topGrayView = [UIView new];
    topGrayView.backgroundColor = kLineColor;
    topGrayView.frame = CGRectMake(0, Height_NavBar, ScreenWidth, ScaleW(10));
    [self.view addSubview:topGrayView];
    self.lineV = topGrayView;
    
    
    [self areaView];
    self.areaView.hidden = YES;
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
    
    
   self.colorsView = [UIView new];
   self.colorsView.frame = self.submitButton.frame;
   self.colorsView.layer.cornerRadius = ScaleW(5);
   self.colorsView.frame = self.submitButton.frame;
   self.colorsView.backgroundColor = kWhiteColor;
   [self.view insertSubview:self.colorsView belowSubview:self.submitButton];
   [self.colorsView setCornerRadius:ScaleW(5) corners:UIRectCornerAllCorners colors:@[UIColorFromRGB(0x529CFE), UIColorFromRGB(0x1E4EBC)]];
    
    
    //区号按钮
    [self.view addSubview:self.arenBtn];
    [self.arenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(ScaleW(0));
        make.top.bottom.mas_equalTo(self.phoneView);
        make.right.mas_equalTo(self.phoneView.mas_left).offset(ScaleW(-10));
    }];
    UIView *lineView = [UIView new];
    lineView.backgroundColor = kLineColor;
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.arenBtn.mas_right).offset(ScaleW(10));
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(ScaleW(20));
        make.centerY.mas_equalTo(self.arenBtn);
    }];
    UIImageView *downImgV = [UIImageView new];
    [self.view addSubview:downImgV];
    downImgV.image = MyImage(@"mine_showhide");
    [downImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(lineView.mas_left).offset(ScaleW(-5));
        make.centerY.mas_equalTo(lineView);
    }];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.arenArr removeAllObjects];
    WS(weakSelf);
    NSArray *arr = [SSTool getAreaCode];
    if (arr.count == 0) {
        [self getInfo:^(NSArray *aren){
            //解析数组
//            [weakSelf anilesysData];
            [weakSelf anilesysDataWithArray:aren];
        }];
    }else{
        [weakSelf anilesysData];
    }
}

- (void)anilesysData{
    NSArray *array = [ArenModel mj_objectArrayWithKeyValuesArray:[SSTool getAreaCode]];
    [self.arenArr removeAllObjects];
    self.arenArr = [array mutableCopy];
    
}

- (void)anilesysDataWithArray:(NSArray *)array {
    self.arenArr = array.mutableCopy;
}


- (void)getInfo:(void(^)(NSArray *aren))complate{
    //区号
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:URL_AreaCode_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject)
     {
         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
         
         if (network_Model.status.integerValue == SUCCESSED)
         {
             /*
              areaCode
              areaName
              */
             NSArray *arr = network_Model.data;
             [SSTool setAreaCode:arr];
             if (complate) {
                 complate(arr);
             }
         }else{
         }
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         
     }];
}


- (NSMutableArray <ArenModel *>*)arenArr{
    if (!_arenArr) {
        _arenArr = [NSMutableArray array];
    }
    return _arenArr;
}

- (SSKJ_AreaCode_View *)areaView{
    if (!_areaView) {
        _areaView = [[SSKJ_AreaCode_View alloc] initWithColor:kTitleColor];
        _areaView.hidden = ![SSTool isInternationalization];
        _areaView.frame = CGRectMake(ScaleW(5), Height_NavBar + ScaleW(26), ScreenWidth - ScaleW(10), ScaleW(50));
        [self.view addSubview:_areaView];
    }
    return _areaView;
}

#pragma mark - Getter / Setter
-(Mine_BindOptionView *)phoneView
{
    if (nil == _phoneView) {
        
        _phoneView = [[Mine_BindOptionView alloc]initWithFrame:CGRectMake(ScaleW(80), self.lineV.bottom, ScreenWidth, ScaleW(55)) placeHolder:SSKJLocalized(@"请输入您的手机号", nil) keyBoardType:UIKeyboardTypeNumberPad setSecureTextEntry:NO];
        [_phoneView setBackgroundColor:kBgColor];

    }
    return _phoneView;
    
}

-(Mine_BindOptionView *)codeOptionView
{
    if (!_codeOptionView)
    {
        _codeOptionView = [[Mine_BindOptionView alloc]initWithFrame:CGRectMake(0, self.phoneView.bottom, self.phoneView.width, ScaleW(55)) placeHolder:SSKJLocalized(@"请输入验证码", nil) keyBoardType:UIKeyboardTypeNumberPad setSecureTextEntry:NO];
        [_codeOptionView setBackgroundColor:kBgColor];
    }
    return _codeOptionView;
}

-(Mine_BindOptionView *)pwdOptionView
{
    if (!_pwdOptionView)
    {
        _pwdOptionView = [[Mine_BindOptionView alloc]initWithFrame:CGRectMake(0, self.codeOptionView.bottom, self.codeOptionView.width,self.codeOptionView.height) placeHolder:SSKJLocalized(@"请输入资金密码", nil) keyBoardType:UIKeyboardTypeDefault setSecureTextEntry:YES];
        [_pwdOptionView setBackgroundColor:kBgColor];
        
        
        
        
    }
    return _pwdOptionView;
}




-(UIButton *)smsCodeButton
{
    if (nil == _smsCodeButton) {
        _smsCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(12) - ScaleW(100), 0, ScaleW(100), ScaleW(30))];
        _smsCodeButton.centerY = self.codeOptionView.centerY;
        _smsCodeButton.backgroundColor = [UIColor clearColor];
        [_smsCodeButton setTitle:SSKJLocalized(@"发送验证码", nil) forState:UIControlStateNormal];
        [_smsCodeButton setTitleColor:kBlueColor forState:UIControlStateNormal];
//        _smsCodeButton.titleLabel.font = systemFont(ScaleW(12.5));
//        _smsCodeButton.layer.masksToBounds = YES;
//        _smsCodeButton.layer.cornerRadius = _smsCodeButton.height / 2;
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
        _submitButton.backgroundColor = [UIColor clearColor];
        [_submitButton setTitle:SSKJLocalized(@"提交", nil)  forState:UIControlStateNormal];
        [_submitButton setTitleColor:kBgColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemFont(ScaleW(16));
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}


- (UIButton *)arenBtn{
    if (!_arenBtn) {
        _arenBtn = [[UIButton alloc]init];
        [_arenBtn setCornerRadius:ScaleW(22.5)];
        _arenBtn.backgroundColor = [UIColor clearColor];
        [_arenBtn setTitle:SSKJLocalized(@"+86", nil)  forState:UIControlStateNormal];
        [_arenBtn setTitleColor:kTitleColor forState:UIControlStateNormal];
        _arenBtn.titleLabel.font = systemFont(ScaleW(14));
        [_arenBtn addTarget:self action:@selector(selectedArenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _arenBtn;
}

#pragma mark - 选择区号
- (void) selectedArenBtnClick:(UIButton *)sender{
    //选择区号
    if (self.arenArr.count == 0) {
        return;
    }
    [self selectCountry];
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
    
    /*
    if (phone.length != 11)
    {
        [MBProgressHUD showError:SSKJLocalized(@"手机号码格式错误", nil)];
        return;
    }
     */
    [self getSMCode:phone];
  
}


#pragma mark 提交按钮响应事件
-(void)submitEvent
{
    WS(weakSelf);
    [self.view endEditing:YES];
    NSString *phone = self.phoneView.valueText;
    NSString *code = self.codeOptionView.valueText;
    NSString *pwd = self.pwdOptionView.valueText;
    if (phone.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入手机号码", nil)];
        return;
    }
    /*
    if (phone.length != 11)
    {
        [MBProgressHUD showError:SSKJLocalized(@"手机号码格式错误", nil)];
        return;
    }
     */
    
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
    
    if(![RegularExpression validatePassword:pwd]){
        [MBProgressHUD showError:SSKJLocalized(@"请输入8-15位资金密码", nil)];
        return;
    }
    
    
    if ([SSKJ_User_Tool sharedUserTool].userInfoModel.config.google_verify.integerValue == 1) {
        [self.googleAlertView showWithType:GOOGLETYPE_Safty];
        self.googleAlertView.submitBlock = ^(NSString * _Nonnull googleCode, NSString * _Nonnull smsCode) {
            [weakSelf requestGoogleSafty:googleCode callback:^{
                [weakSelf bindPhoneNumber:phone withCode:code withPwd:pwd];
            }];
        };
    }else{
        [self bindPhoneNumber:phone withCode:code withPwd:pwd];
    }
    
    
    
    
    
     
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
    [params setObject:self.areaCode forKey:@"areaCode"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_GetSmsCode_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         if (net_model.status.integerValue == SUCCESSED)
         {
             [MBHUD showError:SSKJLocalized(@"发送成功",nil)];
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

-(Mine_BindGoogle_AlertView *)googleAlertView
{
    if (nil == _googleAlertView) {
        _googleAlertView = [[Mine_BindGoogle_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        WS(weakSelf);
        
        
    }
    return _googleAlertView;
}
//谷歌安全验证
- (void) requestGoogleSafty:(NSString *)code callback:(void(^)(void))complate{
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
            if (complate) {
                complate();
            }
            [weakSelf.googleAlertView hide];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
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
        [params setObject:self.areaCode forKey:@"areaCode"];
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
                [SSTool setMyAreaCode:self.areaView.getCode];
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
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (ArenModel *model in self.arenArr) {
//        NSString *str = [NSString stringWithFormat:@"%@ (%@)", model.areaCode ? model.areaCode : @"", model.areaName ? model.areaName : @""];
        NSString *str = [NSString stringWithFormat:@"%@", model.mobilePrefix ? model.mobilePrefix : @""];

        [arrM addObject:str];
    }

    
    WS(weakSelf);
    [SSKJ_Default_ActionsheetView showWithItems:arrM title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
//        if (selectIndex == 0) {
//            weakSelf.areaCode = @"86";
//        }else if (selectIndex == 1){
//            weakSelf.areaCode = @"1";
//        }
//        self.areaCode = self.arenArr[selectIndex].areaCode;
        
        weakSelf.areaCode = [weakSelf.arenArr[selectIndex] mobilePrefix];
        [weakSelf.arenBtn setTitle:[NSString stringWithFormat:@"+%@",self.areaCode]  forState:UIControlStateNormal];
        if ([weakSelf.areaCode hasPrefix:@"+"]) {
            weakSelf.areaCode = [self.areaCode substringFromIndex:1];
        }
        
        
        
        
//        [weakSelf.phoneView setArea:weakSelf.areaCode];
        
    } cancleBlock:nil];
}

@end



