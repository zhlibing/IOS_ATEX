//
//  ETF_BBTrade_TableHeaderView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/1/15.
//  Copyright © 2019年 James. All rights reserved.
//

#import "ETF_BBTrade_TableHeaderView.h"

@interface ETF_BBTrade_TableHeaderView ()
@property (nonatomic, strong) UILabel *currentPricelabel;
@property (nonatomic, strong) UILabel *rateLabel;
@property (nonatomic, strong) UILabel *CNYLabel;
@property (nonatomic, strong) UILabel *highTitleLabel;
@property (nonatomic, strong) UILabel *highLabel;
@property (nonatomic, strong) UILabel *lowTitleLabel;
@property (nonatomic, strong) UILabel *lowLabel;
//@property (nonatomic, strong) UILabel *volumeTitleLabel;
//@property (nonatomic, strong) UILabel *volumeLabel;

@end

@implementation ETF_BBTrade_TableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBgColor;
        [self addSubview:self.currentPricelabel];
        [self addSubview:self.CNYLabel];
        [self addSubview:self.rateLabel];
        [self addSubview:self.highLabel];
        [self addSubview:self.highTitleLabel];
        [self addSubview:self.lowLabel];
        [self addSubview:self.lowTitleLabel];
//        [self addSubview:self.volumeTitleLabel];
//        [self addSubview:self.volumeLabel];
    }
    return self;
}

-(UILabel *)currentPricelabel
{
    if (nil == _currentPricelabel) {
        _currentPricelabel = [WLTools allocLabel:@"0000.0000" font:systemBoldFont(27) textColor:GREEN_HEX_COLOR frame:CGRectMake(ScaleW(15), ScaleW(18), ScaleW(200), ScaleW(27)) textAlignment:NSTextAlignmentLeft];
        _currentPricelabel.adjustsFontSizeToFitWidth = YES;
        _currentPricelabel.numberOfLines = 1;
    }
    return _currentPricelabel;
}

-(UILabel *)rateLabel
{
    if (nil == _rateLabel) {
        _rateLabel = [WLTools allocLabel:@"+0.00%" font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(self.CNYLabel.right + ScaleW(10), self.CNYLabel.bottom + ScaleW(10), ScaleW(80), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
        _rateLabel.centerY = self.CNYLabel.centerY;
        _rateLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _rateLabel;
}

- (UILabel *)CNYLabel
{
    if (nil == _CNYLabel) {
        _CNYLabel = [WLTools allocLabel:@"≈00000.00CNY" font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(self.currentPricelabel.x, self.currentPricelabel.bottom + ScaleW(15), ScaleW(120), ScaleW(11)) textAlignment:NSTextAlignmentLeft];
    }
    return _CNYLabel;
}

- (UILabel *)highLabel
{
    if (nil == _highLabel) {
        _highLabel = [WLTools allocLabel:@"0000.0000" font:systemFont(ScaleW(10)) textColor:kSubTitleColor frame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(70), 0, ScaleW(70), ScaleW(10)) textAlignment:NSTextAlignmentRight];
        _highLabel.centerY = self.currentPricelabel.centerY;
    }
    return _highLabel;
}

-(UILabel *)highTitleLabel
{
    if (nil == _highTitleLabel) {
        _highTitleLabel = [WLTools allocLabel:SSKJLocalized(@"高",nil)  font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(self.highLabel.x - ScaleW(10) - ScaleW(50), 0, ScaleW(50), ScaleW(12)) textAlignment:NSTextAlignmentRight];
        _highTitleLabel.centerY = self.highLabel.centerY;
    }
    return _highTitleLabel;
}

- (UILabel *)lowLabel
{
    if (nil == _lowLabel) {
        _lowLabel = [WLTools allocLabel:@"0000.0000" font:systemFont(ScaleW(10)) textColor:kSubTitleColor frame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(70), self.highTitleLabel.bottom + ScaleW(5), ScaleW(70), ScaleW(10)) textAlignment:NSTextAlignmentRight];
        _lowLabel.centerY = self.CNYLabel.centerY;
    }
    return _lowLabel;
}

-(UILabel *)lowTitleLabel
{
    if (nil == _lowTitleLabel) {
        _lowTitleLabel = [WLTools allocLabel:SSKJLocalized(@"低",nil) font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(self.highLabel.x - ScaleW(10) - ScaleW(50), 0, ScaleW(50), ScaleW(12)) textAlignment:NSTextAlignmentRight];
        _lowTitleLabel.centerY = self.lowLabel.centerY;
    }
    return _lowTitleLabel;
}

//
//- (UILabel *)volumeLabel
//{
//    if (nil == _volumeLabel) {
//        _volumeLabel = [WLTools allocLabel:@"0000.0000" font:systemFont(ScaleW(10)) textColor:[UIColor colorWithHexStringToColor:@"b3b7e9"] frame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(70), self.lowTitleLabel.bottom + ScaleW(5), ScaleW(70), ScaleW(10)) textAlignment:NSTextAlignmentRight];
//        _volumeLabel.centerY = self.rateLabel.centerY;
//    }
//    return _volumeLabel;
//}
//
//-(UILabel *)volumeTitleLabel
//{
//    if (nil == _volumeTitleLabel) {
//        _volumeTitleLabel = [WLTools allocLabel:SSKJLocalized(@"24H",nil) font:systemFont(ScaleW(12)) textColor:[UIColor colorWithHexStringToColor:@"5b5e95"] frame:CGRectMake(self.highLabel.x - ScaleW(10) - ScaleW(50), 0, ScaleW(50), ScaleW(12)) textAlignment:NSTextAlignmentRight];
//        _volumeTitleLabel.centerY = self.volumeLabel.centerY;
//    }
//    return _volumeTitleLabel;
//}


-(void)setCoinModel:(SSKJ_Market_Index_Model *)coinModel
{
    if (coinModel == nil) {
        return;
    }
    
    
    NSArray *nameArray = [[coinModel.code uppercaseString] componentsSeparatedByString:@"_"];
    
    self.currentPricelabel.text = [[SSTool MarketPname:coinModel.code price:coinModel.close] stringByAppendingString:nameArray.lastObject];
    
        
    UIColor *color;

    if (![coinModel.changeRate hasPrefix:@"-"]) {
        color = kMarketUp;
        if (coinModel.changeRate.length > 0) {
            self.rateLabel.text = [NSString stringWithFormat:@"+%@",coinModel.changeRate];
        } else {
            self.rateLabel.text = @"--";

        }
    }else{
        color = kMarketDown;

        self.rateLabel.text = coinModel.changeRate;
    }
    
    self.rateLabel.textColor = color;
    
    self.currentPricelabel.textColor = color;
    
        
    self.CNYLabel.text = [NSString stringWithFormat:@"≈%@CNY", [SSTool disposePname:@"cny" price:coinModel.cnyPrice]];
        
    self.highLabel.text = [SSTool MarketPname:coinModel.code price:coinModel.high];
        
    self.lowLabel.text = [SSTool MarketPname:coinModel.code price:coinModel.low];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
