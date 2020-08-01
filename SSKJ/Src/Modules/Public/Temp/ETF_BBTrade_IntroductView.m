//
//  ETF_BBTrade_IntroductView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/8.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "ETF_BBTrade_IntroductView.h"

@interface ETF_BBTrade_IntroductView ()
@property (nonatomic, strong) UILabel *coinNameLabel;

@property (nonatomic, strong) UILabel *timeTitleLabel;  // 发行时间
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *faxingTitleLabel;    // 发行总量
@property (nonatomic, strong) UILabel *faxingLabel;

@property (nonatomic, strong) UILabel *liutongTitleLabel;   // 流通总量
@property (nonatomic, strong) UILabel *liutongLabel;

@property (nonatomic, strong) UILabel *bookTitleLabel;  // 白皮书
@property (nonatomic, strong) UILabel *bookLabel;

@property (nonatomic, strong) UILabel *memoLabel;
@end

@implementation ETF_BBTrade_IntroductView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kBgColor;
        [self addSubview:self.coinNameLabel];
        
        [self addSubview:self.timeTitleLabel];
        [self addSubview:self.timeLabel];
        
        [self addSubview:self.faxingTitleLabel];
        [self addSubview:self.faxingLabel];
        
        [self addSubview:self.liutongTitleLabel];
        [self addSubview:self.liutongLabel];
        
        [self addSubview:self.bookTitleLabel];
        [self addSubview:self.bookLabel];
        
        [self addSubview:self.memoLabel];
        
        self.height = self.bookTitleLabel.bottom;
        
    }
    return self;
}

-(UILabel *)coinNameLabel
{
    if (nil == _coinNameLabel) {
        _coinNameLabel = [WLTools allocLabel:@"" font:systemBoldFont(ScaleW(20)) textColor:kTitleColor frame:CGRectMake(ScaleW(18), ScaleW(26), ScreenWidth - ScaleW(36), ScaleW(20)) textAlignment:NSTextAlignmentLeft];
    }
    return _coinNameLabel;
}

- (UILabel *)timeTitleLabel
{
    if (nil ==_timeTitleLabel) {
        _timeTitleLabel = [WLTools allocLabel:SSKJLocalized(@"发行时间", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(18), self.coinNameLabel.bottom + ScaleW(18), ScaleW(100), ScaleW(50)) textAlignment:NSTextAlignmentLeft];
    }
    return _timeTitleLabel;
}

-(UILabel *)timeLabel
{
    if (nil == _timeLabel) {
        _timeLabel = [WLTools allocLabel:@"2019/01/01" font:self.timeTitleLabel.font textColor:kTitleColor frame:CGRectMake(ScreenWidth - ScaleW(18) - ScaleW(200), self.timeTitleLabel.y, ScaleW(200), self.timeTitleLabel.height) textAlignment:NSTextAlignmentRight];
    }
    return _timeLabel;
}



- (UILabel *)faxingTitleLabel
{
    if (nil == _faxingTitleLabel) {
        _faxingTitleLabel = [WLTools allocLabel:SSKJLocalized(@"发行总量", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(18), self.timeTitleLabel.bottom, ScaleW(100), ScaleW(50)) textAlignment:NSTextAlignmentLeft];
    }
    return _faxingTitleLabel;
}

-(UILabel *)faxingLabel
{
    if (nil == _faxingLabel) {
        _faxingLabel = [WLTools allocLabel:@"1000万" font:self.timeTitleLabel.font textColor:kTitleColor frame:CGRectMake(self.timeLabel.x, self.faxingTitleLabel.y, ScaleW(200), self.timeTitleLabel.height) textAlignment:NSTextAlignmentRight];
    }
    return _faxingLabel;
}


- (UILabel *)liutongTitleLabel
{
    if (nil == _liutongTitleLabel) {
        _liutongTitleLabel = [WLTools allocLabel:SSKJLocalized(@"官网", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(18), self.faxingTitleLabel.bottom, ScaleW(100), ScaleW(50)) textAlignment:NSTextAlignmentLeft];
    }
    return _liutongTitleLabel;
}

-(UILabel *)liutongLabel
{
    if (nil == _liutongLabel) {
        _liutongLabel = [WLTools allocLabel:@"2019/01/01" font:self.timeTitleLabel.font textColor:kTitleColor frame:CGRectMake(self.timeLabel.x, self.liutongTitleLabel.y, ScaleW(200), self.timeTitleLabel.height) textAlignment:NSTextAlignmentRight];
    }
    return _liutongLabel;
}


- (UILabel *)bookTitleLabel
{
    if (nil == _bookTitleLabel) {
        _bookTitleLabel = [WLTools allocLabel:SSKJLocalized(@"白皮书", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(18), self.liutongTitleLabel.bottom, ScaleW(100), ScaleW(50)) textAlignment:NSTextAlignmentLeft];
    }
    return _bookTitleLabel;
}

-(UILabel *)bookLabel
{
    if (nil == _bookLabel) {
        _bookLabel = [WLTools allocLabel:@"" font:self.timeTitleLabel.font textColor:kTitleColor frame:CGRectMake(ScreenWidth - ScaleW(18) - ScaleW(300), self.bookTitleLabel.y, ScaleW(300), self.timeTitleLabel.height) textAlignment:NSTextAlignmentRight];
    }
    return _bookLabel;
}

-(UILabel *)memoLabel
{
    if (nil == _memoLabel) {
        _memoLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), self.bookLabel.bottom + ScaleW(20), ScreenWidth - ScaleW(30), 0) textAlignment:NSTextAlignmentLeft];
        _memoLabel.numberOfLines = 0;
    }
    return _memoLabel;
}

-(void)setViewWithModel:(ETF_BBTrade_Introduce_Model *)model
{
    self.coinNameLabel.text = [[model.code uppercaseString]componentsSeparatedByString:@"_"].firstObject;
    self.timeLabel.text = model.fxtime;
    self.faxingLabel.text = model.fxnum;
    self.liutongLabel.text = model.fxweb;
    self.bookLabel.text = model.fxbook;
        
    self.memoLabel.text = [WLTools flattenHTML:model.memo];

    
    CGFloat height = [model.memo boundingRectWithSize:CGSizeMake(self.memoLabel.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.memoLabel.font} context:nil].size.height;
    self.memoLabel.height = height;
    self.height = self.memoLabel.bottom + ScaleW(30);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
