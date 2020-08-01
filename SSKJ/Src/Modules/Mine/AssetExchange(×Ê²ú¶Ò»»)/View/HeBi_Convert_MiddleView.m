//
//  HeBi_Convert_MiddleView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_Convert_MiddleView.h"
#import "UITextField+Helper.h"

@interface HeBi_Convert_MiddleView ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *duihuanAmmountTitleLabel;    // 兑换数量
@property (nonatomic, strong) UILabel *duihuanUnitLabel; // 兑换单位
@property (nonatomic, strong) UITextField *duihuanTextField;// 兑换输入框

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *zichanAmmountTitleLabel;    // 兑换数量
@property (nonatomic, strong) UILabel *zichanUnitLabel; // 资产单位
@property (nonatomic, strong) UITextField *zichanTextField;// 可兑换的资产
@end

@implementation HeBi_Convert_MiddleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kSubBgColor;
        [self setUI];
    }
    return self;
}


-(void)setUI
{
    [self addSubview:self.duihuanAmmountTitleLabel];
    [self addSubview:self.duihuanUnitLabel];
    [self addSubview:self.duihuanTextField];
    
    [self addSubview:self.lineView];
    
    [self addSubview:self.zichanAmmountTitleLabel];
    [self addSubview:self.zichanUnitLabel];
    [self addSubview:self.zichanTextField];
    
    self.height = self.zichanAmmountTitleLabel.bottom;
}

-(UILabel *)duihuanAmmountTitleLabel
{
    if (nil == _duihuanAmmountTitleLabel) {
        _duihuanAmmountTitleLabel = [WLTools allocLabel:SSKJLocalized(@"兑换数量", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), 0, ScaleW(62), ScaleW(50)) textAlignment:NSTextAlignmentLeft];
    }
    return _duihuanAmmountTitleLabel;
}

-(UILabel *)duihuanUnitLabel
{
    if (nil == _duihuanUnitLabel) {
        _duihuanUnitLabel = [WLTools allocLabel:SSKJLocalized(@"HBI", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(50), 0, ScaleW(50), ScaleW(50)) textAlignment:NSTextAlignmentRight];
    }
    return _duihuanUnitLabel;
}

-(UITextField *)duihuanTextField
{
    if (nil == _duihuanTextField) {
        _duihuanTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.duihuanAmmountTitleLabel.right + ScaleW(12), 0, self.duihuanUnitLabel.x - self.duihuanAmmountTitleLabel.right - ScaleW(12), ScaleW(50))];
        _duihuanTextField.placeholder = @"0.00";
        _duihuanTextField.textColor = kTitleColor;
        _duihuanTextField.font = systemFont(ScaleW(14));
//        [_duihuanTextField setValue:kSubTitleColor forKeyPath:@"_placeholderLabel.textColor"];
        _duihuanTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _duihuanTextField.delegate = self;
        [_duihuanTextField addTarget:self action:@selector(inputChanged:) forControlEvents:UIControlEventEditingChanged];
        
    }
    return _duihuanTextField;
}

-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.duihuanAmmountTitleLabel.bottom, ScreenWidth, 0.5)];
        _lineView.backgroundColor = kBgColor;
    }
    return _lineView;
}

-(UILabel *)zichanAmmountTitleLabel
{
    if (nil == _zichanAmmountTitleLabel) {
        _zichanAmmountTitleLabel = [WLTools allocLabel:SSKJLocalized(@"资产数量", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), self.lineView.bottom, ScaleW(62), ScaleW(50)) textAlignment:NSTextAlignmentLeft];
    }
    return _zichanAmmountTitleLabel;
}

-(UILabel *)zichanUnitLabel
{
    if (nil == _zichanUnitLabel) {
        _zichanUnitLabel = [WLTools allocLabel:SSKJLocalized(@"USDT", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(50), self.zichanAmmountTitleLabel.y, ScaleW(50), ScaleW(50)) textAlignment:NSTextAlignmentRight];
    }
    return _zichanUnitLabel;
}

-(UITextField *)zichanTextField
{
    if (nil == _zichanTextField) {
        _zichanTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.duihuanAmmountTitleLabel.right + ScaleW(12), self.zichanAmmountTitleLabel.y, self.duihuanUnitLabel.x - self.duihuanAmmountTitleLabel.right - ScaleW(12), ScaleW(50))];
        _zichanTextField.placeholder = @"0.00";
        _zichanTextField.textColor = kTitleColor;
        _zichanTextField.font = systemFont(ScaleW(14));
//        [_zichanTextField setValue:kSubTitleColor forKeyPath:@"_placeholderLabel.textColor"];
        _zichanTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _zichanTextField.enabled = NO;
    }
    return _zichanTextField;
}


-(void)setCoinModel:(HeBi_ConvertCoin_Model *)coinModel
{
    _coinModel = coinModel;
    self.duihuanUnitLabel.text = coinModel.code;
}

-(void)setConvertModel:(HeBi_ConvertToCoin_Model *)convertModel
{
    _convertModel = convertModel;
    self.zichanUnitLabel.text = convertModel.dealCode;
}


#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.duihuanTextField) {
        return [textField textFieldShouldChangeCharactersInRange:range replacementString:string dotNumber:4];
    }else{
        return YES;
    }
}


-(void)inputChanged:(UITextField *)textField
{
    double ammount = textField.text.doubleValue;
    double zichan = ammount * self.convertModel.exchangeFee.doubleValue;
    
    self.zichanTextField.text = [WLTools noroundingStringWith:zichan afterPointNumber:2];
    
}



// 出去首位0
-(NSString *)deleteFirstZero:(NSString *)string
{
    if (![string hasPrefix:@"0"] || [string isEqualToString:@"0"] || [string hasPrefix:@"0."]) {
        
        return string;
    }else{
        return [self deleteFirstZero:[string substringFromIndex:1]];
    }
}


- (NSString *)ammount
{
    return self.duihuanTextField.text;
}


-(void)clearView
{
    self.duihuanTextField.text = nil;
    self.zichanTextField.text = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
