//
//  Heyue_ChengJiao_Order_Cell.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/29.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_ChengJiao_Order_Cell.h"

#define LabelHeight ScreenWidth - ScaleW(65)

@interface Heyue_ChengJiao_Order_Cell()
// 做多/做空
@property (nonatomic,strong) UILabel * directionLabel;
//币种
@property (nonatomic,strong) UILabel * coinLabel;
//时间
@property(nonatomic,strong)UILabel *dateLabel;
//类型
@property(nonatomic,strong)UILabel *typeTitle;
@property(nonatomic,strong)UILabel *typeLabel;
//建仓时间
@property(nonatomic,strong)UILabel *createTimeTitle;
@property(nonatomic,strong)UILabel *createTimeLabel;

//杠杠
@property(nonatomic,strong)UILabel *leverageTitle;
@property(nonatomic,strong)UILabel *leverageLabel;
//平仓时间
@property(nonatomic,strong)UILabel *closeTimeTitle;
@property(nonatomic,strong)UILabel *closeTimeLabel;
//持仓价
@property(nonatomic,strong)UILabel *chicangPriceTitle;
@property(nonatomic,strong)UILabel *chicangPriceLabel;


//pingcang价格
@property(nonatomic,strong)UILabel *pingcangPriceTitle;
@property(nonatomic,strong)UILabel *pingcangPriceLabel;
//成交量(张数)
@property(nonatomic,strong)UILabel *numTitle;
@property(nonatomic,strong)UILabel *numLabel;
//保证金
@property(nonatomic,strong)UILabel *baozhengjinPriceTitle;
@property(nonatomic,strong)UILabel *baozhengjinPriceLabel;
//手续费
@property(nonatomic,strong)UILabel *shoufufeiLabelTitle;
@property(nonatomic,strong)UILabel *shoufufeiLabel;
////过夜费
@property(nonatomic,strong)UILabel *guoyeTitle;
@property(nonatomic,strong)UILabel *guoyeLabel;
//止盈价格
@property(nonatomic,strong)UILabel *zhiyingpriceTitle;
@property(nonatomic,strong)UILabel *zhiyingpriceLabel;
//止损价格
@property(nonatomic,strong)UILabel *zhisunPriceTitle;
@property(nonatomic,strong)UILabel *zhisunPriceLabel;

//浮动盈亏
@property (nonatomic,strong) UIView *fudongyingkuiView;
@property(nonatomic,strong)UILabel *fudongyingkuiTitle;
@property(nonatomic,strong)UILabel *fudongyingkuiLabel;
//成交类型类型
@property(nonatomic,strong)UILabel *pingcangcreateTimeLabel;

//顶部分割线
@property(nonatomic,strong)UIView *lineView;

@property (nonatomic, strong) UIButton *shareButton;



//中间分割线
@property(nonatomic,strong)UIView *centerlineView;

@end
@implementation Heyue_ChengJiao_Order_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kSubBgColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self.contentView addSubview:self.directionLabel];
        [self.contentView addSubview:self.coinLabel];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.typeTitle];
        [self.contentView addSubview:self.typeLabel];
        [self.contentView addSubview:self.createTimeTitle];
        [self.contentView addSubview:self.createTimeLabel];
        [self.contentView addSubview:self.closeTimeTitle];
        [self.contentView addSubview:self.closeTimeLabel];
        [self.contentView addSubview:self.leverageTitle];
        [self.contentView addSubview:self.leverageLabel];
        [self.contentView addSubview:self.chicangPriceTitle];
        [self.contentView addSubview:self.chicangPriceLabel];
        [self.contentView addSubview:self.pingcangPriceTitle];
        [self.contentView addSubview:self.pingcangPriceLabel];
        [self.contentView addSubview:self.numTitle];
        [self.contentView addSubview:self.numLabel];
        [self.contentView addSubview:self.baozhengjinPriceTitle];
        [self.contentView addSubview:self.baozhengjinPriceLabel];
        [self.contentView addSubview:self.shoufufeiLabelTitle];
        [self.contentView addSubview:self.shoufufeiLabel];
        [self.contentView addSubview:self.zhiyingpriceTitle];
        [self.contentView addSubview:self.zhiyingpriceLabel];
        [self.contentView addSubview:self.guoyeTitle];
        [self.contentView addSubview:self.guoyeLabel];
//        [self.contentView addSubview:self.zhisunPriceTitle];
//        [self.contentView addSubview:self.zhisunPriceLabel];
        [self.contentView addSubview:self.centerlineView];
        [self.contentView addSubview:self.fudongyingkuiView];
        
        [self.fudongyingkuiView addSubview:self.fudongyingkuiTitle];
        [self.fudongyingkuiView addSubview:self.fudongyingkuiLabel];
        
        [self.contentView addSubview:self.shareButton];
        
        [self.contentView addSubview:self.pingcangcreateTimeLabel];
        [self.contentView addSubview:self.bottomlineView];
        [self setUIFrame];
    }
    return self;
}

- (void)setUIFrame{
    //做多 做空
    [self.directionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(ScaleW(25)));
        make.top.equalTo(@(ScaleW(15)));
    }];
    //币种
    [self.coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.directionLabel.mas_right).offset(ScaleW(8));
        make.centerY.equalTo(self.directionLabel.mas_centerY);
    }];
    //时间
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(ScaleW(-15)));
        make.centerY.equalTo(self.directionLabel.mas_centerY);
    }];
    
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.directionLabel.mas_bottom).offset(ScaleW(16));
        make.right.equalTo(@(ScaleW(-25)));
        make.left.equalTo(@(ScaleW(25)));
        make.height.equalTo(@(ScaleW(.5f)));
    }];
    
    
    //类型
    [self.typeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).offset(ScaleW(13));
        make.left.equalTo(self.directionLabel);
        make.width.equalTo(@(ScaleW(55)));
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.typeTitle);
        make.left.equalTo(@(ScaleW(85)));
        make.width.equalTo(@(ScaleW(100)));
    }];
    
    //建仓时间
    [self.createTimeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.typeTitle);
        make.left.equalTo(@(ScaleW(220)));
        make.width.equalTo(self.typeTitle);
    }];
    
    [self.createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.createTimeTitle);
        make.left.equalTo(@(ScaleW(283)));
        make.width.equalTo(@(ScaleW(80)));
    }];
    
    
    //杠杠
    [self.leverageTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel.mas_bottom).offset(ScaleW(8));
        make.left.equalTo(self.typeTitle);
        make.width.equalTo(self.createTimeTitle);
        
    }];
    
    [self.leverageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leverageTitle);
        make.left.equalTo(@(ScaleW(85)));
        make.width.equalTo(@(ScaleW(80)));
    }];
    
    //平仓时间
    [self.closeTimeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leverageTitle);
        make.left.equalTo(@(ScaleW(220)));
        make.width.equalTo(self.leverageTitle);
        
    }];
    
    [self.closeTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.closeTimeTitle);
        make.left.equalTo(@(ScaleW(283)));
        make.width.equalTo(@(ScaleW(80)));
    }];
    
    //持仓加
    [self.chicangPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leverageTitle.mas_bottom).offset(ScaleW(8));
        make.left.equalTo(self.leverageTitle);
        make.width.equalTo(self.leverageTitle);
        
    }];
    
    [self.chicangPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.chicangPriceTitle.mas_centerY);
        make.left.equalTo(self.leverageLabel);
        make.width.equalTo(self.leverageLabel);
        
    }];
    
    //平仓价
    [self.pingcangPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.chicangPriceTitle.mas_centerY);
        make.left.equalTo(self.createTimeTitle);
        make.width.equalTo(self.createTimeTitle);
    }];
    
    [self.pingcangPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.pingcangPriceTitle.mas_centerY);
        make.left.equalTo(self.createTimeLabel);
        make.width.equalTo(self.createTimeLabel);
    }];
    
    //张数
    [self.numTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chicangPriceTitle.mas_bottom).offset(ScaleW(8));
        make.left.equalTo(self.typeTitle);
        make.width.equalTo(self.typeTitle);
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.numTitle.mas_centerY);
        make.left.equalTo(self.typeLabel);
        make.width.equalTo(self.typeLabel);
    }];
    //保证金
    [self.baozhengjinPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.numTitle.mas_centerY);
        make.left.equalTo(self.closeTimeTitle.mas_left);
        make.width.equalTo(self.closeTimeTitle);
    }];
    
    [self.baozhengjinPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.baozhengjinPriceTitle.mas_centerY);
        make.left.equalTo(self.closeTimeLabel);
        make.width.equalTo(self.closeTimeLabel);
    }];
    
    [self.shoufufeiLabelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numTitle.mas_bottom).offset(ScaleW(8));
        make.left.equalTo(self.typeTitle);
        make.width.equalTo(self.typeTitle);
    }];
    
    [self.shoufufeiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shoufufeiLabelTitle.mas_centerY);
        make.left.equalTo(self.typeLabel);
        make.width.equalTo(self.typeLabel);
    }];
    
    [self.guoyeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shoufufeiLabel.mas_centerY);
        make.left.equalTo(self.closeTimeTitle.mas_left);
        make.width.equalTo(self.closeTimeTitle);
    }];

    [self.guoyeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shoufufeiLabel);
        make.left.equalTo(self.closeTimeLabel);
        make.width.equalTo(self.closeTimeLabel);
    }];
    
    
//    [self.zhiyingpriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.shoufufeiLabelTitle.mas_bottom).offset(ScaleW(8));
//        make.left.equalTo(self.typeTitle);
//        make.width.equalTo(self.typeTitle);
//    }];
//
//    [self.zhiyingpriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.zhiyingpriceTitle.mas_centerY);
//        make.left.equalTo(self.typeLabel.mas_left);
//        make.width.equalTo(self.typeLabel);
//    }];
    
    
//    [self.zhisunPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.zhiyingpriceTitle.mas_centerY);
//        make.left.equalTo(self.closeTimeTitle.mas_left);
//        make.width.equalTo(self.closeTimeTitle);
//    }];
//
//    [self.zhisunPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.zhiyingpriceTitle);
//        make.left.equalTo(self.closeTimeLabel);
//        make.width.equalTo(self.closeTimeLabel);
//    }];
    
    
        [self.centerlineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shoufufeiLabelTitle.mas_bottom).offset(ScaleW(12));
            make.left.height.right.equalTo(self.lineView);

        }];
    
    [self.fudongyingkuiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.centerlineView.mas_bottom).offset(ScaleW(12));
        make.left.equalTo(@(ScaleW(25)));
        make.width.equalTo(@(ScaleW(135)));
        make.height.equalTo(@(ScaleW(28)));
    }];
    
    [self.fudongyingkuiTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.left.equalTo(@(ScaleW(10)));
        make.width.equalTo(@(ScaleW(60)));
    }];
    
    [self.fudongyingkuiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
        make.right.equalTo(@(ScaleW(-5)));
        make.left.equalTo(@(ScaleW(75)));
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(ScaleW(-15));
        make.width.mas_equalTo(ScaleW(60));
        make.height.mas_equalTo(ScaleW(28));
        make.centerY.equalTo(self.fudongyingkuiView);
    }];
    
    [self.pingcangcreateTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.fudongyingkuiView.mas_centerY);
        make.right.equalTo(self.shareButton.mas_left).offset(-ScaleW(15));
        make.left.equalTo(self.fudongyingkuiView.mas_right);
    }];
    
    
    [self.bottomlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(0));
        make.right.equalTo(@(ScaleW(0)));
        make.left.equalTo(@(ScaleW(0)));
        make.height.equalTo(@(ScaleW(5)));
    }];
    
    
    
    
}

#pragma mark -- c创建UI--

- (UILabel *)directionLabel{
    if (_directionLabel == nil) {
        _directionLabel = [WLTools allocLabel:SSKJLocalized(@"做多", nil) font:systemFont(ScaleW(14)) textColor:kMarketUp frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _directionLabel.numberOfLines = 1;
    }
    return _directionLabel;
}

- (UILabel *)coinLabel{
    if (_coinLabel == nil) {
        _coinLabel = [WLTools allocLabel:SSKJLocalized(@"BTC_USDT", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _coinLabel.numberOfLines = 1;

    }
    return _coinLabel;
}

- (UILabel *)dateLabel{
    if (_dateLabel == nil) {
        _dateLabel = [WLTools allocLabel:SSKJLocalized(@"00:00:00 12/12", nil) font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentRight];
        _dateLabel.numberOfLines = 1;

    }
    return _dateLabel;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kLineColor;
    }
    return _lineView;
}

- (UIView *)bottomlineView{
    if (_bottomlineView == nil) {
        _bottomlineView = [[UIView alloc]init];
        _bottomlineView.backgroundColor = kSubBgColor;
    }
    return _bottomlineView;
}


- (UILabel *)typeTitle{
    if (_typeTitle == nil) {
        _typeTitle = [WLTools allocLabel:SSKJLocalized(@"类型", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _typeTitle.numberOfLines = 1;

    }
    return _typeTitle;
}

- (UILabel *)typeLabel{
    if (_typeLabel == nil) {
        _typeLabel = [WLTools allocLabel:SSKJLocalized(@"做多", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _typeLabel.numberOfLines = 1;

    }
    return _typeLabel;
}

- (UILabel *)createTimeTitle{
    if (_createTimeTitle == nil) {
        _createTimeTitle = [WLTools allocLabel:SSKJLocalized(@"建仓时间", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _createTimeTitle.numberOfLines = 1;

    }
    return _createTimeTitle;
}

- (UILabel *)createTimeLabel{
    if (_createTimeLabel == nil) {
        _createTimeLabel = [WLTools allocLabel:SSKJLocalized(@"做多", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _createTimeLabel.numberOfLines = 1;

    }
    return _createTimeLabel;
}

- (UILabel *)closeTimeTitle{
    if (_closeTimeTitle == nil) {
        _closeTimeTitle = [WLTools allocLabel:SSKJLocalized(@"平仓时间", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _closeTimeTitle.numberOfLines = 1;

    }
    return _closeTimeTitle;
}

- (UILabel *)closeTimeLabel{
    if (_closeTimeLabel == nil) {
        _closeTimeLabel = [WLTools allocLabel:SSKJLocalized(@"50", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _closeTimeLabel.numberOfLines = 1;

    }
    return _closeTimeLabel;
}


- (UILabel *)leverageTitle{
    if (_leverageTitle == nil) {
        _leverageTitle = [WLTools allocLabel:SSKJLocalized(@"杠杆倍数", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _leverageTitle.numberOfLines = 1;

    }
    return _leverageTitle;
}

- (UILabel *)leverageLabel{
    if (_leverageLabel == nil) {
        _leverageLabel = [WLTools allocLabel:SSKJLocalized(@"50", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _leverageLabel.numberOfLines = 1;

    }
    return _leverageLabel;
}

- (UILabel *)chicangPriceTitle{
    if (_chicangPriceTitle == nil) {
        _chicangPriceTitle = [WLTools allocLabel:SSKJLocalized(@"持仓价", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _chicangPriceTitle.numberOfLines = 1;
        _chicangPriceTitle.adjustsFontSizeToFitWidth = YES;
    }
    return _chicangPriceTitle;
}

- (UILabel *)chicangPriceLabel{
    if (_chicangPriceLabel == nil) {
        _chicangPriceLabel = [WLTools allocLabel:SSKJLocalized(@"0.0000", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _chicangPriceLabel.numberOfLines = 1;

    }
    return _chicangPriceLabel;
}

- (UILabel *)pingcangPriceTitle{
    if (_pingcangPriceTitle == nil) {
        _pingcangPriceTitle = [WLTools allocLabel:SSKJLocalized(@"平仓价", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _pingcangPriceTitle.numberOfLines = 1;
        _pingcangPriceTitle.adjustsFontSizeToFitWidth = YES;

    }
    return _pingcangPriceTitle;
}

- (UILabel *)pingcangPriceLabel{
    if (_pingcangPriceLabel == nil) {
        _pingcangPriceLabel = [WLTools allocLabel:SSKJLocalized(@"0.0000", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _pingcangPriceLabel.numberOfLines = 1;

    }
    return _pingcangPriceLabel;
}


- (UILabel *)numTitle{
    if (_numTitle == nil) {
        _numTitle = [WLTools allocLabel:SSKJLocalized(@"成交量", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _numTitle.numberOfLines = 1;
        _numTitle.adjustsFontSizeToFitWidth = YES;
    }
    return _numTitle;
}

- (UILabel *)numLabel{
    if (_numLabel == nil) {
        _numLabel = [WLTools allocLabel:SSKJLocalized(@"10", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _numLabel.numberOfLines = 1;

    }
    return _numLabel;
}


- (UILabel *)baozhengjinPriceTitle{
    if (_baozhengjinPriceTitle == nil) {
        _baozhengjinPriceTitle = [WLTools allocLabel:SSKJLocalized(@"保证金", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _baozhengjinPriceTitle.numberOfLines = 1;
        _baozhengjinPriceTitle.adjustsFontSizeToFitWidth = YES;

    }
    return _baozhengjinPriceTitle;
}

- (UILabel *)baozhengjinPriceLabel{
    if (_baozhengjinPriceLabel == nil) {
        _baozhengjinPriceLabel = [WLTools allocLabel:SSKJLocalized(@"0.0000", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _baozhengjinPriceLabel.numberOfLines = 1;

    }
    return _baozhengjinPriceLabel;
}


- (UILabel *)shoufufeiLabelTitle{
    if (_shoufufeiLabelTitle == nil) {
        _shoufufeiLabelTitle = [WLTools allocLabel:SSKJLocalized(@"手续费", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _shoufufeiLabelTitle.numberOfLines = 1;
        _shoufufeiLabelTitle.adjustsFontSizeToFitWidth = YES;

    }
    return _shoufufeiLabelTitle;
}

- (UILabel *)shoufufeiLabel{
    if (_shoufufeiLabel == nil) {
        _shoufufeiLabel = [WLTools allocLabel:SSKJLocalized(@"10", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _shoufufeiLabel.numberOfLines = 1;

    }
    return _shoufufeiLabel;
}


- (UILabel *)guoyeTitle{
    if (_guoyeTitle == nil) {
        _guoyeTitle = [WLTools allocLabel:SSKJLocalized(@"仓息", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _guoyeTitle.numberOfLines = 1;
        _guoyeTitle.adjustsFontSizeToFitWidth = YES;

    }
    return _guoyeTitle;
}

- (UILabel *)guoyeLabel{
    if (_guoyeLabel == nil) {
        _guoyeLabel = [WLTools allocLabel:SSKJLocalized(@"50", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _guoyeLabel.numberOfLines = 1;

    }
    return _guoyeLabel;
}


- (UILabel *)zhiyingpriceTitle{
    if (_zhiyingpriceTitle == nil) {
        _zhiyingpriceTitle = [WLTools allocLabel:SSKJLocalized(@"止盈价格", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _zhiyingpriceTitle.numberOfLines = 1;
        _zhiyingpriceTitle.adjustsFontSizeToFitWidth = YES;

    }
    return _zhiyingpriceTitle;
}

- (UILabel *)zhiyingpriceLabel{
    if (_zhiyingpriceLabel == nil) {
        _zhiyingpriceLabel = [WLTools allocLabel:SSKJLocalized(@"10", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _zhiyingpriceLabel.numberOfLines = 1;

    }
    return _zhiyingpriceLabel;
}

- (UILabel *)zhisunPriceTitle{
    if (_zhisunPriceTitle == nil) {
        _zhisunPriceTitle = [WLTools allocLabel:SSKJLocalized(@"止损价格", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _zhisunPriceTitle.numberOfLines = 1;
        _zhisunPriceTitle.adjustsFontSizeToFitWidth = YES;

    }
    return _zhisunPriceTitle;
}

- (UILabel *)zhisunPriceLabel{
    if (_zhisunPriceLabel == nil) {
        _zhisunPriceLabel = [WLTools allocLabel:SSKJLocalized(@"0.0000", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _zhisunPriceLabel.numberOfLines = 1;

    }
    return _zhisunPriceLabel;
}

- (UIView *)centerlineView{
    if (_centerlineView == nil) {
        _centerlineView = [[UIView alloc]init];
        _centerlineView.backgroundColor = kLineColor;
    }
    return _centerlineView;
}

- (UIView *)fudongyingkuiView{
    if (_fudongyingkuiView == nil) {
        _fudongyingkuiView = [[UIView alloc]init];
        _fudongyingkuiView.backgroundColor = kMarketUp;
        _fudongyingkuiView.cornerRadius = ScaleW(2);
    }
    return _fudongyingkuiView;
}

- (UILabel *)fudongyingkuiTitle{
    if (_fudongyingkuiTitle == nil) {
        _fudongyingkuiTitle = [WLTools allocLabel:SSKJLocalized(@"盈亏", nil) font:systemFont(ScaleW(13)) textColor:kWhiteColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _fudongyingkuiTitle.numberOfLines = 1;
        _fudongyingkuiTitle.adjustsFontSizeToFitWidth = YES;

    }
    return _fudongyingkuiTitle;
}

- (UILabel *)fudongyingkuiLabel{
    if (_fudongyingkuiLabel == nil) {
        _fudongyingkuiLabel = [WLTools allocLabel:SSKJLocalized(@"0.0000", nil) font:systemFont(ScaleW(13)) textColor:kWhiteColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        _fudongyingkuiLabel.numberOfLines = 1;

    }
    return _fudongyingkuiLabel;
}


-(UIButton *)shareButton
{
    if (nil == _shareButton) {
        _shareButton = [[UIButton alloc]initWithFrame:CGRectZero];
        [_shareButton setTitle:SSKJLocalized(@"分享", nil) forState:UIControlStateNormal];
        [_shareButton setTitleColor:kBlueColor forState:UIControlStateNormal];
        _shareButton.titleLabel.font = systemFont(ScaleW(15));
        _shareButton.layer.borderColor = kBlueColor.CGColor;
        _shareButton.layer.cornerRadius = ScaleW(5);
        _shareButton.layer.borderWidth = 0.5;
        [_shareButton addTarget:self action:@selector(shareEvent) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _shareButton;
}

- (UILabel *)pingcangcreateTimeLabel{
    if (_pingcangcreateTimeLabel == nil) {
        _pingcangcreateTimeLabel = [WLTools allocLabel:SSKJLocalized(@"系统平仓", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentRight];
        _pingcangcreateTimeLabel.numberOfLines = 1;
        _pingcangcreateTimeLabel.adjustsFontSizeToFitWidth = YES;

    }
    return _pingcangcreateTimeLabel;
}

- (void)setChengJiaoModel:(Heyue_Order_ChengjiaoModel *)chengJiaoModel{
    _chengJiaoModel = chengJiaoModel;
    //方向
    NSString *type = chengJiaoModel.otype;
    self.directionLabel.text = [NSString stringWithFormat:@"%@",type.integerValue == 1?SSKJLocalized(@"做多", nil):SSKJLocalized(@"做空", nil)];
    self.directionLabel.textColor = type.integerValue == 1?kMarketUp:kMarketDown;
    
    self.coinLabel.text = [chengJiaoModel.code uppercaseString];
    
    //时间
    self.dateLabel.text = [NSString stringWithFormat:@"%@ %@",[chengJiaoModel.created_at substringWithRange:NSMakeRange(11, 5)],[chengJiaoModel.created_at substringWithRange:NSMakeRange(5, 5)]];

    NSString *str;
    if (chengJiaoModel.from.integerValue == 1) {
        str = SSKJLanguage(@"市价");
    }else if (chengJiaoModel.from.integerValue == 2){
        str = SSKJLanguage(@"限价");
    }
    
    self.typeLabel.text = str;
    self.createTimeLabel.text = [chengJiaoModel.jiancang_at substringWithRange:NSMakeRange(5, 11)];

    self.closeTimeLabel.text = [chengJiaoModel.created_at substringWithRange:NSMakeRange(5, 11)];
    self.leverageLabel.text = chengJiaoModel.leverage;
    
    //持仓价
    self.chicangPriceLabel.text = [SSTool HeyueCoin:chengJiaoModel.code price:chengJiaoModel.buyprice];
    
    //平仓价格
    self.pingcangPriceLabel.text = [SSTool HeyueCoin:chengJiaoModel.code price:chengJiaoModel.sellprice];
    
    //张数
    self.numLabel.text = [NSString stringWithFormat:@"%@%@",chengJiaoModel.sheets,SSKJLocalized(@"张", nil)];
    
    //保证金
    self.baozhengjinPriceLabel.text = [SSTool HeyuePname:chengJiaoModel.code price:chengJiaoModel.totalprice];
    
    
    //手续费
    self.shoufufeiLabel.text = [SSTool HeyuePname:chengJiaoModel.code price:chengJiaoModel.fee];
    
    self.guoyeLabel.text = [SSTool HeyuePname:chengJiaoModel.code price:chengJiaoModel.dayfee];

    //止盈止损
    self.zhisunPriceLabel.text = [SSTool HeyueCoin:chengJiaoModel.code price:chengJiaoModel.stoploss];
    
    self.zhiyingpriceLabel.text = [SSTool HeyueCoin:chengJiaoModel.code price:chengJiaoModel.stopwin];
    
    // 成交浮动盈亏

    self.fudongyingkuiLabel.text = [SSTool HeyuePname:chengJiaoModel.code price:chengJiaoModel.profit];
    
    double width = [self returnWidth:self.fudongyingkuiLabel.text font:ScaleW(13)];
    
    
    [self.fudongyingkuiView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(ScaleW(91) + width));
    }];
    if ([chengJiaoModel.profit containsString:@"-"]) {
        self.fudongyingkuiView.backgroundColor = kMarketDown;
    }else{
        self.fudongyingkuiView.backgroundColor = kMarketUp;
    }
    
    if (chengJiaoModel.profit.doubleValue > 0) {
        self.shareButton.hidden = NO;
    }else{
        self.shareButton.hidden = YES;
    }
    
    //平仓类型
    NSInteger pctype = chengJiaoModel.pc_type.integerValue;
    NSString *pctypeString = @"";
    switch (pctype) {
        case 1:
        {
            pctypeString = SSKJLocalized(@"手动平仓", nil);
        }
            break;
        case 2:
        {
            pctypeString = SSKJLocalized(@"止盈平仓", nil);
        }
            break;
        case 3:
        {
            pctypeString = SSKJLocalized(@"止损平仓", nil);
        }
            break;
        case 4:
        {
            pctypeString = SSKJLocalized(@"系统强平", nil);
        }
            break;
//            case 5:
//            {
//                pctypeString = SSKJLocalized(@"爆仓强平", nil);
//            }
//                break;
        default:
            break;
    }
    self.pingcangcreateTimeLabel.text = [NSString stringWithFormat:@"%@:%@",SSKJLocalized(@"类型", nil),pctypeString];
}


-(void)shareEvent
{
    if (self.shareBlock) {
        self.shareBlock(self.chengJiaoModel);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
