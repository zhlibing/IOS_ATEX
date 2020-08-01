//
//  BFEXShowChartViewCell.m
//  ZYW_MIT
//
//  Created by 张本超 on 2018/7/3.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "BFEXShowChartViewCell.h"
#import "ManagerSocket.h"

@interface BFEXShowChartViewCell()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *nameLabel;
//@property (nonatomic, strong) UITextField *inputTextView;
@property (nonatomic, strong) UIView *upImgView;
@property (nonatomic, strong) UIImageView *selectImg;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) NSDictionary *dataDic;
@end
@implementation BFEXShowChartViewCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = kBgColor;
        [self viewConfigs];
    }
    return self;
}
-(void)viewConfigs
{
    [self nameLabel];
    [self inputTextView];
    [self upImgView];
}
-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, 200, 14)];
        [self label:_nameLabel font:14 textColor:kTitleColor text:@"姓名"];
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

-(UITextField *)inputTextView{
    if (!_inputTextView) {
        _inputTextView = [[UITextField alloc]initWithFrame:CGRectMake(16,_nameLabel.bottom + 12, Screen_Width - 50 - 32, 45.f)];
        [self textField:_inputTextView textFont:14 placeHolderFont:14 text:@"" placeText:@"" textColor:kTitleColor placeHolderTextColor:RGBCOLOR(136,141,157)];
        [_inputTextView setCornerRadius:5.f];
        [_inputTextView setBorderWithWidth:1.f andColor:kLineColor];
        _inputTextView.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        _inputTextView.leftViewMode = UITextFieldViewModeAlways;
        _inputTextView.delegate = self;
        [self.contentView addSubview:_inputTextView];
        
        
    }
    return _inputTextView;
}

-(UIView *)upImgView
{
    if (!_upImgView) {
        _upImgView = [[UIView alloc]initWithFrame:CGRectMake(16,_nameLabel.bottom + 12, Screen_Width - 50 - 32, 60.f)];
        [_upImgView setCornerRadius:5.f];
        [_upImgView setBorderWithWidth:1.f andColor:kLineColor];
        _upImgView.backgroundColor =RGBCOLOR(243, 243, 243);
        
        [self.contentView addSubview:_upImgView];
        _upImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_upImgView addGestureRecognizer:tap];
        _upImgView.hidden = YES;
        self.selectImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_img"]];
        self.selectImg.centerX = _upImgView.width/2;
        self.selectImg.y = 10;
        [_upImgView addSubview:_selectImg];
        _messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _selectImg.bottom +5, _upImgView.width, 12)];
        [self label:_messageLabel font:11 textColor:RGBCOLOR(136,141,157) text:@"请"];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        [_upImgView addSubview:_messageLabel];
        
    }
    return _upImgView;
}
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    !self.backImg?:self.backImg(_selectImg);
    //上传图片
    
}

-(void)setValueWith:(NSDictionary *)dic type:(NSString *)type
{
    self.dataDic = dic;
    NSString *string = dic.allKeys.firstObject;

    _nameLabel.text = dic.allKeys.firstObject;
//    if ([dic[SSKJLocalized(@"姓名", nil)] isEqualToString:SSKJLocalized(@"请输入姓名", nil)] ){
//
//
//    }
    if ([dic[SSKJLocalized(@"支付宝", nil)] isEqualToString:SSKJLocalized(@"请输入支付宝账号", nil)] ||
        [dic[SSKJLocalized(@"微信", nil)] isEqualToString:SSKJLocalized(@"请输入微信账号", nil)] ||
        [dic[SSKJLocalized(@"开户银行", nil)] isEqualToString:SSKJLocalized(@"请输入开户银行名", nil)] ||
        [[NSString stringWithFormat:@"Paypal%@",SSKJLocalized(@"账户", nil)] isEqualToString:SSKJLocalized(@"请输入您的", nil)] ||
        [dic[SSKJLocalized(@"开户支行", nil)] isEqualToString:SSKJLocalized(@"请输入支行名", nil)] ||
        [dic[SSKJLocalized(@"开户银行卡", nil)] isEqualToString:SSKJLocalized(@"请输入银行卡号", nil)]) {
        _inputTextView.text = @"";
        _inputTextView.placeholder = dic.allValues.firstObject;
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:_inputTextView.placeholder attributes:@{NSForegroundColorAttributeName:kSubTitleColor,
                                                                 NSFontAttributeName:_inputTextView.font}];
            _inputTextView.attributedPlaceholder = attrString;
        
    
    }else{
        if ([string isEqualToString:SSKJLocalized(@"资金密码", nil)]) {
            _inputTextView.text = @"";
            _inputTextView.placeholder = dic[string];
        }else{
            _inputTextView.text = dic.allValues.firstObject;
        }
    }
    _messageLabel.text = dic.allValues.firstObject;
    if ([string isEqualToString:SSKJLocalized(@"姓名", nil)]||[string isEqualToString:SSKJLocalized(@"二维码", nil)]) {
        if ([string isEqualToString:SSKJLocalized(@"姓名", nil)])
        {
            _inputTextView.text =  [SSKJ_User_Tool sharedUserTool].userInfoModel.username;
        }
        _inputTextView.enabled = NO;
        
        self.inputTextView.backgroundColor=RGBCOLOR(243, 243, 243);

        if ([string isEqualToString:SSKJLocalized(@"二维码", nil)]){
            [self.selectImg sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:self.model.qrCode]] placeholderImage:[UIImage imageNamed:@"mine_img"]];
         
            
        }
        
    }else{
        _inputTextView.enabled = YES;
    }
    if ([string isEqualToString:SSKJLocalized(@"二维码", nil)])
    {
        _upImgView.hidden = NO;
        _inputTextView.hidden = YES;
    }else{
        _upImgView.hidden = YES;
        _inputTextView.hidden = NO;
    }
    if ([string isEqualToString:SSKJLocalized(@"资金密码", nil)])
    {
        _inputTextView.secureTextEntry = YES;
    }else{
        _inputTextView.secureTextEntry = NO;
        
    }
   
    if([string isEqualToString:SSKJLocalized(@"开户银行卡", nil)]){
        //bank_car
        _inputTextView.keyboardType = UIKeyboardTypeNumberPad;
        
    }else{
        _inputTextView.keyboardType = UIKeyboardTypeDefault;
    }
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:_inputTextView.placeholder attributes:
                                          @{NSForegroundColorAttributeName:kSubTitleColor,
                                                             NSFontAttributeName:_inputTextView.font}];
        _inputTextView.attributedPlaceholder = attrString;
    
    if ([string isEqualToString:SSKJLocalized(@"二维码", nil)]){
       
        
        _inputTextView.textColor=RGBCOLOR(136,141,157);
        
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
     NSString *string = _dataDic.allKeys.firstObject;
    if ([string isEqualToString:SSKJLocalized(@"支付宝", nil)]) {
        [[ManagerSocket sharedManager].dataDic setObject:_inputTextView.text forKey:@"alipay"];
    }
    if ([string isEqualToString:SSKJLocalized(@"微信", nil)]) {
        [[ManagerSocket sharedManager].dataDic setObject:_inputTextView.text forKey:@"wx"];
    }
    if ([string isEqualToString:SSKJLocalized(@"资金密码", nil)]) {
        [[ManagerSocket sharedManager].dataDic setObject:_inputTextView.text forKey:@"tpwd"];
        _inputTextView.secureTextEntry = YES;
    }else{
       _inputTextView.secureTextEntry = NO;
    }
    if ([string isEqualToString:SSKJLocalized(@"开户银行", nil)]) {
        [[ManagerSocket sharedManager].dataDic setObject:_inputTextView.text forKey:@"bank"];
    }
    NSString *str = [NSString stringWithFormat:@"Paypal%@",SSKJLocalized(@"账户", nil)];
    if ([string isEqualToString:str]) {
        [[ManagerSocket sharedManager].dataDic setObject:_inputTextView.text forKey:@"Paypal"];
    }
    
    if([string isEqualToString:SSKJLocalized(@"开户支行", nil)]){
        [[ManagerSocket sharedManager].dataDic setObject:_inputTextView.text forKey:@"branch"];
    }
    if([string isEqualToString:SSKJLocalized(@"开户银行卡", nil)]){
        //bank_car
//        if ( _inputTextView.text.length >= 15 && _inputTextView.text.length <= 20 ) {
              [[ManagerSocket sharedManager].dataDic setObject:_inputTextView.text forKey:@"bank_car"];
//        }else{
//            [MBProgressHUD showError:@"银行卡号位数不符"];
//        }
    
    }
}

@end
