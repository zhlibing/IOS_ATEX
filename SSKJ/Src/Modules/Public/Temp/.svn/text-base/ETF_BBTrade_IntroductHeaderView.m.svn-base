
//
//  ETF_BBTrade_IntroductHeaderView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/8.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "ETF_BBTrade_IntroductHeaderView.h"

@interface ETF_BBTrade_IntroductHeaderView ()
@property (nonatomic, strong) UIButton *dealButton;     // 成交
@property (nonatomic, strong) UIButton *deepButton; // 深度
@property (nonatomic, strong) UIButton *introductButton;    // 简介
@property (nonatomic, strong) UIView *segmentLineView;
@property (nonatomic, strong) UIView *lineView;

//成交左边竖线
@property (nonatomic, strong) UIView *leftView;
//成交右边竖线
@property (nonatomic, strong) UIView *rightView;

@end

@implementation ETF_BBTrade_IntroductHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBgColor;
        [self addSubview:self.dealButton];
        [self addSubview:self.deepButton];
        [self addSubview:self.introductButton];
        [self addSubview:self.segmentLineView];
        [self addSubview:self.lineView];
        [self addSubview:self.leftView];
        [self addSubview:self.rightView];
    }
    return self;
}

- (UIView *)leftView {
    if (nil == _leftView) {
        _leftView = [[UIView alloc] initWithFrame:CGRectMake(_deepButton.right, (self.height - ScaleW(20))/2, ScaleW(1), ScaleW(20))];
        _leftView.backgroundColor = kLineColor;
    }
    return _leftView;
}

- (UIView *)rightView {
    if (nil == _rightView) {
        _rightView = [[UIView alloc] initWithFrame:CGRectMake(_dealButton.right, (self.height - ScaleW(20))/2, ScaleW(1), ScaleW(20))];
        _rightView.backgroundColor = kLineColor;
    }
    return _rightView;
}

-(UIButton *)deepButton
{
    if (nil == _deepButton) {
        _deepButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.width / 3, self.height)];
        [_deepButton setTitle:SSKJLocalized(@"深度", nil) forState:UIControlStateNormal];
        [_deepButton setTitleColor:kSubTitleColor forState:UIControlStateNormal];
        [_deepButton setTitleColor:kBlueColor forState:UIControlStateSelected];
        _deepButton.titleLabel.font = systemFont(ScaleW(15));
        _deepButton.selected = YES;
        [_deepButton addTarget:self action:@selector(deepEvent) forControlEvents:UIControlEventTouchUpInside];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(_deepButton.width, 0, 0.5, ScaleW(20))];
        lineView.centerY = _deepButton.height / 2;
        lineView.backgroundColor = kBgColor;
        [_deepButton addSubview:lineView];
    }
    return _deepButton;
}


-(UIButton *)dealButton
{
    if (nil == _dealButton) {
        _dealButton = [[UIButton alloc]initWithFrame:CGRectMake(self.deepButton.right, 0, self.width / 3, self.height)];
        [_dealButton setTitle:SSKJLocalized(@"成交", nil) forState:UIControlStateNormal];
        [_dealButton setTitleColor:kSubTitleColor forState:UIControlStateNormal];
        [_dealButton setTitleColor:kBlueColor forState:UIControlStateSelected];
        _dealButton.titleLabel.font = systemFont(ScaleW(15));
        _dealButton.selected = NO;
        [_dealButton addTarget:self action:@selector(dealEvent) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(_dealButton.width, 0, 0.5, ScaleW(20))];
        lineView.centerY = _dealButton.height / 2;
        lineView.backgroundColor = kBgColor;
        [_dealButton addSubview:lineView];
    }
    return _dealButton;
}




-(UIButton *)introductButton
{
    if (nil == _introductButton) {
        _introductButton = [[UIButton alloc]initWithFrame:CGRectMake(self.dealButton.right, 0, self.width / 3, self.height)];
        [_introductButton setTitle:SSKJLocalized(@"简介", nil) forState:UIControlStateNormal];
        [_introductButton setTitleColor:kSubTitleColor forState:UIControlStateNormal];
        [_introductButton setTitleColor:kBlueColor forState:UIControlStateSelected];
        _introductButton.titleLabel.font = systemFont(ScaleW(15));
        _introductButton.selected = NO;
        [_introductButton addTarget:self action:@selector(introductEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _introductButton;
}

-(UIView *)segmentLineView
{
    if (nil == _segmentLineView) {
        _segmentLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 2, ScaleW(30), 2)];
        _segmentLineView.backgroundColor = kBlueColor;
        _segmentLineView.centerX = self.deepButton.centerX;
    }
    return _segmentLineView;
}


-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
        _lineView.backgroundColor = kLineColor;
    }
    return _lineView;
}


-(void)dealEvent
{
    self.dealButton.selected = YES;
    self.deepButton.selected = NO;
    self.introductButton.selected = NO;
    self.segmentLineView.centerX = self.dealButton.centerX;
    self.selectedIndex = 1;
    if (self.segmentSelectBlock) {
        self.segmentSelectBlock(1);
    }
}

-(void)deepEvent
{
    self.deepButton.selected = YES;
    self.dealButton.selected = NO;
    self.introductButton.selected = NO;
    self.segmentLineView.centerX = self.deepButton.centerX;
    self.selectedIndex = 0;
    if (self.segmentSelectBlock) {
        self.segmentSelectBlock(0);
    }
}

-(void)introductEvent
{
    self.introductButton.selected = YES;
    self.dealButton.selected = NO;
    self.deepButton.selected = NO;

    self.segmentLineView.centerX = self.introductButton.centerX;
    self.selectedIndex = 2;

    if (self.segmentSelectBlock) {
        self.segmentSelectBlock(2);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)changeUI
{
//    _orderLabel.hidden = YES;
    _lineView.hidden = YES;
    
    
    _segmentLineView.hidden = NO;
    _dealButton.hidden = NO;
    _introductButton.hidden = NO;
//    _depthButton.hidden = NO;
    
}
@end
