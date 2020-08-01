//
//  HeBi_Market_Cell.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/9.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "Home_Market_Cell.h"

@interface Home_Market_Cell ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *coinImageView;
@property (nonatomic, strong) UILabel *coinNameLabel;

@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *cnyPriceLabel;

@property (nonatomic, strong) UILabel *rateLabel;
@property(nonatomic, strong)UIImageView *rateImageV;
@property (nonatomic, strong) NSArray *iconsArray;
@end

@implementation Home_Market_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = kBgColor;
        self.backgroundColor = kBgColor;
        self.iconsArray = @[@"BTC_Icon",
                            @"ETH_Icon",
                            @"QTUM_Icon",
                            @"NEO_Icon",
                            @"TRX_Icon",
                            @"ADA_Icon",
                            @"XLM_Icon",
                            @"BCH_Icon",
                            @"OMG_Icon",
                            @"EOS_Icon",
                            @"ETC_Icon",
                            @"ZEC_Icon",
                            @"LTC_Icon",
                            @"DASH_Icon"];
        
        [self setUI];
    }
    return self;
}

#pragma mark - UI
-(void)setUI
{
    
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.coinImageView];
    [self.backView addSubview:self.coinNameLabel];
    
    [self.contentView addSubview:self.rateImageV];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.cnyPriceLabel];
    [self.contentView addSubview:self.rateLabel];

//    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.backView.bottom - 0.5, self.width, 0.5)];
//    line.backgroundColor = kLineColor;
//    [self.contentView addSubview:line];
}

- (UIImageView *)rateImageV{
    if (!_rateImageV) {
        self.rateImageV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - ScaleW(90), 0, ScaleW(90), self.backView.height)];
        
    }
    return _rateImageV;
}

-(UILabel *)rateLabel
{
    if (nil == _rateLabel) {
        _rateLabel = [WLTools allocLabel:SSKJLocalized(@"+0%", nil) font:systemBoldFont(ScaleW(13)) textColor:kWhiteColor frame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(95), ScaleW(17), ScaleW(60), ScaleW(30)) textAlignment:NSTextAlignmentCenter];
        _rateLabel.backgroundColor = RED_HEX_COLOR;
        _rateLabel.layer.masksToBounds = YES;
        _rateLabel.layer.cornerRadius = ScaleW(5);
        _rateLabel.centerY = self.backView.centerY;
        _rateLabel.right = ScreenWidth - ScaleW(15);

    }
    return _rateLabel;
}

-(UILabel *)priceLabel
{
    if (nil == _priceLabel) {
        _priceLabel = [WLTools allocLabel:SSKJLocalized(@"0.00", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(ScaleW(165), ScaleW(15), ScaleW(120), ScaleW(15)) textAlignment:NSTextAlignmentLeft];
        _priceLabel.bottom = self.backView.centerY - ScaleW(3);
//        _priceLabel.right = ScreenWidth - ScaleW(135);

    }
    return _priceLabel;
}


-(UILabel *)cnyPriceLabel
{
    if (nil == _cnyPriceLabel) {
        _cnyPriceLabel = [WLTools allocLabel:SSKJLocalized(@"¥0.00", nil) font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(self.priceLabel.x, self.priceLabel.bottom + ScaleW(8), self.priceLabel.width, ScaleW(13)) textAlignment:NSTextAlignmentLeft];
//        _cnyPriceLabel.right = ScreenWidth - ScaleW(135);
    }
    return _cnyPriceLabel;
}

//-(UILabel *)volumeLabel
//{
//    if (nil == _volumeLabel) {
//        _volumeLabel = [WLTools allocLabel:@"24量 0" font:systemFont(ScaleW(11)) textColor:kSubTitleColor75 frame:CGRectMake(self.priceLabel.x, self.priceLabel.bottom + ScaleW(9), self.priceLabel.width, ScaleW(11)) textAlignment:NSTextAlignmentRight];
//    }
//    return _volumeLabel;
//}

-(UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScaleW(130), ScaleW(70))];
    }
    return _backView;
}

-(UIImageView *)coinImageView
{
    if (nil == _coinImageView) {
        _coinImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScaleW(17), ScaleW(30), ScaleW(30))];
        _coinImageView.centerY = self.backView.centerY;
        _coinImageView.layer.masksToBounds = YES;
        _coinImageView.layer.cornerRadius = ScaleW(3);

    }
    return _coinImageView;
}

-(UILabel *)coinNameLabel
{
    if (nil == _coinNameLabel) {
        
        _coinNameLabel = [WLTools allocLabel:@"BTC/USDT" font:systemBoldFont(ScaleW(15)) textColor:kTitleColor frame:CGRectMake(self.coinImageView.right + ScaleW(8), ScaleW(0), self.backView.width - self.coinImageView.right - ScaleW(8), ScaleW(70)) textAlignment:NSTextAlignmentLeft];
        _coinNameLabel.centerY = self.coinImageView.centerY;
//        _coinNameLabel.adjustsFontSizeToFitWidth = YES;

    }
    return _coinNameLabel;
}

#pragma mark - 加载数据
-(void)setCellWithModel:(SSKJ_Market_Index_Model *)model
{
    
    NSString *s = [model.code uppercaseString];
    NSArray *codeA = [[s uppercaseString] componentsSeparatedByString:@"_"];
    if (codeA.count>0) {
        NSString *iconName = codeA[0];
        iconName = [NSString stringWithFormat:@"%@",iconName];
        
        UIImage *image = [UIImage imageNamed:iconName];
//        self.coinImageView.width = ScaleW(image.size.width);
//        self.coinImageView.height = ScaleW(image.size.height);
//        self.coinImageView.image = image;
        
        if (model.image.length) {
            [self.coinImageView sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:model.image]] placeholderImage:image];
        }else{
            self.coinImageView.image = nil;
        }
        
    }
//    self.coinNameLabel.text = model.code;
    
    
    
    
    NSArray *codeArray = [[model.code uppercaseString] componentsSeparatedByString:@"_"];
    
    NSAttributedString *fstr = [[NSAttributedString alloc] initWithString:codeArray.firstObject attributes:@{NSForegroundColorAttributeName:kTitleColor,NSFontAttributeName:kFont(16)}];
    
    NSAttributedString *lstr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"/%@", codeArray.lastObject] attributes:@{NSForegroundColorAttributeName:kGrayColor,NSFontAttributeName:kFont(12)}];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] init];
    [attributeString appendAttributedString:fstr];
    [attributeString appendAttributedString:lstr];

    self.coinNameLabel.attributedText = attributeString;

    
    self.priceLabel.text = [SSTool MarketPname:model.code price:model.price];
    
    
    UIColor *color = RED_HEX_COLOR;
    NSString *rate = model.changeRate;
    if ((![model.change containsString:@"-"] || model.change.doubleValue >= 0)) {
        if (!model.changeRate) {
            rate = @"+0.00%";
        }else{
            rate = [@"+" stringByAppendingString:model.changeRate];
        }
        color = kMarketUp;
        
//        self.rateImageV.image = [UIImage imageNamed:@"shagnsheng"];
        self.rateLabel.backgroundColor = color;
    }else{
        rate = model.changeRate;
        color = kMarketDown;
//        self.rateImageV.image = [UIImage imageNamed:@"xia"];
        self.rateLabel.backgroundColor = color;
    }
    
    self.rateLabel.text = rate;
    self.priceLabel.textColor = color;
        
    self.cnyPriceLabel.text = [NSString stringWithFormat:@"≈%@ CNY",[WLTools roundingStringWith:model.cnyPrice.doubleValue afterPointNumber:2]];

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
