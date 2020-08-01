//
//  Login_Type_Option.m
//  SSKJ
//
//  Created by zpz on 2019/12/2.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Login_Type_Option.h"

@interface Login_Type_Option()
@property(nonatomic, strong)NSArray *array;

@property(nonatomic, strong)UIView *lineView;

@end


@implementation Login_Type_Option

- (instancetype)initWithTitles:(NSArray *)array{
    if (self = [super init]) {
        self.array = array;
        [self setupUI];
    }
    return self;
}


- (void)setupUI{
    
    UIButton *btn = [UIButton createWithTitle:self.array.firstObject titleColor:kSubTitleColor font:kBoldFont(16) target:self action:@selector(btn1Click:)];
    btn.tag = 1000;
    [btn setTitleColor:kBlueColor forState:UIControlStateSelected];
    [self addSubview:btn];
    btn.selected = YES;
    
    UIButton *btn2 = [UIButton createWithTitle:self.array.lastObject titleColor:kSubTitleColor font:kBoldFont(14) target:self action:@selector(btn2Click:)];
    btn2.tag = 1001;
    [btn2 setTitleColor:kBlueColor forState:UIControlStateSelected];
    [self addSubview:btn2];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(@0);
//        make.width.equalTo(@(ScaleW(90)));
    }];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(@0);
        make.width.equalTo(btn.mas_width);
        make.left.equalTo(btn.mas_right).offset(ScaleW(15));
    }];
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = kBlueColor;
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btn);
        make.bottom.equalTo(btn);
        make.size.equalTo(@(CGSizeMake(ScaleW(25), ScaleW(2))));
    }];
}

- (void)btn1Click:(UIButton *)sender{
    if (sender.selected) {
        return;
    }
    sender.selected = YES;
    sender.titleLabel.font = kBoldFont(16);
    
    UIButton *btn = [self viewWithTag:1001];
    btn.selected = NO;
    btn.titleLabel.font = kBoldFont(14);
    
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(sender);
        make.bottom.equalTo(sender);
        make.size.equalTo(@(CGSizeMake(ScaleW(25), ScaleW(2))));
    }];
    if (self.selectBlock) {
        self.selectBlock(YES);
    }
}


- (void)btn2Click:(UIButton *)sender{
    if (sender.selected) {
        return;
    }
    
    sender.selected = YES;
    sender.titleLabel.font = kBoldFont(16);
    
    UIButton *btn = [self viewWithTag:1000];
    btn.selected = NO;
    btn.titleLabel.font = kBoldFont(14);
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(sender);
        make.bottom.equalTo(sender);
        make.size.equalTo(@(CGSizeMake(ScaleW(25), ScaleW(2))));
    }];
    
    if (self.selectBlock) {
        self.selectBlock(NO);
    }
    
}

@end
