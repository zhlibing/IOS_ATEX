//
//  Heyue_WeiTuo_Order_Cell.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_WeiTuo_Order_Cell.h"

#define LabelHeight ScreenWidth - ScaleW(65)

@interface Heyue_WeiTuo_Order_Cell()
// 做多/做空
@property (nonatomic,strong) UILabel * directionLabel;
//币种
@property (nonatomic,strong) UILabel * coinLabel;
//时间
@property(nonatomic,strong)UILabel *dateLabel;
//撤单
@property(nonatomic,strong)UIButton *cheDanBtn;


//类型
@property(nonatomic,strong)UILabel *typeLabelTitle;
@property(nonatomic,strong)UILabel *typeLabelLabel;
//委托价
@property(nonatomic,strong)UILabel *weituoPriceTitle;
@property(nonatomic,strong)UILabel *weituoPriceLabel;

//最新价
@property(nonatomic,strong)UILabel *zuixinPriceTitle;
@property(nonatomic,strong)UILabel *zuixinPriceLabel;


//委托量(张数)
@property(nonatomic,strong)UILabel *numTitle;
@property(nonatomic,strong)UILabel *numLabel;
//杠杆
@property(nonatomic,strong)UILabel *leverageTitle;
@property(nonatomic,strong)UILabel *leverageLabel;

//保证金
@property(nonatomic,strong)UILabel *baozhengjinPriceTitle;
@property(nonatomic,strong)UILabel *baozhengjinPriceLabel;


////过夜费
//@property(nonatomic,strong)UILabel *guoyefeiLabelTitle;
//@property(nonatomic,strong)UILabel *guoyefeiLabelLabel;
////止盈价格
//@property(nonatomic,strong)UILabel *zhiyingpriceTitle;
//@property(nonatomic,strong)UILabel *zhiyingpriceLabel;
////止损价格
//@property(nonatomic,strong)UILabel *zhisunPriceTitle;
//@property(nonatomic,strong)UILabel *zhisunPriceLabel;

//分割线
@property(nonatomic,strong)UIView *lineView;

//分割线
@property(nonatomic,strong)UIView *bottomlineView;

@end

@implementation Heyue_WeiTuo_Order_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView setBackgroundColor:kBgColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self.contentView addSubview:self.directionLabel];
        [self.contentView addSubview:self.coinLabel];
        [self.contentView addSubview:self.dateLabel];
        
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.bottomlineView];
                
        [self.contentView addSubview:self.numTitle];
        [self.contentView addSubview:self.numLabel];
        
        [self.contentView addSubview:self.leverageTitle];
        [self.contentView addSubview:self.leverageLabel];
        [self.contentView addSubview:self.typeLabelTitle];
        [self.contentView addSubview:self.typeLabelLabel];
        [self.contentView addSubview:self.weituoPriceTitle];
        [self.contentView addSubview:self.weituoPriceLabel];
        [self.contentView addSubview:self.zuixinPriceTitle];
        [self.contentView addSubview:self.zuixinPriceLabel];
        
        [self.contentView addSubview:self.baozhengjinPriceTitle];
        [self.contentView addSubview:self.baozhengjinPriceLabel];
        
        [self.contentView addSubview:self.bottomGrayView];
        [self.contentView addSubview:self.cheDanBtn];
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
       [self.typeLabelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.lineView.mas_bottom).offset(ScaleW(13));
           make.left.equalTo(self.directionLabel);
           make.width.equalTo(@(ScaleW(55)));
       }];
       
       [self.typeLabelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(self.typeLabelTitle);
           make.left.equalTo(@(ScaleW(85)));
           make.width.equalTo(@(ScaleW(100)));
       }];
       
    
    //委托价
    [self.weituoPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabelTitle.mas_bottom).offset(ScaleW(15));
        make.left.equalTo(self.directionLabel);
        make.width.equalTo(@(ScaleW(55)));

    }];
    
    [self.weituoPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.weituoPriceTitle);
        make.left.equalTo(@(ScaleW(85)));
        make.width.equalTo(@(ScaleW(100)));

    }];
    
    [self.zuixinPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.weituoPriceTitle);
        make.left.equalTo(@(ScaleW(220)));
        make.width.equalTo(self.weituoPriceTitle);
    }];

    [self.zuixinPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.weituoPriceTitle);
        make.left.equalTo(@(ScaleW(283)));
        make.width.equalTo(@(ScaleW(80)));
    }];
    
    
   
    
    //张数  委托量
    [self.numTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.typeLabelTitle);
        make.left.equalTo(@(ScaleW(220)));
        make.width.equalTo(self.zuixinPriceLabel);
        
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.numTitle);
        make.left.equalTo(@(ScaleW(283)));
        make.width.equalTo(@(ScaleW(80)));
    }];
    
    //杠杆
       [self.leverageTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weituoPriceTitle.mas_bottom).offset(ScaleW(15));
           make.left.equalTo(self.weituoPriceTitle.mas_left);
           make.width.equalTo(@(ScaleW(60)));
       }];
       
       [self.leverageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerY.equalTo(self.leverageTitle.mas_centerY);
           make.left.equalTo(self.weituoPriceLabel.mas_left);
           make.width.equalTo(@(ScaleW(120)));
       }];


    
    //保证金
    [self.baozhengjinPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leverageTitle);
        make.left.equalTo(self.zuixinPriceTitle);
        make.width.equalTo(self.zuixinPriceTitle);
        
    }];
    
    [self.baozhengjinPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.baozhengjinPriceTitle);
        make.left.equalTo(self.numLabel);
        make.width.equalTo(self.numLabel);
    }];
    
    
    
    [self.bottomlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baozhengjinPriceTitle.mas_bottom).offset(ScaleW(18));
        make.right.equalTo(self.lineView);
        make.height.left.equalTo(self.lineView);
    }];

    [self.cheDanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(ScaleW(-28)));
        
        make.top.equalTo(self.bottomlineView.mas_bottom).offset(ScaleW(10));
        
        make.height.equalTo(@(ScaleW(30)));
        make.width.equalTo(@(ScaleW(60)));
    }];
    
    
    [self.bottomGrayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@(ScaleW(5)));
    }];
    
}

- (UILabel *)directionLabel{
    if (_directionLabel == nil) {
        _directionLabel = [WLTools allocLabel:SSKJLocalized(@"做多", nil) font:systemFont(ScaleW(14)) textColor:kMarketUp frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _directionLabel.numberOfLines = 1;
    }
    return _directionLabel;
}

- (UILabel *)coinLabel{
    if (_coinLabel == nil) {
        _coinLabel = [WLTools allocLabel:SSKJLocalized(@"BTC_USDT", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
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

- (UIButton *)cheDanBtn{
    if (_cheDanBtn == nil) {
        _cheDanBtn = [WLTools allocButton:SSKJLocalized(@"撤单", nil) textColor:kBlueColor nom_bg:nil hei_bg:nil frame:CGRectZero];
        [_cheDanBtn addTarget:self action:@selector(cheDanBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _cheDanBtn.titleLabel.font = systemFont(ScaleW(14));
        _cheDanBtn.backgroundColor = kBgColor;
        _cheDanBtn.cornerRadius = ScaleW(4);
        _cheDanBtn.layer.borderColor = kBlueColor.CGColor;
        _cheDanBtn.layer.borderWidth = ScaleW(1);
    }
    return _cheDanBtn;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kBgColor;
    }
    return _lineView;
}


- (UIView *)bottomGrayView{
    if (_bottomGrayView == nil) {
        _bottomGrayView = [[UIView alloc]init];
        _bottomGrayView.backgroundColor = kBgColor;
    }
    return _bottomGrayView;
}

- (UIView *)bottomlineView{
    if (_bottomlineView == nil) {
        _bottomlineView = [[UIView alloc]init];
        _bottomlineView.backgroundColor = kLineColor;
    }
    return _bottomlineView;
}


- (UILabel *)leverageTitle{
    if (_leverageTitle == nil) {
        _leverageTitle = [WLTools allocLabel:SSKJLocalized(@"杠杆倍数", nil) font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
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

- (UILabel *)weituoPriceTitle{
    if (_weituoPriceTitle == nil) {
        _weituoPriceTitle = [WLTools allocLabel:SSKJLocalized(@"委托价", nil) font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _weituoPriceTitle.numberOfLines = 1;

    }
    return _weituoPriceTitle;
}

- (UILabel *)weituoPriceLabel{
    if (_weituoPriceLabel == nil) {
        _weituoPriceLabel = [WLTools allocLabel:SSKJLocalized(@"0.0000", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _weituoPriceLabel.numberOfLines = 1;

    }
    return _weituoPriceLabel;
}

- (UILabel *)zuixinPriceTitle{
    if (_zuixinPriceTitle == nil) {
        _zuixinPriceTitle = [WLTools allocLabel:SSKJLocalized(@"最新价", nil) font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _zuixinPriceTitle.numberOfLines = 1;

    }
    return _zuixinPriceTitle;
}

- (UILabel *)zuixinPriceLabel{
    if (_zuixinPriceLabel == nil) {
        _zuixinPriceLabel = [WLTools allocLabel:SSKJLocalized(@"0.0000", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _zuixinPriceLabel.numberOfLines = 1;

    }
    return _zuixinPriceLabel;
}


- (UILabel *)numTitle{
    if (_numTitle == nil) {
        _numTitle = [WLTools allocLabel:SSKJLocalized(@"委托量", nil) font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _numTitle.numberOfLines = 1;

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
        _baozhengjinPriceTitle = [WLTools allocLabel:SSKJLocalized(@"保证金", nil) font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
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


- (UILabel *)typeLabelTitle{
    if (_typeLabelTitle == nil) {
        _typeLabelTitle = [WLTools allocLabel:SSKJLocalized(@"类型", nil) font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _typeLabelTitle.numberOfLines = 1;
        _typeLabelTitle.adjustsFontSizeToFitWidth = YES;

    }
    return _typeLabelTitle;
}

- (UILabel *)typeLabelLabel{
    if (_typeLabelLabel == nil) {
        _typeLabelLabel = [WLTools allocLabel:SSKJLocalized(@"10", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _typeLabelLabel.numberOfLines = 1;

    }
    return _typeLabelLabel;
}

- (void)cheDanBtnAction
{
    if (self.HeyueCheDanBlock) {
        self.HeyueCheDanBlock();
    }
}

- (void)setWeituoModel:(Heyue_OrderDdetail_Model *)weituoModel{
    //方向
    NSString *type = weituoModel.otype;
    self.directionLabel.text = [NSString stringWithFormat:@"%@",type.integerValue == 1?SSKJLocalized(@"做多", nil):SSKJLocalized(@"做空", nil)];
    self.directionLabel.textColor = type.integerValue == 1?kMarketUp:kMarketDown;
    
    self.coinLabel.text = [weituoModel.code uppercaseString];
    
    
    //
    //手续费
    self.typeLabelLabel.text = SSKJLocalized(@"限价", nil);

    //时间
    self.dateLabel.text = [NSString stringWithFormat:@"%@ %@",[weituoModel.created_at substringWithRange:NSMakeRange(11, 5)],[weituoModel.created_at substringWithRange:NSMakeRange(5, 5)]];

    //委托价
    self.weituoPriceLabel.text = [SSTool HeyueCoin:weituoModel.code price:weituoModel.buyprice];
    //最新价
    self.zuixinPriceLabel.text = [SSTool HeyueCoin:weituoModel.code price:weituoModel.market_price];

    //张数
    self.numLabel.text = [NSString stringWithFormat:@"%@%@",weituoModel.sheets,SSKJLocalized(@"张", nil)];
    //保证金
    self.baozhengjinPriceLabel.text = [SSTool HeyuePname:weituoModel.code price:weituoModel.totalprice];
    
    //杠杆
    self.leverageLabel.text = [NSString stringWithFormat:@"%@",weituoModel.leverage];
    
    

}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
