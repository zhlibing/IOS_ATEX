//
//  Heyue_ChiCang_Order_Cell.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/29.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_ChiCang_Order_Cell.h"

#import "SSKJ_Market_Index_Model.h"

#define LabelHeight ScreenWidth - ScaleW(65)

@interface Heyue_ChiCang_Order_Cell()
// 做多/做空
@property (nonatomic,strong) UILabel * directionLabel;
//币种
@property (nonatomic,strong) UILabel * coinLabel;
//时间
@property(nonatomic,strong)UILabel *dateLabel;
//类型
@property(nonatomic,strong)UILabel *typeTitle;
@property(nonatomic,strong)UILabel *typeLabel;
//杠杆倍数
@property(nonatomic,strong)UILabel *gangganTitle;
@property(nonatomic,strong)UILabel *gangganLabel;
//持仓价
@property(nonatomic,strong)UILabel *chicangPriceTitle;
@property(nonatomic,strong)UILabel *chicangPriceLabel;
//价格
@property(nonatomic,strong)UILabel *newPriceTitle;
@property(nonatomic,strong)UILabel *newPriceLabel;
//成交量(张数)
@property(nonatomic,strong)UILabel *numTitle;
@property(nonatomic,strong)UILabel *numLabel;
//保证金
@property(nonatomic,strong)UILabel *baozhengjinPriceTitle;
@property(nonatomic,strong)UILabel *baozhengjinPriceLabel;
//手续费
@property(nonatomic,strong)UILabel *shoufufeiLabelTitle;
@property(nonatomic,strong)UILabel *shoufufeiLabel;
//过夜费
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
//编辑
@property (nonatomic,strong) UIButton * editBtn;
//平仓
@property (nonatomic,strong) UIButton * pingCangBtn;

//顶部分割线
@property(nonatomic,strong)UIView *lineView;



//中间分割线
@property(nonatomic,strong)UIView *centerlineView;

@end

@implementation Heyue_ChiCang_Order_Cell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kSubBgColor;
        self.contentView.backgroundColor = kSubBgColor;

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.directionLabel];
        [self.contentView addSubview:self.coinLabel];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.lineView];
        
        [self.contentView addSubview:self.typeTitle];
        [self.contentView addSubview:self.typeLabel];
        [self.contentView addSubview:self.gangganTitle];
        [self.contentView addSubview:self.gangganLabel];
        [self.contentView addSubview:self.chicangPriceTitle];
        [self.contentView addSubview:self.chicangPriceLabel];
        [self.contentView addSubview:self.newPriceTitle];
        [self.contentView addSubview:self.newPriceLabel];
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
        [self.contentView addSubview:self.zhisunPriceTitle];
        [self.contentView addSubview:self.zhisunPriceLabel];
        [self.contentView addSubview:self.centerlineView];
        [self.contentView addSubview:self.fudongyingkuiView];
        [self.fudongyingkuiView addSubview:self.fudongyingkuiTitle];
        [self.fudongyingkuiView addSubview:self.fudongyingkuiLabel];
        
        [self.contentView addSubview:self.editBtn];
        [self.contentView addSubview:self.pingCangBtn];
        [self.contentView addSubview:self.bottomlineView];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(longSockedNewPrice:) name:@"reloadHeyueChicangCell" object:nil];
        

        [self setUIFrame];
    }
    return self;
}
#pragma mark -- 设置位置 --

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
    
    
    //l类型
    [self.typeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).offset(ScaleW(13));
        make.left.equalTo(self.directionLabel);
        make.width.equalTo(@(ScaleW(55)));
    }];

    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).offset(ScaleW(13));
        make.left.equalTo(@(ScaleW(85)));
        make.width.equalTo(@(ScaleW(55)));
    }];
    
    
    //最新价
    [self.newPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.typeTitle.mas_centerY);
        make.left.equalTo(@(ScaleW(220)));
        make.width.equalTo(self.typeTitle);
    }];
    
    [self.newPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.newPriceTitle);
        make.left.equalTo(@(ScaleW(283)));
        make.width.equalTo(@(ScaleW(80)));
    }];
    
    
    //持仓加
    [self.chicangPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeTitle.mas_bottom).offset(ScaleW(8));
        make.left.equalTo(self.typeTitle);
        make.width.equalTo(self.typeTitle);
        
    }];
    
    [self.chicangPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.chicangPriceTitle);
        make.left.equalTo(self.typeLabel);
        make.width.equalTo(@(ScaleW(100)));
        
    }];
    
    //保证金
       [self.baozhengjinPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(self.chicangPriceTitle.mas_centerY);
           make.left.equalTo(self.newPriceTitle.mas_left);
           make.width.equalTo(self.newPriceTitle);
       }];
       
       [self.baozhengjinPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(self.baozhengjinPriceTitle.mas_centerY);
           make.left.equalTo(self.newPriceLabel);
           make.width.equalTo(self.newPriceLabel);
       }];
    

     //张数
     [self.numTitle mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.chicangPriceTitle.mas_bottom).offset(ScaleW(8));
         make.left.equalTo(self.chicangPriceTitle);
         make.width.equalTo(self.chicangPriceTitle);
     }];
     
     [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.equalTo(self.numTitle.mas_centerY);
         make.left.equalTo(self.chicangPriceLabel);
         make.width.equalTo(self.newPriceLabel);
     }];
    
    //杠杆
    [self.gangganTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.numTitle);
        make.left.equalTo(self.newPriceTitle);
        make.width.equalTo(self.newPriceTitle);

    }];

    [self.gangganLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.gangganTitle);
        make.left.equalTo(self.newPriceLabel);
        make.width.equalTo(self.newPriceLabel);
    }];
//
    
    
    
    [self.shoufufeiLabelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numTitle.mas_bottom).offset(ScaleW(8));
        make.left.equalTo(self.chicangPriceTitle);
        make.width.equalTo(self.chicangPriceTitle);
    }];
    
    [self.shoufufeiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shoufufeiLabelTitle.mas_centerY);
        make.left.equalTo(self.chicangPriceLabel);
        make.width.equalTo(self.chicangPriceLabel);
    }];
    
    [self.guoyeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shoufufeiLabelTitle.mas_centerY);
        make.left.equalTo(self.gangganTitle.mas_left);
        make.width.equalTo(self.shoufufeiLabelTitle);
    }];

    [self.guoyeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.guoyeTitle);
        make.left.equalTo(self.newPriceLabel);
        make.width.equalTo(self.newPriceLabel);
    }];
    
    [self.zhiyingpriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shoufufeiLabelTitle.mas_bottom).offset(ScaleW(8));
        make.left.equalTo(self.chicangPriceTitle);
        make.width.equalTo(self.chicangPriceTitle);
    }];
    
    [self.zhiyingpriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.zhiyingpriceTitle.mas_centerY);
        make.left.equalTo(self.chicangPriceLabel.mas_left);
        make.width.equalTo(self.chicangPriceLabel);
    }];
    
    
    [self.zhisunPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.zhiyingpriceTitle.mas_centerY);
        make.left.equalTo(self.baozhengjinPriceTitle);
        make.width.equalTo(self.baozhengjinPriceTitle);
    }];
    
    [self.zhisunPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.zhisunPriceTitle.mas_centerY);
        make.left.equalTo(self.baozhengjinPriceLabel);
        make.width.equalTo(self.baozhengjinPriceLabel);
    }];
    
    
    [self.centerlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.zhiyingpriceTitle.mas_bottom).offset(ScaleW(12));
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
    
    
    
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.fudongyingkuiView.mas_centerY);
        make.right.equalTo(@(ScaleW(-25)));
        make.height.equalTo(@(ScaleW(25)));
        make.width.equalTo(@(ScaleW(50)));
    }];
    
    [self.pingCangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.editBtn.mas_left).offset(ScaleW(-10));
        make.centerY.equalTo(self.fudongyingkuiView.mas_centerY);
        make.height.equalTo(@(ScaleW(25)));
        make.width.equalTo(@(ScaleW(50)));
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
        _lineView.backgroundColor = kBgColor;
    }
    return _lineView;
}

- (UIView *)bottomlineView{
    if (_bottomlineView == nil) {
        _bottomlineView = [[UIView alloc]init];
        _bottomlineView.backgroundColor = kBgColor;
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

- (UILabel *)gangganTitle{
    if (_gangganTitle == nil) {
        _gangganTitle = [WLTools allocLabel:SSKJLocalized(@"杠杆倍数", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _gangganTitle.numberOfLines = 1;
        _gangganTitle.adjustsFontSizeToFitWidth = YES;
    }
    return _gangganTitle;
}

- (UILabel *)gangganLabel{
    if (_gangganLabel == nil) {
        _gangganLabel = [WLTools allocLabel:SSKJLocalized(@"50", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _gangganLabel.numberOfLines = 1;

    }
    return _gangganLabel;
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

- (UILabel *)newPriceTitle{
    if (_newPriceTitle == nil) {
        _newPriceTitle = [WLTools allocLabel:SSKJLocalized(@"最新价", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _newPriceTitle.numberOfLines = 1;
        _newPriceTitle.adjustsFontSizeToFitWidth = YES;

    }
    return _newPriceTitle;
}

- (UILabel *)newPriceLabel{
    if (_newPriceLabel == nil) {
        _newPriceLabel = [WLTools allocLabel:SSKJLocalized(@"0.0000", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _newPriceLabel.numberOfLines = 1;
        
    }
    return _newPriceLabel;
}


- (UILabel *)numTitle{
    if (_numTitle == nil) {
        _numTitle = [WLTools allocLabel:SSKJLocalized(@"张数", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
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
        _centerlineView.backgroundColor = kBgColor;
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

- (UIButton *)editBtn{
    if (_editBtn == nil) {
        _editBtn = [WLTools allocButton:SSKJLocalized(@"修改", nil) textColor:kBlueColor nom_bg:nil hei_bg:nil frame:CGRectZero];
        [_editBtn addTarget:self action:@selector(editBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _editBtn.titleLabel.font = systemFont(ScaleW(14));
        _editBtn.layer.borderColor = kBlueColor.CGColor;
        _editBtn.layer.borderWidth = ScaleW(.5f);
        _editBtn.cornerRadius = ScaleW(4);
        _editBtn.titleLabel.numberOfLines = 1;
        _editBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        
    }
    return _editBtn;
}

- (UIButton *)pingCangBtn{
    if (_pingCangBtn == nil) {
        _pingCangBtn = [WLTools allocButton:SSKJLocalized(@"平仓", nil) textColor:kBlueColor nom_bg:nil hei_bg:nil frame:CGRectZero];
        [_pingCangBtn addTarget:self action:@selector(pingCangBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _pingCangBtn.titleLabel.numberOfLines = 1;
        _pingCangBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        _pingCangBtn.titleLabel.font = systemFont(ScaleW(14));
        _pingCangBtn.layer.borderColor = kBlueColor.CGColor;
        _pingCangBtn.layer.borderWidth = ScaleW(.5f);
        _pingCangBtn.cornerRadius = ScaleW(4);
        
    }
    return _pingCangBtn;
}

#pragma mark - 赋值
- (void)setChicangModel:(Heyue_OrderDdetail_Model *)chicangModel{
    
    _chicangModel = chicangModel;
    //方向
    NSString *type = chicangModel.otype;
    self.directionLabel.text = [NSString stringWithFormat:@"%@",type.integerValue == 1?SSKJLocalized(@"做多", nil):SSKJLocalized(@"做空", nil)];
    self.directionLabel.textColor = type.integerValue == 1?kMarketUp:kMarketDown;
    
    self.coinLabel.text = [chicangModel.code uppercaseString];
    
        
    //时间
    self.dateLabel.text = [NSString stringWithFormat:@"%@ %@",[chicangModel.created_at substringWithRange:NSMakeRange(11, 5)],[chicangModel.created_at substringWithRange:NSMakeRange(5, 5)]];
    
    NSString *str;
    if (chicangModel.from.integerValue == 1) {
        str = SSKJLanguage(@"市价");
    }else if (chicangModel.from.integerValue == 2){
        str = SSKJLanguage(@"限价");
    }
    
    self.typeLabel.text = str;
    
    //持仓价
    self.chicangPriceLabel.text = [SSTool HeyueCoin:chicangModel.code price:chicangModel.buyprice];
    
    //最新价
    self.newPriceLabel.text = [SSTool HeyueCoin:chicangModel.code price:chicangModel.marketPrice];
    
    //张数
    self.numLabel.text = [NSString stringWithFormat:@"%@%@",chicangModel.sheets,SSKJLocalized(@"张", nil)];
    
    self.guoyeLabel.text = [SSTool HeyuePname:chicangModel.code price:chicangModel.dayfee];

    self.gangganLabel.text = chicangModel.leverage;
    
    //手续费
    self.shoufufeiLabel.text = [SSTool HeyuePname:chicangModel.code price:chicangModel.fee];
    
    
    //保证金
    self.baozhengjinPriceLabel.text = [SSTool HeyuePname:chicangModel.code price:chicangModel.totalprice];

    
    //止盈止损
    self.zhiyingpriceLabel.text = [SSTool HeyueCoin:chicangModel.code price:chicangModel.stopwin];

    self.zhisunPriceLabel.text = [SSTool HeyueCoin:chicangModel.code price:chicangModel.stoploss];
    
//    NSString *floatingPL = chicangModel.floatingPL;
//    self.fudongyingkuiLabel.text = chicangModel.winLoseMoney;
   self.fudongyingkuiLabel.text = [SSTool HeyuePname:@"USDT" price:chicangModel.floating];
    
    double width = [self returnWidth:self.fudongyingkuiLabel.text font:ScaleW(13)];
    
    [self.fudongyingkuiView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(ScaleW(91) + width));
    }];
    
    if ([chicangModel.floating containsString:@"-"]) {
        self.fudongyingkuiView.backgroundColor = kMarketDown;
    }else{
        self.fudongyingkuiView.backgroundColor = kMarketUp;
    }
}

#pragma mark -- 点击事件--
- (void)editBtnAction{
    if (self.HeyueEditBlock) {
        self.HeyueEditBlock();
    }
}

- (void)pingCangBtnAction{
    if (self.HeyuePingCangBlock) {
        self.HeyuePingCangBlock();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//-(void)longSockedNewPrice:(NSNotification *)notifa
//{
//    id objc = notifa.object;
//    
//     SSKJ_Market_Index_Model *socketModel=objc;
//    
//    if ([socketModel.code isEqualToString:self.chicangModel.stockCode]) {
//         self.newPriceLabel.text = [SSTool HeyueCoin:_chicangModel.stockCode price:socketModel.price];
//        
//    }
////    JB_Market_Index_Model *model = objc;
////
////    if ([model.code isEqualToString:_timeModel.mark]) {
////        self.nePriceLabel.text = [NSString stringWithFormat:SSKJLocalized(@"%@", nil),[WLTools noroundingStringWith:model.price.doubleValue afterPointNumber:[self pointCount:model.code]]];
////        SSLog(@"%@",model.price);
////    }
////
////    if ([model.code isEqualToString:_model.mark]) {
////        self.mostNewPriceLabel.text = [NSString stringWithFormat:SSKJLocalized(@"最新价:%@", nil),[WLTools noroundingStringWith:model.price.doubleValue afterPointNumber:[self pointCount:model.code]]];
////    }
//    
//    
//}
//
//-(void)dealloc
//
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:@"reloadHeyueChicangCell"];
//}
@end
