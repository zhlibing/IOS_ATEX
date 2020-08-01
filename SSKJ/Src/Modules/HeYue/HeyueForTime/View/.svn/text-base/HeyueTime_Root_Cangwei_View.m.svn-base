//
//  HeyueTime_Root_Cangwei_View.h
//  SSKJ
//
//  Created by cy5566 on 2020/3/21.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "HeyueTime_Root_Cangwei_View.h"

@interface HeyueTime_Root_Cangwei_View()

@property (nonatomic,strong) UILabel *numberTitle;
@property (nonatomic,strong) UILabel *countTitle;//数量
@end

@implementation HeyueTime_Root_Cangwei_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBgColor;
        self.layer.borderColor = kLineColor.CGColor;

        self.layer.borderWidth = .5f;
        self.cornerRadius = ScaleW(4);
        [self addSubview:self.numberTitle];
        [self addSubview:self.countTitle];
        [self addSubview:self.numberTextField];
    }
    return self;
}

- (UITextField *)numberTextField{
    if (_numberTextField == nil) {
        _numberTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(55), 0, self.width - ScaleW(100), ScaleW(40))];
        _numberTextField.textColor = kTitleColor;
        _numberTextField.centerY = self.countTitle.centerY;
        [WLTools textField:_numberTextField setPlaceHolder:[NSString stringWithFormat:SSKJLocalized(@"1张=%@%@", nil),@"",@""] color:kSubTitleColor];
        _numberTextField.font = systemFont(ScaleW(12));
        if (kHeYue_ZhangShu > 0) {
                    _numberTextField.keyboardType = UIKeyboardTypeDecimalPad;

        }else{
            _numberTextField.keyboardType = UIKeyboardTypeNumberPad;
        }
        
    }
    return _numberTextField;
}

- (UILabel *)countTitle{
    if (_countTitle == nil) {
        _countTitle= [WLTools allocLabel:SSKJLocalized(@"保证金", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(2), 0, ScaleW(50), ScaleW(40)) textAlignment:NSTextAlignmentCenter];
        _countTitle.adjustsFontSizeToFitWidth = YES;
        _countTitle.numberOfLines = 1;
        
    }
    return _countTitle;
}

- (UILabel *)numberTitle{
    if (_numberTitle == nil) {
        _numberTitle = [WLTools allocLabel:SSKJLocalized(@"张", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectMake(self.width - ScaleW(40), 0, ScaleW(40), ScaleW(40)) textAlignment:NSTextAlignmentCenter];
        _numberTitle.adjustsFontSizeToFitWidth = YES;
        _numberTitle.numberOfLines = 1;
    }
    return _numberTitle;
}


@end
