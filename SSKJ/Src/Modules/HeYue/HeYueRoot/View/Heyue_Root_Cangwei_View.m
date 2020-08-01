//
//  Heyue_Root_Cangwei_View.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/26.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_Root_Cangwei_View.h"

@interface Heyue_Root_Cangwei_View()


@property (nonatomic,strong) UILabel *countTitle;//数量
@end

@implementation Heyue_Root_Cangwei_View

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
        self.numberTextField.adjustsFontSizeToFitWidth = YES;
        
//        [self.countTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.mas_left).offset(ScaleW(8));
//            make.centerY.equalTo(self.numberTextField);
//        }];
    }
    return self;
}

- (UITextField *)numberTextField{
    if (_numberTextField == nil) {
        _numberTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(55), 0, self.width - ScaleW(80), ScaleW(40))];
        _numberTextField.textColor = kTitleColor;
        _numberTextField.centerY = self.countTitle.centerY;
        [WLTools textField:_numberTextField setPlaceHolder:[NSString stringWithFormat:SSKJLocalized(@"1张=%@%@", nil),@"",@""] color:kSubTitleColor];
        _numberTextField.font = systemFont(ScaleW(12));
        _numberTextField.adjustsFontSizeToFitWidth = YES;
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
        _countTitle= [WLTools allocLabel:SSKJLocalized(@"数量", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(2), 0, ScaleW(50), ScaleW(40)) textAlignment:NSTextAlignmentCenter];
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

- (void)setArray:(NSArray *)array{
    UIButton *button1 = (UIButton *)[self viewWithTag:1000];
    UIButton *button2 = (UIButton *)[self viewWithTag:1001];
    UIButton *button3 = (UIButton *)[self viewWithTag:1002];
    UIButton *button4 = (UIButton *)[self viewWithTag:1003];
    [button1 removeFromSuperview];
    [button2 removeFromSuperview];
    [button3 removeFromSuperview];
    [button4 removeFromSuperview];
    
    for (int i=0; i<array.count; i++) {
        UIButton *button = [WLTools allocButton:array[i] textColor:kSubTitleColor nom_bg:nil hei_bg:nil frame:CGRectMake(i * self.width/4, ScaleW(40), self.width / 4, self.height - ScaleW(40))];
        button.layer.borderColor = kLineColor.CGColor;
        button.layer.borderWidth = ScaleW(.5f);
        button.titleLabel.font = systemFont(ScaleW(11));
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1000 + i;
        button.backgroundColor = [UIColor clearColor];
        [self addSubview:button];
    }
}

- (void)buttonAction:(UIButton *)sender{
    
    
    
    UIButton *button1 = (UIButton *)[self viewWithTag:1000];
    UIButton *button2 = (UIButton *)[self viewWithTag:1001];
    UIButton *button3 = (UIButton *)[self viewWithTag:1002];
    UIButton *button4 = (UIButton *)[self viewWithTag:1003];
    
    [button1 setTitleColor:kSubTitleColor forState:UIControlStateNormal];
    [button2 setTitleColor:kSubTitleColor forState:UIControlStateNormal];
    [button3 setTitleColor:kSubTitleColor forState:UIControlStateNormal];
    [button4 setTitleColor:kSubTitleColor forState:UIControlStateNormal];
    
    [sender setTitleColor:kWhiteColor forState:UIControlStateNormal];
    
    NSInteger result = [sender.currentTitle stringByReplacingOccurrencesOfString:@"%" withString:@""].integerValue;
    if (self.CangweiBlock) {
        self.CangweiBlock(result);
    }
    
    button1.backgroundColor = [UIColor clearColor];
    button2.backgroundColor = [UIColor clearColor];
    button3.backgroundColor = [UIColor clearColor];
    button4.backgroundColor = [UIColor clearColor];
    if (self.isBuySell == 1) {
            sender.backgroundColor = KgreenColor;
    } else {
        sender.backgroundColor = KRedColor;
    }

//    switch (sender.tag) {
//        case 1000:
//        {
//
//            button1.backgroundColor = kBlueColor;
//            button2.backgroundColor = [UIColor clearColor];
//            button3.backgroundColor = [UIColor clearColor];
//            button4.backgroundColor = [UIColor clearColor];
////            if (self.CangweiBlock) {
////                self.CangweiBlock(25);
////            }
//        }
//            break;
//        case 1001:
//        {
//            button1.backgroundColor = [UIColor clearColor];
//            button2.backgroundColor = kBlueColor;
//            button3.backgroundColor = [UIColor clearColor];
//            button4.backgroundColor = [UIColor clearColor];
//
////            if (self.CangweiBlock) {
////                self.CangweiBlock(50);
////            }
//        }
//            break;
//        case 1002:
//        {
//            button1.backgroundColor = [UIColor clearColor];
//            button2.backgroundColor = [UIColor clearColor];
//            button3.backgroundColor = kBlueColor;
//            button4.backgroundColor = [UIColor clearColor];
//
////            if (self.CangweiBlock) {
////                self.CangweiBlock(75);
////            }
//        }
//            break;
//        case 1003:
//        {
//            button1.backgroundColor = [UIColor clearColor];
//            button2.backgroundColor = [UIColor clearColor];
//            button3.backgroundColor = [UIColor clearColor];
//            button4.backgroundColor = kBlueColor;
//
////            if (self.CangweiBlock) {
////                self.CangweiBlock(100);
////            }
//        }
//            break;
//
//        default:
//            break;
//    }
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
