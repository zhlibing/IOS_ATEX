//
//  AddressManager_HeaderView.m
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/15.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "AddressManager_HeaderView.h"

@interface AddressManager_HeaderView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *omniButton;
@property (nonatomic, strong) UIButton *ercButton;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation AddressManager_HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBgColor;
        [self addSubview:self.backView];
        [self.backView addSubview:self.omniButton];
        [self.backView addSubview:self.ercButton];
        [self.backView addSubview:self.lineView];
    }
    return self;
}

- (UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), ScaleW(10), ScreenWidth - ScaleW(30), ScaleW(50))];
        _backView.backgroundColor = kSubBgColor;
        _backView.layer.cornerRadius = ScaleW(5);
    }
    return _backView;
}

-(UIButton *)omniButton
{
    if (nil == _omniButton) {
        _omniButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScaleW(80), self.backView.height)];
        [_omniButton setTitle:@"OMNI" forState:UIControlStateNormal];
        [_omniButton setTitleColor:kTitleColor forState:UIControlStateNormal];
        [_omniButton setTitleColor:kBlueColor forState:UIControlStateSelected];
        _omniButton.selected = YES;
        _omniButton.titleLabel.font = systemFont(ScaleW(15));

        [_omniButton addTarget:self action:@selector(selectEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _omniButton;
}


-(UIButton *)ercButton
{
    if (nil == _ercButton) {
        _ercButton = [[UIButton alloc]initWithFrame:CGRectMake(self.omniButton.right, 0, ScaleW(80), self.backView.height)];
        [_ercButton setTitle:@"ERC20" forState:UIControlStateNormal];
        [_ercButton setTitleColor:kTitleColor forState:UIControlStateNormal];
        [_ercButton setTitleColor:kBlueColor forState:UIControlStateSelected];
        _ercButton.titleLabel.font = systemFont(ScaleW(15));

        [_ercButton addTarget:self action:@selector(selectEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ercButton;
}

-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.backView.height - 1, self.omniButton.width, 1 )];
        _lineView.backgroundColor = kBlueColor;
    }
    return _lineView;
}

-(void)selectEvent:(UIButton *)sender
{
    if (sender.selected) {
        return;
    }
    if (sender == self.omniButton) {
        self.omniButton.selected = YES;
        self.ercButton.selected = NO;
        _walletType = WalletTypeOMNI;
        if (self.changeWalletTypeBlock) {
            self.changeWalletTypeBlock(WalletTypeOMNI);
        }
    }else{
        self.omniButton.selected = NO;
        self.ercButton.selected = YES;
        _walletType = WalletTypeERC20;
        if (self.changeWalletTypeBlock) {
            self.changeWalletTypeBlock(WalletTypeERC20);
        }
    }
    
    
    self.lineView.centerX = sender.centerX;
}

- (void)setWalletType:(WalletType)walletType
{
    _walletType = walletType;
    if (walletType == WalletTypeOMNI) {
        self.omniButton.selected = YES;
        self.ercButton.selected = NO;
        self.lineView.centerX = self.omniButton.centerX;
    }else{
        self.omniButton.selected = NO;
        self.ercButton.selected = YES;
        self.lineView.centerX = self.ercButton.centerX;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
