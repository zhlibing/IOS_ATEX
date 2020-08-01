//
//  Heyue_TittlePrice_View.m
//  SSKJ
//
//  Created by zpz on 2019/9/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_TitlePrice_View.h"
@interface Heyue_TitlePrice_View()

@property(nonatomic, copy)NSString *title;

@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UITextField *field;

@end

@implementation Heyue_TitlePrice_View

- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self) {
        self.title = title;
        
        self.layer.borderWidth = ScaleW(0.5);
        self.layer.borderColor = kLineColor.CGColor;
        self.layer.cornerRadius = ScaleW(5);
        self.layer.masksToBounds = YES;
        
        [self setUI];
    }
    return self;
}

- (void)setUI{
    self.titleLabel = [UILabel createWithText:_title textColor:kSubTitleColor font:kFont(14)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(ScaleW(5)));
        make.centerY.equalTo(@0);
        make.width.equalTo(@(ScaleW(60)));
    }];
    
    self.field = [UITextField createWithTextColor:kTitleColor font:kFont(14) placeholder:SSKJLanguage(@"请输入") placeholderColor:kSubTitleColor];
    self.field.keyboardType = UIKeyboardTypeDecimalPad;
    [self addSubview:self.field];
    [self.field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(ScaleW(5));
        make.right.equalTo(@(ScaleW(-5)));
        make.centerY.equalTo(@0);
    }];
    
    
}

- (NSString *)value{
    return self.field.text;
}
@end
