//
//  BLPopVerView.m
//  BiLe
//
//  Created by 李赛 on 2017/02/14.
//  Copyright © 2018年 LS. All rights reserved.
//

#import "BLPopVerView.h"
#import "BLTextField.h"



#define kInnerViewHeight 240

typedef void(^currentTitleBlock)(NSString *title);

@interface BLPopVerView () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *quxiaoBtn;

@property (weak, nonatomic) IBOutlet UIView *innerView;

@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;

@property (weak, nonatomic) IBOutlet BLTextField *codeTextField;

@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@property (weak, nonatomic) IBOutlet UIButton *codeButton;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@property (nonatomic, copy) currentTitleBlock block;

@property (nonatomic, copy) NSString *code;

/**计时器*/
@property (nonatomic , strong) dispatch_source_t timer;

@end

@implementation BLPopVerView

+ (instancetype)popVerView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
    if (self) {
        self.frame = frame;
        [self.quxiaoBtn setTitle:SSKJLocalized(@"取消", nil) forState:0];
        self.titleLabel.text = SSKJLocalized(@"安全验证", nil);
        self.codeTextField.placeholder = SSKJLocalized(@"请输入验证码", nil);
        [self.confirmButton setTitle:SSKJLocalized(@"确认", nil) forState:UIControlStateNormal];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    _confirmButton.enabled = NO;
    _confirmButton.backgroundColor = [UIColor redColor];
    
    __weak typeof(self) weakSelf = self;
    [self getTimer:^(NSString *title) {
        [weakSelf.codeButton setTitle:title forState:UIControlStateNormal];
        weakSelf.codeButton.enabled = NO;
    }];
    
    [_codeTextField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
//    [kNotifyCenter addObserver:self selector:@selector(textValueChanged) name:uitextfieldeni object:_codeTextField];
    
//    [kNotifyCenter addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
//    [kNotifyCenter addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)textValueChanged:(UITextField *)textField {
    if (textField.text.length >= 6) {
        if ([self.fromVC isEqualToString:@"google"]) {
            self.code = _codeTextField.text;
        }else{
            self.code = _codeTextField.text;
            [self verCode:_codeTextField.text];
        }
        
    } else {
        if ([self.fromVC isEqualToString:@"google"]) {
            self.confirmButton.enabled = YES;
            self.confirmButton.backgroundColor = [UIColor redColor];
            self.code = _codeTextField.text;
        }else{
            _confirmButton.enabled = NO;
            _confirmButton.backgroundColor = [UIColor redColor];
        }
        
    }
    
    
//    if (_codeTextField.text.length >= 6) {
//        self.code = _codeTextField.text;
//        [self verCode:_codeTextField.text];
//    }
    
//    if (_codeTextField.text.length != 0) {
//        _confirmButton.enabled = YES;
//        _confirmButton.backgroundColor = kSubTitleColor;
//        if (_codeTextField.text.length >= 6) {
//            self.code = _codeTextField.text;
//            [self verCode:_codeTextField.text];
//        }
//    } else {
//        _confirmButton.enabled = NO;
//        _confirmButton.backgroundColor = kSubBgColor;
//    }
}

- (void)verCode:(NSString *)code {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = _phoneNumber;
    params[@"code"] = code;
    __weak typeof(self) weakSelf = self;
//    [HttpTool postWithURL:VerCodeURL params:params success:^(id json) {
//        NSString *status = json[@"status"];
//        LSLog(@"json : %@",json);
//        if (status.integerValue == SUCCESSED) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                weakSelf.confirmButton.enabled = YES;
//                weakSelf.confirmButton.backgroundColor = kSubTitleColor;
//                [MBProgressHUD showError:json[@"msg"]];
//            });
//        } else {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                weakSelf.confirmButton.enabled = NO;
//                weakSelf.confirmButton.backgroundColor = kSubBgColor;
//                [MBProgressHUD showError:json[@"msg"]];
//            });
//        }
//    } failure:^(NSError *error) {
//        LSLog(@"error : %@",error);
//        [MBProgressHUD showError:SSKJLocalized(@"服务器请求异常", nil)];
//    }];
}

// 键盘改变事件的触发
- (void)keyboardChange:(NSNotification *)notify {
    NSDictionary *dict = notify.userInfo;
    NSValue *aValue = [dict objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSNumber *animationTime = [dict objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat keyHeight = - keyboardRect.size.height;
    if(keyHeight <= 0){
        [UIView animateWithDuration:[animationTime doubleValue] animations:^{
            self.innerView.y = ScreenHeight + keyHeight - kInnerViewHeight;
        } completion:nil];
    }
}

// 键盘隐藏事件
- (void)keyboardHide:(NSNotification *)notify {
    NSDictionary *dict = notify.userInfo;
    NSNumber *animationTime = [dict objectForKey:@"UIKeyboardAnimationDurationUserInfoKey"];
    [UIView animateWithDuration:[animationTime doubleValue] animations:^{
        self.innerView.y = ScreenHeight - kInnerViewHeight;
    } completion:nil];
}

// 取消
- (IBAction)cancel:(UIButton *)sender {
    [self dismissPopView];
}

- (void)dismissPopView {
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight);
    } completion:^(BOOL finished) {
        dispatch_cancel(_timer);
        [self removeFromSuperview];
    }];
}

- (IBAction)requestSMSCode:(UIButton *)sender {
    
    if (![RegularExpression validateEmail:_phoneNumber] ) {
        if ([self.fromVC isEqualToString:@"google"]) {
            [self googleRequestCode];
        }else{
            [self requestCode];
        }
    }else{
        [self requestEmailCode];
    }
    
    [self getTimer:^(NSString *title) {
        [_codeButton setTitle:title forState:UIControlStateNormal];
        _codeButton.enabled = NO;
    }];
}


/**
 请求 短信验证码
 */
- (void)requestCode {
    SSLog(@"mobile : %@",_phoneNumber);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = self.phoneNumber;
    params[@"type"] = @"2";
    
//    [HttpTool postWithURL:SendCodeURL params:params success:^(id json) {
//        NSString *status = json[@"status"];
//        LSLog(@"json : %@",json);
//        if (status.integerValue == SUCCESSED) {
//            [MBProgressHUD showError:json[@"msg"]];
//        } else {
//            [MBProgressHUD showError:json[@"msg"]];
//        }
//    } failure:^(NSError *error) {
//        LSLog(@"error : %@",error);
//        [MBProgressHUD showError:SSKJLocalized(@"服务器请求异常", nil)];
//    }];
}

/**
 谷歌验证 请求 短信验证码
 */
- (void)googleRequestCode {
//    [HttpTool postWithURL:SetGoogleMsg params:nil success:^(id json) {
//        NSString *status = json[@"status"];
//        SSLog(@"json : %@",json);
//        if (status.integerValue == SUCCESSED) {
//            [MBProgressHUD showError:json[@"msg"]];
//        } else {
//            [MBProgressHUD showError:json[@"msg"]];
//        }
//    } failure:^(NSError *error) {
//        SSLog(@"error : %@",error);
//        [MBProgressHUD showError:SSKJLocalized(@"服务器请求异常", nil)];
//    }];
}

//获取邮箱验证码
- (void)requestEmailCode{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"email"] = self.phoneNumber;
    
    //    __weak typeof(self) weakSelf = self;
//    [HttpTool postWithURL:Getsend_email params:params success:^(id json) {
//        NSString *status = json[@"status"];
//        if (status.integerValue == SUCCESSED) {
//            [MBProgressHUD showError:json[@"msg"]];
//        } else {
//            [MBProgressHUD showError:json[@"msg"]];
//        }
//    } failure:^(NSError *error) {
//        [MBProgressHUD showError:SSKJLocalized(@"服务器请求异常", nil)];
//    }];
}


// 获取验证码时间
- (void)getTimer:(currentTitleBlock)block {
    self.block = block;
    [self startTimer];
}

// 开始计时
- (void)startTimer {
    __weak typeof(self) weakSelf = self;
    __block int duration = 59; // 倒计时时长
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); // 每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if (duration <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置界面的按钮显示
                weakSelf.block(SSKJLocalized(@"重新", nil));
                weakSelf.codeButton.enabled = YES;
            });
        }else{
            int seconds = duration % 60;
            NSString *strTime = [NSString stringWithFormat:SSKJLocalized(@"%s", nil),seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置界面的按钮显示
                self.block(strTime);
            });
            duration --;
        }
    });
    dispatch_resume(_timer);
}

- (void)present:(presentBlock)block {
    self.presentBlock = block;
}

/**
 确认
 */
- (IBAction)confirm:(UIButton *)sender {
    // 判断验证码是否正确
    self.presentBlock(_code);
}

- (void)setPhoneNumber:(NSString *)phoneNumber {
    _phoneNumber = phoneNumber;
    
    NSMutableString* str1 = [[NSMutableString alloc]initWithString:phoneNumber];
    NSString *mobileStr;
    if (![RegularExpression validateEmail:phoneNumber] ) {
        _phoneNumberLabel.text = [phoneNumber stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }else{
        NSRange range = [phoneNumber rangeOfString:@"@"];
        SSLog(@"%lu",(unsigned long)range.location);
        if (range.location == 0) {
            [str1 insertString:@"*" atIndex:1];
            mobileStr = [NSString stringWithFormat:@"%@",str1];
        }else if (range.location == 1){
            mobileStr = [phoneNumber stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"*"];
        }else if (range.location == 2){
            mobileStr = [phoneNumber stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"****"];
        }else if (range.location == 3){
            mobileStr = [phoneNumber stringByReplacingCharactersInRange:NSMakeRange(1, 2) withString:@"****"];
        }else if (range.location == 4){
            mobileStr = [phoneNumber stringByReplacingCharactersInRange:NSMakeRange(2, 2) withString:@"****"];
        }else if (range.location == 5){
            mobileStr = [phoneNumber stringByReplacingCharactersInRange:NSMakeRange(2, 3) withString:@"****"];
        }else{
            mobileStr = [phoneNumber stringByReplacingCharactersInRange:NSMakeRange(2, 4) withString:@"****"];
        }
        _phoneNumberLabel.text = phoneNumber;
    }
    
    
    if (![RegularExpression validateEmail:phoneNumber] ) {
        if ([self.fromVC isEqualToString:@"google"]) {
            [self googleRequestCode];
        }else{
            [self requestCode];
        }
    }else{
        [self requestEmailCode];
    }
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    SSLog(@"removeFromSuperview");
    dispatch_cancel(_timer);
}

- (void)dealloc {
//    [kNotifyCenter removeObserver:self];
}

@end
