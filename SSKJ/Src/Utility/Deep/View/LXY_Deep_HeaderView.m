//
//  LXY_Deep_HeaderView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/3/19.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "LXY_Deep_HeaderView.h"
#import "LXY_Deep_TableViewCell.h"

@interface LXY_Deep_HeaderView ()
@property (nonatomic, strong) UILabel *buyIndexLabel;
@property (nonatomic, strong) UILabel *buyAmmountLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *sellAmmountLabel;
@property (nonatomic, strong) UILabel *sellIndexLabel;
@end

@implementation LXY_Deep_HeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}


-(void)setUI
{
    [self addSubview:self.buyIndexLabel];
    [self addSubview:self.buyAmmountLabel];
    [self addSubview:self.priceLabel];
    
    [self addSubview:self.sellAmmountLabel];
    [self addSubview:self.sellIndexLabel];
}



-(UILabel *)buyIndexLabel
{
    if (nil == _buyIndexLabel) {
        _buyIndexLabel = [WLTools allocLabel:SSKJLocalized(@"买盘", nil)  font:systemFont(ScaleW(10)) textColor:[UIColor lxy_volumeColor] frame:CGRectMake(ScaleW(15), 0, ScaleW(25), kCell_Height) textAlignment:NSTextAlignmentCenter];
        
    }
    return _buyIndexLabel;
    
}

-(UILabel *)buyAmmountLabel
{
    if (nil == _buyAmmountLabel) {
        _buyAmmountLabel = [WLTools allocLabel:@"数量(BTC)" font:systemFont(ScaleW(10)) textColor:[UIColor lxy_volumeColor] frame:CGRectMake(self.buyIndexLabel.right + ScaleW(5), 0, ScaleW(100), kCell_Height) textAlignment:NSTextAlignmentLeft];
    }
    return _buyAmmountLabel;
}

-(UILabel *)priceLabel
{
    if (nil == _priceLabel) {
        _priceLabel = [WLTools allocLabel:@"价格(USDT)" font:systemFont(ScaleW(10)) textColor:[UIColor lxy_volumeColor] frame:CGRectMake(self.buyAmmountLabel.right, 0, ScaleW(150), kCell_Height) textAlignment:NSTextAlignmentCenter];
        _priceLabel.centerX = ScreenWidth / 2;
    }
    return _priceLabel;
}



-(UILabel *)sellIndexLabel
{
    if (nil == _sellIndexLabel) {
        _sellIndexLabel = [WLTools allocLabel:SSKJLocalized(@"卖盘",nil) font:systemFont(ScaleW(10)) textColor:[UIColor lxy_volumeColor] frame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(25), 0, ScaleW(25), kCell_Height) textAlignment:NSTextAlignmentCenter];
    }
    return _sellIndexLabel;
    
}


-(UILabel *)sellAmmountLabel
{
    if (nil == _sellAmmountLabel) {
        _sellAmmountLabel = [WLTools allocLabel:@"数量(BTC)" font:systemFont(ScaleW(10)) textColor:[UIColor lxy_volumeColor] frame:CGRectMake(self.sellIndexLabel.x - ScaleW(150), 0, ScaleW(150), kCell_Height) textAlignment:NSTextAlignmentRight];
    }
    return _sellAmmountLabel;
}

-(void)setCoinCode:(NSString *)coinCode
{
    NSArray *array = [coinCode componentsSeparatedByString:@"/"];
    NSString *left_code = array.firstObject;
    NSString *right_code = array.lastObject;
    self.buyAmmountLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"数量", nil),left_code];
    self.priceLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"价格", nil),right_code];
    self.sellAmmountLabel.text = [NSString stringWithFormat:@"%@(%@)",SSKJLocalized(@"数量", nil),left_code];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
