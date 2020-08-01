//
//  My_BindGoogle_AlertView.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_BindGoogle_AlertView.h"
#import "BIAuthCodeHelper.h"

@interface My_BindGoogle_AlertView ()
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *googleView;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UIView *phoneView;
@property (nonatomic, strong) UITextField *iphoneTextField;
@property (nonatomic, strong) UIButton *smsCodeButton;
@property (nonatomic, strong) UIButton *submiteButton;
@end
@implementation My_BindGoogle_AlertView
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
        {
            [self addSubview:self.alertView];
            [self.alertView addSubview:self.titleLabel];
            
            self.googleView = [self addInputViewWithFrame:CGRectMake(0, self.titleLabel.bottom + ScaleW(15), ScreenWidth, ScaleW(88)) title:SSKJLocalized(@"谷歌验证码", nil) placeHolder:SSKJLocalized(@"请输入谷歌验证码", nil) keyBoardType:UIKeyboardTypeASCIICapable];
            
            [self.alertView addSubview:self.googleView];
            
            
            NSString *title = SSKJLocalized(@"验证手机", nil);
            NSString *placeHolder = SSKJLocalized(@"请输入手机验证码", nil);
            if ([RegularExpression validateEmail:kAccount]) {
                title = SSKJLocalized(@"验证邮箱", nil);
                placeHolder = SSKJLocalized(@"请输入邮箱验证码", nil);
            }
            self.phoneView = [self addInputViewWithFrame:CGRectMake(0, self.googleView.bottom , ScreenWidth, ScaleW(88)) title:title placeHolder:placeHolder keyBoardType:UIKeyboardTypeNumberPad];
            
            [self.submiteButton setFrame:CGRectMake(ScaleW(12), self.phoneView.bottom + ScaleW(38), ScreenWidth - ScaleW(24), ScaleW(45))];
            [self.alertView addSubview:self.phoneView];
            [self.alertView addSubview:self.submiteButton];
            
            self.alertView.height = self.submiteButton.bottom + ScaleW(27);
        }
            break;
        case GOOGLETYPEADD:
        {
            [self addSubview:self.alertView];
            [self.alertView addSubview:self.titleLabel];
            
            self.googleView = [self addInputViewWithFrame:CGRectMake(0, self.titleLabel.bottom + ScaleW(15), ScreenWidth, ScaleW(88)) title:SSKJLocalized(@"谷歌验证码", nil) placeHolder:SSKJLocalized(@"请输入谷歌验证码", nil) keyBoardType:UIKeyboardTypeASCIICapable];
            
            [self.submiteButton setFrame:CGRectMake(ScaleW(12), self.googleView.bottom + ScaleW(38), ScreenWidth - ScaleW(24), ScaleW(45))];
            
            [self.alertView addSubview:self.googleView];
            [self.alertView addSubview:self.submiteButton];
            self.alertView.height = self.submiteButton.bottom + ScaleW(27);
        }
            break;
    }
    
    [self.alertView byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight  cornerRadii:CGSizeMake(10, 10)];
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
        textField.width = ScreenWidth - ScaleW(24);
    }else{
        self.iphoneTextField = textField;
        self.smsCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(12) - ScaleW(100), 0, ScaleW(100), ScaleW(30))];
        self.smsCodeButton.centerY = textField.centerY;
        [self.smsCodeButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        [self.smsCodeButton setTitleColor:kBlueColor forState:UIControlStateNormal];
        self.smsCodeButton.titleLabel.font = systemFont(ScaleW(12));
        self.smsCodeButton.layer.masksToBounds = YES;
        self.smsCodeButton.layer.cornerRadius = ScaleW(12);
        self.smsCodeButton.layer.borderColor = kBlueColor.CGColor;
        self.smsCodeButton.layer.borderWidth = 1;
        [self.smsCodeButton addTarget:self action:@selector(getSmsCodeEvent) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:self.smsCodeButton];
    }
    
    
    
    return view;

}

-(UIButton *)submiteButton
{
    if (nil == _submiteButton) {
        _submiteButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(12), self.phoneView.bottom + ScaleW(38), ScreenWidth - ScaleW(24), ScaleW(45))];
        _submiteButton.layer.cornerRadius = ScaleW(5);
        _submiteButton.backgroundColor = kBlueColor;
        [_submiteButton setTitle:SSKJLocalized(@"提交", nil) forState:UIControlStateNormal];
        [_submiteButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _submiteButton.titleLabel.font = systemFont(ScaleW(16));
        [_submiteButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submiteButton;
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
            string = SSKJLocalized(@"绑定谷歌验证", nil);
        }
            break;
        case GOOGLETYPEDELETE:
        {
            string = SSKJLocalized(@"解除谷歌验证", nil);
        }
            break;
    }
    self.type = googleType;
    self.titleLabel.text = string;
    
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
    if (self.codeTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入谷歌验证码", nil)];
        return;
    }
    
    if (self.iphoneTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入验证码", nil)];
        return;
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
