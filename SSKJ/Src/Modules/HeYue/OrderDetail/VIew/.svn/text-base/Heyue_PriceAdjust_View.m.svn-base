//
//  Heyue_PriceAdjust_View.m
//  SSKJ
//
//  Created by zpz on 2019/9/18.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_PriceAdjust_View.h"

@interface Heyue_PriceAdjust_View()<UITextFieldDelegate>

@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UIButton *addBtn;
@property(nonatomic, strong)UIButton *subBtn;

@property(nonatomic, copy)NSString *title;

@end

@implementation Heyue_PriceAdjust_View

- (instancetype)initWithTitle:(NSString *)title{
    
    if (self == [super init]) {
        self.title = title;
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = ScaleW(5);
        self.layer.borderColor = kLineColor.CGColor;
        self.layer.borderWidth = 1;
//        self.backgroundColor = kGrayColor;

        [self setupUI];
    }
    return self;
}


- (void)setupUI{
    
    self.titleLabel = [WLTools allocLabel:self.title font:kFont(14) textColor:kTitleColor frame:CGRectZero textAlignment:(NSTextAlignmentCenter)];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ScaleW(5));
        make.width.mas_equalTo(ScaleW(70));
        make.centerY.equalTo(@0);
    }];
    
//    self.addBtn = [WLTools allocButton:@"+" textColor:kSubTitleColor nom_bg:nil hei_bg:nil frame:CGRectZero];
//    self.addBtn.titleLabel.font = kFont(16);
//    [self addSubview:self.addBtn];
//    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.right.equalTo(@0);
//        make.width.mas_equalTo(ScaleW(33));
//    }];
//
//    self.subBtn = [WLTools allocButton:@"-" textColor:kSubTitleColor nom_bg:nil hei_bg:nil frame:CGRectZero];
//    self.subBtn.titleLabel.font = kFont(16);
//    [self addSubview:self.subBtn];
//    [self.subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(@0);
//        make.right.equalTo(self.addBtn.mas_left);
//        make.width.equalTo(self.addBtn);
//    }];

//    UIView *line = [UIView new];
//    line.backgroundColor = kLineColor;
//    [self addSubview:line];
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.subBtn.mas_left);
//        make.centerY.equalTo(@0);
//        make.height.mas_equalTo(ScaleW(20));
//        make.width.mas_equalTo(ScaleW(1));
//    }];
    
    self.field = [UITextField new];
    self.field.font = kFont(15);
    self.field.textColor = kTitleColor;
    self.field.placeholder = SSKJLanguage(@"请输入");
    self.field.keyboardType = UIKeyboardTypeDecimalPad;
    [self addSubview:self.field];
    [self.field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.left.equalTo(self.titleLabel.mas_right).offset(ScaleW(5));
//        make.right.equalTo(line.mas_left).offset(ScaleW(-5));
        
        make.right.equalTo(@(ScaleW(-15)));

    }];
    
    [self.addBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [self.subBtn addTarget:self action:@selector(subAction) forControlEvents:UIControlEventTouchUpInside];

    self.field.delegate = self;
}

- (void)setIsZhiYing:(BOOL)isZhiYing{
    self.field.placeholder = isZhiYing ? SSKJLanguage(@"请设置止盈价格") : SSKJLanguage(@"请设置止损价格");
    [self.field setPlaceHolderColor:kSubTitleColor];
}

- (void)addAction{
    
    
    NSString *str = [NSString stringWithFormat:@"%.10f", [self.field.text doubleValue] + self.dianwei.doubleValue];

    if ([str doubleValue] < 0) {
        self.field.text = @"0";
    }else{
        self.field.text = [SSTool HeyueCoin:_coin price:str];
    }
    
}

- (void)subAction{
 
    NSString *str = [NSString stringWithFormat:@"%.10f", [self.field.text doubleValue] - self.dianwei.doubleValue];
    if ([str doubleValue] < 0) {
        self.field.text = @"0";
    }else{
        self.field.text = [SSTool HeyueCoin:_coin price:str];
    }}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    
    //新输入的
    if (string.length == 0) {
        return YES;
    }

    NSString *checkStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    
    //正则表达式（只支持n位小数）
    NSString *regex = [NSString stringWithFormat:@"^\\-?([1-9]\\d*|0)(\\.\\d{0,%zd})?$",[SSTool HeyuePname:_coin]];
    
    //判断新的文本内容是否符合要求
    return [self isValid:checkStr withRegex:regex];
    
    return YES;
}

//检测改变过的文本是否匹配正则表达式，如果匹配表示可以键入，否则不能键入
- (BOOL) isValid:(NSString*)checkStr withRegex:(NSString*)regex
{
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicte evaluateWithObject:checkStr];
}



@end
