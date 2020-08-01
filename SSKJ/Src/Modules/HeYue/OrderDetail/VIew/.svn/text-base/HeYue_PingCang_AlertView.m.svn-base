//
//  HeYue_PingCang_AlertView.m
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/3/28.
//  Copyright © 2019 Wang. All rights reserved.
//

#import "HeYue_PingCang_AlertView.h"

@interface HeYue_PingCang_AlertView()<UITextFieldDelegate>

@property (nonatomic,strong) UIView *alertView;

@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UILabel * typeTitle;

@property (nonatomic,strong) UILabel * typelabel;

@property (nonatomic,strong) UILabel * buyPriceTitle;

@property (nonatomic,strong) UILabel * buyPriceLabel;

@property (nonatomic,strong) UILabel * nowPriceTitle;

@property (nonatomic,strong) UILabel * nowPriceLabel;

//@property (nonatomic, strong) UILabel *warningLabel;

@property (nonatomic,strong) UIView * numberBgView;

@property (nonatomic,strong) UILabel * numberTitle;

@property (nonatomic,strong) UITextField * numberTextField;
//
//@property (nonatomic,strong) UIButton * jiaBtn;
//
//@property (nonatomic,strong) UIButton * jianBtn;
//
//@property (nonatomic,strong) UIView *lineView;

@property (nonatomic,strong) UIButton * cancelBtn;

@property (nonatomic,strong) UIButton * sureBtn;

@property (nonatomic,assign) NSInteger number;//持仓量

@property (nonatomic,assign) NSInteger chicangNum;

@property (nonatomic,strong) NSDictionary *dic1;//数据

@property (nonatomic,strong) Heyue_OrderDdetail_Model *model;


@end

@implementation HeYue_PingCang_AlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.frame = [UIScreen mainScreen].bounds;
        // 修改蒙版颜色
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        
        [self alertView];
        
        [self titleLabel];
        
        [self typeTitle];
        
        [self typelabel];
        
        
        [self buyPriceTitle];
               
        [self buyPriceLabel];
        
        [self nowPriceTitle];
        
        [self nowPriceLabel];
        
//        [self warningLabel];

        
        [self numberBgView];

        [self numberTitle];
//
//        [self jiaBtn];
//
//        [self lineView];
//
//        [self jianBtn];
//
        [self numberTextField];
        
        [self cancelBtn];
        
        [self sureBtn];
        
    }
    return self;
}

- (UIView *)alertView
{
    if (_alertView == nil) {
        
        _alertView = [FactoryUI createViewWithFrame:CGRectZero Color:kSubBgColor];
        
        _alertView.layer.masksToBounds = YES;
        
        _alertView.layer.cornerRadius = ScaleW(10);
        
        [self addSubview:_alertView];
        
        [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.mas_centerY).offset(-50);
            
            make.left.equalTo(@(ScaleW(15)));
            
            make.right.equalTo(@(ScaleW(-15)));
                        
        }];
        
    }
    return _alertView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        
        _titleLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"平仓确认", nil) textColor:kTitleColor font:systemFont(16)];
        
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        _titleLabel.hidden = YES;
        [self.alertView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@(ScaleW(15)));
            
            make.right.equalTo(@(-5));
            
            make.top.equalTo(@(ScaleW(25)));
            
            make.height.equalTo(@(ScaleW(15)));
            
        }];
    }
    return _titleLabel;
}

- (UILabel *)typeTitle
{
    if (_typeTitle == nil) {
        
        _typeTitle = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"方向", nil) textColor:kSubTitleColor font:systemFont(15)];
        
        _typeTitle.adjustsFontSizeToFitWidth = YES;
        
        _typeTitle.textAlignment = NSTextAlignmentCenter;
        
        [self.alertView addSubview:_typeTitle];
        
        [_typeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@(0));
            
            make.top.equalTo(self.titleLabel.mas_bottom).offset(ScaleW(20));
        
//            make.width.equalTo(@(ScaleW(40)));
                        
            make.height.equalTo(@(ScaleW(15)));
            
        }];
    }
    return _typeTitle;
}

- (UILabel *)typelabel
{
    if (_typelabel == nil) {
        
        _typelabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"做多", nil) textColor:GREEN_HEX_COLOR font:systemFont(15)];
        
        _typelabel.adjustsFontSizeToFitWidth = YES;
        
        _typelabel.textAlignment = NSTextAlignmentCenter;
        
        [self.alertView addSubview:_typelabel];
        
        [_typelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.typeTitle.mas_left);
            
            make.top.equalTo(self.typeTitle.mas_bottom).offset(ScaleW(15));
            
            make.width.equalTo(self.typeTitle.mas_width);
            
            make.height.equalTo(@(ScaleW(15)));
            
        }];
    }
    return _typelabel;
}

- (UILabel *)buyPriceTitle
{
    if (_buyPriceTitle == nil) {
        
        _buyPriceTitle = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"持仓量", nil) textColor:kSubTitleColor font:systemFont(15)];
        
        _buyPriceTitle.adjustsFontSizeToFitWidth = YES;
        
        _buyPriceTitle.textAlignment = NSTextAlignmentCenter;
        
        [self.alertView addSubview:_buyPriceTitle];
        
        [_buyPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.typeTitle.mas_right);
            
            make.top.equalTo(self.typeTitle.mas_top);
        
            make.width.equalTo(self.typeTitle.mas_width);
                        
            make.height.equalTo(@(ScaleW(15)));
            
        }];
    }
    return _buyPriceTitle;
}

- (UILabel *)buyPriceLabel
{
    if (_buyPriceLabel == nil) {
        
        _buyPriceLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"做多", nil) textColor:kTitleColor font:systemFont(15)];
        
        _buyPriceLabel.adjustsFontSizeToFitWidth = YES;
        
        _buyPriceLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.alertView addSubview:_buyPriceLabel];
        
        [_buyPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.buyPriceTitle.mas_left);
            
            make.top.equalTo(self.buyPriceTitle.mas_bottom).offset(ScaleW(15));
            
            make.width.equalTo(self.typeTitle.mas_width);
            
            make.height.equalTo(@(ScaleW(15)));
            
        }];
    }
    return _buyPriceLabel;
}

- (UILabel *)nowPriceTitle
{
    if (_nowPriceTitle == nil) {
        
        _nowPriceTitle = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"最新价", nil) textColor:kSubTitleColor font:systemFont(15)];
        
        _nowPriceTitle.adjustsFontSizeToFitWidth = YES;
        
        _nowPriceTitle.textAlignment = NSTextAlignmentCenter;
        
        [self.alertView addSubview:_nowPriceTitle];
        
        [_nowPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.buyPriceTitle.mas_right);
                
            make.top.equalTo(self.typeTitle.mas_top);
        
            make.width.equalTo(self.typeTitle.mas_width);
            
            make.right.equalTo(@(0));
                        
            make.height.equalTo(@(ScaleW(15)));
            
        }];
    }
    return _nowPriceTitle;
}

- (UILabel *)nowPriceLabel
{
    if (_nowPriceLabel == nil) {
        
        _nowPriceLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"", nil) textColor:kTitleColor font:systemFont(15)];
        
        _nowPriceLabel.adjustsFontSizeToFitWidth = YES;
        
        _nowPriceLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.alertView addSubview:_nowPriceLabel];
        
        [_nowPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.nowPriceTitle.mas_left);
            
            make.top.equalTo(self.nowPriceTitle.mas_bottom).offset(ScaleW(15));
            
            make.width.equalTo(self.nowPriceTitle.mas_width);
            
            make.height.equalTo(@(ScaleW(15)));
            
        }];
    }
    return _nowPriceLabel;
}

//- (UILabel *)warningLabel
//{
//    if (_warningLabel == nil) {
//
//        _warningLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"是否要确认平仓？", nil) textColor:kTitleColor font:systemBoldFont(15)];
//
//        _warningLabel.adjustsFontSizeToFitWidth = YES;
//
//        _warningLabel.textAlignment = NSTextAlignmentCenter;
//
//        [self.alertView addSubview:_warningLabel];
//
//        [_warningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.left.equalTo(@(15));
//
//            make.top.equalTo(self.typelabel.mas_bottom).offset(ScaleW(30));
//
//            make.right.equalTo(self.alertView.mas_right).offset(ScaleW(-15));
//        }];
//    }
//    return _warningLabel;
//}

- (UIView *)numberBgView
{
    if (_numberBgView == nil) {

        _numberBgView = [FactoryUI createViewWithFrame:CGRectZero Color:kSubBgColor];

        _numberBgView.layer.masksToBounds = YES;

        _numberBgView.layer.cornerRadius = ScaleW(4);
        
        _numberBgView.layer.borderWidth = 0.5;
        
        _numberBgView.layer.borderColor = kLineColor.CGColor;

        [self.alertView addSubview:_numberBgView];

        [_numberBgView mas_makeConstraints:^(MASConstraintMaker *make) {

            make.top.equalTo(self.typelabel.mas_bottom).offset(ScaleW(20));

            make.left.equalTo(@(ScaleW(15)));

            make.right.equalTo(@(ScaleW(-15)));

            make.height.equalTo(@(ScaleW(40)));

        }];

    }
    return _numberBgView;
}

- (UILabel *)numberTitle
{
    if (_numberTitle == nil) {

        _numberTitle = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"平仓张数", nil) textColor:kTitleColor font:systemFont(15)];

        _numberTitle.adjustsFontSizeToFitWidth = YES;

        _numberTitle.textAlignment = NSTextAlignmentLeft;

        [self.numberBgView addSubview:_numberTitle];

        [_numberTitle mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(self.numberBgView.mas_left).offset(ScaleW(15));

            make.top.bottom.equalTo(@0);

            make.width.equalTo(@(ScaleW(60)));

        }];
    }
    return _numberTitle;
}
//
//- (UIButton *)jiaBtn
//{
//    if (_jiaBtn == nil) {
//
//        _jiaBtn = [FactoryUI createButtonWithFrame:CGRectZero title:@"+" titleColor:MainTextColor imageName:nil backgroundImageName:nil target:self selector:@selector(jiaBtnAction) font:ScaleBoldFontSize(15)];
//
//        [self.numberBgView addSubview:_jiaBtn];
//
//        [_jiaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.top.bottom.equalTo(@0);
//
//            make.right.equalTo(self.numberBgView.mas_right);
//
//            make.width.equalTo(@(ScaleW(40)));
//
//        }];
//    }
//    return _jiaBtn;
//}
//
//- (UIView *)lineView
//{
//    if (_lineView == nil) {
//
//        _lineView = [FactoryUI createViewWithFrame:CGRectZero Color:UIColorFromRGB(0x6b717e)];
//
//        [self.numberBgView addSubview:_lineView];
//
//        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.centerY.equalTo(self.numberBgView.mas_centerY);
//
//            make.right.equalTo(self.jiaBtn.mas_left);
//
//            make.height.equalTo(@(ScaleW(13)));
//
//            make.width.equalTo(@(ScaleW(1)));
//
//        }];
//
//    }
//    return _lineView;
//}
//
//- (UIButton *)jianBtn
//{
//    if (_jianBtn == nil) {
//
//        _jianBtn = [FactoryUI createButtonWithFrame:CGRectZero title:@"-" titleColor:MainTextColor imageName:nil backgroundImageName:nil target:self selector:@selector(jianBtnAction) font:ScaleBoldFontSize(25)];
//
//        [self.numberBgView addSubview:_jianBtn];
//
//        [_jianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.top.bottom.equalTo(@0);
//
//            make.right.equalTo(self.lineView.mas_left);
//
//            make.width.equalTo(@(ScaleW(40)));
//
//        }];
//    }
//    return _jianBtn;
//}
//
- (UITextField *)numberTextField
{
    if (_numberTextField == nil) {

        _numberTextField = [FactoryUI createTextFieldWithFrame:CGRectZero text:@"" placeHolder:SSKJLocalized(@"请输入平仓张数", nil)];

        [WLTools textField:_numberTextField setPlaceHolder:SSKJLocalized(@"请输入平仓张数", nil) color:kTitleColor];


        _numberTextField.backgroundColor = [UIColor clearColor];

        _numberTextField.font = systemFont(15);

        _numberTextField.keyboardType = UIKeyboardTypeNumberPad;

        _numberTextField.textColor = kTitleColor;

//        [_numberTextField addTarget:self action:@selector(textFiedValueChanged:) forControlEvents:(UIControlEventEditingChanged)];

        [self.numberBgView addSubview:_numberTextField];

        [_numberTextField mas_makeConstraints:^(MASConstraintMaker *make) {

            make.top.bottom.equalTo(@0);

            make.right.equalTo(self.numberBgView.mas_right);

            make.left.equalTo(self.numberTitle.mas_right).offset(ScaleW(20));
        }];
    }
    return _numberTextField;
}

- (UIButton *)cancelBtn
{
    if (_cancelBtn == nil) {
        
        _cancelBtn = [FactoryUI createButtonWithFrame:CGRectZero title:SSKJLocalized(@"取消", nil) titleColor:kBlueColor imageName:nil backgroundImageName:nil target:self selector:@selector(cancelBtnAction) font:systemBoldFont(15)];
        
        _cancelBtn.layer.cornerRadius = ScaleW(3);
        
        _cancelBtn.layer.borderWidth = 1;

        _cancelBtn.layer.borderColor = kBlueColor.CGColor;
                
        [self.alertView addSubview:_cancelBtn];
        
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@(ScaleW(15)));
            
            make.top.equalTo(self.numberBgView.mas_bottom).offset(ScaleW(35));
            
            make.height.equalTo(@(ScaleW(40)));
            
            make.width.equalTo(@(ScaleW(ScreenWidth / 2 - ScaleW(50))));
            
            make.bottom.equalTo(self.alertView.mas_bottom).offset(ScaleW(-20));
            
        }];
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn
{
    if (_sureBtn == nil) {
        
        _sureBtn = [FactoryUI createButtonWithFrame:CGRectZero title:SSKJLocalized(@"确认", nil) titleColor:kTitleColor imageName:nil backgroundImageName:nil target:self selector:@selector(sureBtnAction) font:systemBoldFont(15)];
        
        _sureBtn.backgroundColor = kBlueColor;
        
        _sureBtn.layer.cornerRadius = ScaleW(3);
        
        _sureBtn.layer.masksToBounds = YES;
        
        [self.alertView addSubview:_sureBtn];
        
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(@(ScaleW(-15)));
            
            make.top.equalTo(self.cancelBtn);
            
            make.height.equalTo(@(ScaleW(40)));
            
            make.width.equalTo(@(ScaleW(ScreenWidth / 2 - ScaleW(50))));
            
        }];
    }
    return _sureBtn;
}


- (void)cancelBtnAction
{
    self.numberTextField.text = nil;
    [self removeFromSuperview];
}

- (void)sureBtnAction
{
    
    if (_numberTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入平仓张数", nil)];
        return;
    }
    
    if (_numberTextField.text.integerValue > self.model.sheets.doubleValue) {
        [MBProgressHUD showError:SSKJLocalized(@"可平数量不足", nil)];
        return;
    }
    
    
    if (self.PingCangBlock) {
        self.PingCangBlock(self.numberTextField.text);
    }
    [self cancelBtnAction];

}

#pragma mark - 弹出 -
- (void)showAlertView
{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self creatShowAnimation];
}

- (void)creatShowAnimation
{
    self.alertView.layer.position = self.center;
    self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
    }];
}


- (void)initDataWithDic:(Heyue_OrderDdetail_Model *)model
{
    self.model = model;

    NSString *type = model.otype;
    self.typelabel.text = [NSString stringWithFormat:@"%@",type.integerValue == 1?SSKJLocalized(@"做多", nil):SSKJLocalized(@"做空", nil)];
    self.typelabel.textColor = type.integerValue == 1?GREEN_HEX_COLOR:RED_HEX_COLOR;
    
    self.buyPriceLabel.text = [[WLTools noroundingStringWith:model.sheets.doubleValue afterPointNumber:4]stringByAppendingString:SSKJLocalized(@"张", nil)];
    
    self.nowPriceLabel.text =[WLTools noroundingStringWith:model.marketPrice.doubleValue afterPointNumber:[SSTool MarketPrice:model.code]];
    
    self.number = [model.buynum doubleValue];

    self.chicangNum = [model.buynum doubleValue];

}

-(void)setMarketPriceView:(NSString *)price
{
    self.model.marketPrice = price;
    self.nowPriceLabel.text =[WLTools noroundingStringWith:self.model.marketPrice.doubleValue afterPointNumber:[SSTool MarketPrice:self.model.code]];
}


@end
