//
//  HeBi_Convert_TopView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_Convert_TopView.h"

@interface HeBi_Convert_TopView ()
@property (nonatomic, strong) UIView *chiyouBackView;
@property (nonatomic, strong) UILabel *chiyouTitleLabel;        // 持有资产
@property (nonatomic, strong) UILabel *chiyouLabel;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIButton *exchangeButton; // 中间的图片
@property (nonatomic, strong) UIView *duihuanBackView;
@property (nonatomic, strong) UILabel *duihuanTitleLabel;   // 兑换资产
@property (nonatomic, strong) UILabel *duihuanLabel;
@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation HeBi_Convert_TopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

#pragma mark - UI

-(void)setUI
{
    [self addSubview:self.chiyouBackView];
    [self.chiyouBackView addSubview:self.chiyouTitleLabel];
    [self.chiyouBackView addSubview:self.chiyouLabel];
    [self.chiyouBackView addSubview:self.leftImageView];

    [self addSubview:self.exchangeButton];
    
    [self addSubview:self.duihuanBackView];
    [self.duihuanBackView addSubview:self.duihuanTitleLabel];
    [self.duihuanBackView addSubview:self.duihuanLabel];
    [self.duihuanBackView addSubview:self.rightImageView];

}

-(UIView *)chiyouBackView
{
    if (nil == _chiyouBackView) {
        _chiyouBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScaleW(143), self.height)];
        _chiyouBackView.backgroundColor = kSubBgColor;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectCoinEvent)];
        [_chiyouBackView addGestureRecognizer:tap];
    }
    return _chiyouBackView;
}

-(UILabel *)chiyouTitleLabel
{
    if (nil == _chiyouTitleLabel) {
        _chiyouTitleLabel = [WLTools allocLabel:SSKJLocalized(@"持有资产", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(0, ScaleW(15), self.chiyouBackView.width, ScaleW(15)) textAlignment:NSTextAlignmentCenter];
    }
    return _chiyouTitleLabel;
}

-(UILabel *)chiyouLabel
{
    if (nil == _chiyouLabel) {
        _chiyouLabel = [WLTools allocLabel:SSKJLocalized(@"", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(0, self.chiyouTitleLabel.bottom + ScaleW(19), self.chiyouBackView.width, ScaleW(15)) textAlignment:NSTextAlignmentCenter];
    }
    return _chiyouLabel;
}

- (UIImageView *)leftImageView
{
    if (nil == _leftImageView) {
        _leftImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Mine_xiangxia"]];
        _leftImageView.centerY = self.chiyouLabel.centerY;

    }
    return _leftImageView;
}

-(UIButton *)exchangeButton
{
    if (nil == _exchangeButton) {
        _exchangeButton = [[UIButton alloc]initWithFrame:CGRectMake(self.chiyouBackView.right + ScaleW(5), 0, ScaleW(80), self.height)];
        _exchangeButton.backgroundColor = kSubBgColor;
        [_exchangeButton setImage:[UIImage imageNamed:@"Mine_qiehuan"] forState:UIControlStateNormal];
        _exchangeButton.enabled = NO;
    }
    return _exchangeButton;
}


-(UIView *)duihuanBackView
{
    if (nil == _duihuanBackView) {
        _duihuanBackView = [[UIView alloc]initWithFrame:CGRectMake(self.exchangeButton.right + ScaleW(5), 0, ScaleW(143), self.height)];
        _duihuanBackView.backgroundColor = kSubBgColor;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectConvertEvent)];
        [_duihuanBackView addGestureRecognizer:tap];
    }
    return _duihuanBackView;
}

-(UILabel *)duihuanTitleLabel
{
    if (nil == _duihuanTitleLabel) {
        _duihuanTitleLabel = [WLTools allocLabel:SSKJLocalized(@"兑换资产", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(0, ScaleW(15), self.duihuanBackView.width, ScaleW(15)) textAlignment:NSTextAlignmentCenter];
    }
    return _duihuanTitleLabel;
}

-(UILabel *)duihuanLabel
{
    if (nil == _duihuanLabel) {
        _duihuanLabel = [WLTools allocLabel:SSKJLocalized(@"", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(0, self.duihuanTitleLabel.bottom + ScaleW(19), self.duihuanBackView.width, ScaleW(15)) textAlignment:NSTextAlignmentCenter];
    }
    return _duihuanLabel;
}


- (UIImageView *)rightImageView
{
    if (nil == _rightImageView) {
        _rightImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Mine_xiangxia"]];
        _rightImageView.centerY = self.duihuanLabel.centerY;
    }
    return _rightImageView;
}


-(void)setCoinModel:(HeBi_ConvertCoin_Model *)coinModel
{
    _coinModel = coinModel;
    self.chiyouLabel.text = coinModel.code;
    
    self.chiyouLabel.width = [WLTools getWidthWithText:coinModel.code font:self.chiyouLabel.font];
    self.chiyouLabel.centerX = self.chiyouTitleLabel.centerX;
    self.leftImageView.x = self.chiyouLabel.right + ScaleW(5);
    
    
}


-(void)setConvertModel:(HeBi_ConvertToCoin_Model *)convertModel
{
    _convertModel = convertModel;
    self.duihuanLabel.text = convertModel.dealCode;
    
    self.duihuanLabel.width = [WLTools getWidthWithText:convertModel.dealCode font:self.duihuanLabel.font];
    self.duihuanLabel.centerX = self.duihuanTitleLabel.centerX;
    self.rightImageView.x = self.duihuanLabel.right + ScaleW(5);
}


-(void)selectCoinEvent
{
    if (self.selectCoinBlock) {
        self.selectCoinBlock();
    }
}
-(void)selectConvertEvent
{
    if (self.selectConvertBlock) {
        self.selectConvertBlock();
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
