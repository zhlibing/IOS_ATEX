//
//  My_BindGoogle_AlertView.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "Mine_BindGoogle_AlertView.h"
#import "BIAuthCodeHelper.h"

@interface Mine_BindGoogle_AlertView ()
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *googleView;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UIView *phoneView;
@property (nonatomic, strong) UITextField *iphoneTextField;
@property (nonatomic, strong) UIButton *smsCodeButton;
@property (nonatomic, strong) UIButton *submiteButton;
@property (nonatomic ,strong) UIView *colorsView;
@property (nonatomic ,strong) UIButton *closeBtn;
@property (nonatomic ,strong) UIButton *pownDownBtn;
@property (nonatomic ,strong) UILabel *subtitleLb;
@end
@implementation Mine_BindGoogle_AlertView
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tap];
        
        // 添加通知监听见键盘弹出/退出// 键盘出现的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
        // 键盘消失的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];

        
    }
    return self;
}



- (void)setType:(GOOGLETYPE)type
{
    _type = type;
    switch (type)
    {
        case GOOGLETYPEBIND:
        case GOOGLETYPEDELETE:
        case GOOGLETYPE_TB:
        {
            self.phoneView.hidden = NO;
            [self addSubview:self.alertView];
            [self.alertView addSubview:self.titleLabel];
            NSString *title;
            NSString *placeHolder;
            if (type == GOOGLETYPE_TB) {
                [self.googleView removeFromSuperview];
                title = SSKJLocalized(@"谷歌验证", nil);
                placeHolder = SSKJLocalized(@"请输入谷歌验证码", nil);
                self.googleView = [self addInputViewWithFrame:CGRectMake(0, self.titleLabel.bottom + ScaleW(15), ScreenWidth, ScaleW(88)) title:SSKJLocalized(@"资金密码", nil) placeHolder:SSKJLocalized(@"请输入资金密码", nil) keyBoardType:UIKeyboardTypeASCIICapable];
                
            }else{
                self.googleView = [self addInputViewWithFrame:CGRectMake(0, self.titleLabel.bottom + ScaleW(15), ScreenWidth, ScaleW(88)) title:SSKJLocalized(@"谷歌验证码", nil) placeHolder:SSKJLocalized(@"请输入谷歌验证码", nil) keyBoardType:UIKeyboardTypeASCIICapable];
                if ([kAccount containsString:@"@"]) {
                    title = [NSString stringWithFormat:SSKJLocalized(@"邮箱 : %@", nil), [WLTools hideEmailWithEmail:kAccount]];
                    placeHolder = SSKJLocalized(@"请输入邮箱验证码", nil);
                }else{
                    title = [NSString stringWithFormat:SSKJLocalized(@"手机 : %@", nil),  [WLTools hidePhoneMiddleNumberWithMobile:kAccount]];
                    placeHolder = SSKJLocalized(@"请输入手机验证码", nil);
                }
            }
            [self.alertView addSubview:self.googleView];

            self.phoneView = [self addInputViewWithFrame:CGRectMake(0, self.googleView.bottom , ScreenWidth, ScaleW(88)) title:title placeHolder:placeHolder keyBoardType:UIKeyboardTypeNumberPad];
            if (self.type == GOOGLETYPE_TB) {
                self.iphoneTextField.secureTextEntry = YES;
            }
            [self.submiteButton setFrame:CGRectMake(ScaleW(12), self.phoneView.bottom + ScaleW(38), ScreenWidth - ScaleW(24), ScaleW(45))];
            [self.alertView addSubview:self.phoneView];
            [self.alertView addSubview:self.submiteButton];
            
            self.alertView.height = self.submiteButton.bottom + ScaleW(27);
            
            
                        
            
        }
            break;
        case GOOGLETYPEADD:
        case GOOGLETYPE_Safty:
        {
            [self addSubview:self.alertView];
            [self.alertView addSubview:self.titleLabel];
            self.phoneView.hidden = YES;
            self.googleView = [self addInputViewWithFrame:CGRectMake(0, self.titleLabel.bottom + ScaleW(15), ScreenWidth, ScaleW(88)) title:SSKJLocalized(@"谷歌验证码", nil) placeHolder:SSKJLocalized(@"请输入谷歌验证码", nil) keyBoardType:UIKeyboardTypeASCIICapable];
            
            [self.submiteButton setFrame:CGRectMake(ScaleW(12), self.googleView.bottom + ScaleW(38), ScreenWidth - ScaleW(24), ScaleW(45))];
            
            [self.alertView addSubview:self.googleView];
            [self.alertView addSubview:self.submiteButton];
            
            self.alertView.height = self.submiteButton.bottom + ScaleW(27);
        }
            break;
    }
    
    
    
    self.colorsView = [UIView new];
    [self.alertView insertSubview:self.colorsView belowSubview:self.submiteButton];
    self.colorsView.frame = self.submiteButton.frame;
    self.colorsView.layer.cornerRadius = ScaleW(5);
    [self.colorsView setCornerRadius:ScaleW(5) corners:UIRectCornerAllCorners colors:@[UIColorFromRGB(0x529CFE), UIColorFromRGB(0x1E4EBC)]];
    
    [self.alertView byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight  cornerRadii:CGSizeMake(10, 10)];
    
    [self.alertView addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.alertView.mas_right).offset(ScaleW(-15));
        make.centerY.mas_equalTo(self.titleLabel);
        make.height.mas_equalTo(ScaleW(40));
    }];
}



-(UIView *)alertView
{
    if (nil == _alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height, ScreenWidth, 0)];
        _alertView.backgroundColor = kBgColor;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
        [_alertView addGestureRecognizer:tap];
    }
    return _alertView;
}

- (UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(ScaleW(10), ScaleW(24), ScreenWidth, ScaleW(15)) text:@"" textColor:kTitleColor font:systemFont(ScaleW(15.0))];
    }
    return _titleLabel;
}

-(UIView *)addInputViewWithFrame:(CGRect )frame title:(NSString *)title placeHolder:(NSString *)placeHolder keyBoardType:(UIKeyboardType)keyBoardType
{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = kBgColor;
    UILabel *titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(ScaleW(12), ScaleW(20), ScaleW(200), ScaleW(13)) text:title textColor:kTitleColor font:systemFont(ScaleW(13))];
    [view addSubview:titleLabel];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(titleLabel.x, titleLabel.bottom + ScaleW(14), ScaleW(200), ScaleW(40))];
    textField.textColor = kTitleColor;
    textField.font = systemFont(ScaleW(14));
    textField.placeholder = placeHolder;
    textField.keyboardType = keyBoardType;
//    [textField setValue:RGBCOLOR(136,141,157) forKeyPath:@"_placeholderLabel.textColor"];

    [view addSubview:textField];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(textField.x, textField.bottom, view.width - ScaleW(24), ScaleW(0.5))];
    [lineView setBackgroundColor:kLineColor];
    [view addSubview:lineView];
    
    if ([title isEqualToString:SSKJLocalized(@"谷歌验证码", nil)]) {
        self.codeTextField = textField;
        self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        textField.width = ScreenWidth - ScaleW(24);
    }else if ([title isEqualToString:SSKJLocalized(@"谷歌验证", nil)]){
        self.codeTextField = textField;
        self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        textField.width = ScreenWidth - ScaleW(24);
    }
    else{
        self.iphoneTextField = textField;
        self.smsCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(12) - ScaleW(100), 0, ScaleW(100), ScaleW(30))];
        self.smsCodeButton.centerY = textField.centerY;
        [self.smsCodeButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        [self.smsCodeButton setTitleColor:kBlueColor forState:UIControlStateNormal];
        self.smsCodeButton.titleLabel.font = systemFont(ScaleW(12));
        self.smsCodeButton.layer.masksToBounds = YES;
        self.smsCodeButton.layer.cornerRadius = ScaleW(12);
        self.smsCodeButton.layer.borderColor = [UIColor clearColor].CGColor;
        self.smsCodeButton.layer.borderWidth = 1;
        [self.smsCodeButton addTarget:self action:@selector(getSmsCodeEvent) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:self.smsCodeButton];
    }
    
    
    if (self.type == GOOGLETYPE_TB) {
        self.smsCodeButton.hidden = YES;
    }else{
        self.smsCodeButton.hidden = NO;
    }
    
    
    
    
    
    
    return view;

}

-(UIButton *)submiteButton
{
    if (nil == _submiteButton) {
        _submiteButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(12), self.phoneView.bottom + ScaleW(38), ScreenWidth - ScaleW(24), ScaleW(45))];
        _submiteButton.layer.cornerRadius = ScaleW(5);
        _submiteButton.backgroundColor = [UIColor clearColor];
        [_submiteButton setTitle:SSKJLocalized(@"提交", nil) forState:UIControlStateNormal];
        [_submiteButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _submiteButton.titleLabel.font = systemFont(ScaleW(16));
        [_submiteButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submiteButton;
}


- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setTitleColor:UIColorFromRGB(0x6F89AA) forState:UIControlStateNormal];
        [_closeBtn setTitle:SSKJLocalized(@"取消", nil) forState:UIControlStateNormal];
        _closeBtn.titleLabel.font = systemFont(13);
        [_closeBtn addTarget: self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeBtn;
}



-(void)showWithType:(GOOGLETYPE)googleType
{
    NSString *string = @"";
    switch (googleType)
    {
        case GOOGLETYPEBIND:
        {
            string = SSKJLocalized(@"绑定谷歌验证", nil);
        }
            break;
        case GOOGLETYPEADD:
        {
            string = SSKJLocalized(@"开启谷歌验证", nil);
        }
            break;
        case GOOGLETYPEDELETE:
        {
            string = SSKJLocalized(@"关闭谷歌验证", nil);
            
            //展示下拉菜单
            
            
            break;
        }
        case GOOGLETYPE_Safty:
        {
            string = SSKJLocalized(@"安全验证", nil);
            break;
        }
        case GOOGLETYPE_TB:
        {
            string = SSKJLocalized(@"安全验证", nil);
            
            break;
        }
        break;
    }
    self.type = googleType;
    self.titleLabel.text = string;
    self.titleLabel.textColor = kBlueColor;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alertView.y = weakSelf.height - weakSelf.alertView.height;
    }];
}

-(void)endEdit
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

-(void)hide
{
    if ([self.codeTextField isFirstResponder] || [self.iphoneTextField isFirstResponder]) {
        [self endEdit];
        return;
    }
    WS(weakSelf);
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.alertView.y = weakSelf.height;
    } completion:^(BOOL finished) {
        !weakSelf.cancleCallBack ? : weakSelf.cancleCallBack();
        [weakSelf removeFromSuperview];
    }];
}


#pragma mark - 用户操作
-(void)getSmsCodeEvent
{
    WS(weakSelf);
    BIAuthCodeHelper *helper = [[BIAuthCodeHelper alloc]init];
    [helper authWithAccount:kAccount withType:@"5"];
    [helper setSentSuccessfullyBlock:^(BOOL Sucess)
    {
        if (Sucess)
        {
            [weakSelf changeCheckcodeButtonState:YES];
        }
    }];
}




-(void)submitEvent
{
    if (self.type == GOOGLETYPE_TB) {
        
        
        if (self.codeTextField.text.length == 0) {
            [MBProgressHUD showError:SSKJLocalized(@"请输入资金密码", nil)];
            return;
        }
        
        if (self.iphoneTextField.text.length == 0) {
            [MBProgressHUD showError:SSKJLocalized(@"请输入谷歌验证码", nil)];
            return;
        }
        
    }else if(self.type == GOOGLETYPE_Safty){
        if (self.codeTextField.text.length == 0) {
            [MBProgressHUD showError:SSKJLocalized(@"请输入谷歌验证码", nil)];
            return;
        }
    }else{
        if (self.codeTextField.text.length == 0) {
            [MBProgressHUD showError:SSKJLocalized(@"请输入谷歌验证码", nil)];
            return;
        }
        
        if (self.type == GOOGLETYPEADD) {
            
        }else{
            if (self.iphoneTextField.text.length == 0) {
                [MBProgressHUD showError:SSKJLocalized(@"请输入验证码", nil)];
                return;
            }
        }
    }
    
    
    if (self.submitBlock) {
        self.submitBlock(self.codeTextField.text, self.iphoneTextField.text);
    }
    [self hide];
}

#pragma mark 倒计时
- (void)changeCheckcodeButtonState:(BOOL)state
{
    [self.smsCodeButton setEnabled:NO];
    
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
            
            NSString *strTime = [NSString stringWithFormat:SSKJLocalized(@"%ds", nil), seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.smsCodeButton setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateDisabled];
                self.smsCodeButton.enabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}


#pragma mark -键盘监听方法
- (void)keyboardWasShown:(NSNotification *)notification
{
    UIView *backView = self.phoneView;
    
    // 获取键盘的高度
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat textFieldY = ScreenHeight - (ScreenHeight - self.alertView.height / 2 + backView.bottom);
    
    if (frame.size.height > textFieldY) {
        CGFloat yscale = frame.size.height - textFieldY;
        self.alertView.y = ScreenHeight - self.alertView.height / 2 - yscale;
    }
    
}
- (void)keyboardWillBeHiden:(NSNotification *)notification
{
    self.alertView.y = self.height - self.alertView.height;
}


- (UIButton *)pownDownBtn{
    if (!_pownDownBtn) {
        _pownDownBtn = [UIButton new];
        [_pownDownBtn setImage:MyImage(@"") forState:UIControlStateNormal];
        [_pownDownBtn addTarget:self action:@selector(pulldownBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pownDownBtn;
}

- (void) pulldownBtnClick{
    WS(weakSelf);
    [SSKJ_Default_ActionsheetView showWithItems:@[[SSKJ_User_Tool sharedUserTool].userInfoModel.email,[SSKJ_User_Tool sharedUserTool].userInfoModel.phone ] title:@"" selectedIndexBlock:^(NSInteger selectIndex) {
        if (selectIndex == 0) {
            
        }else{
            
        }
    } cancleBlock:^{
        
    }];
}


@end
