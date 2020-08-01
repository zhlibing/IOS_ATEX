//
//  LXY_Deep_TableViewCell.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/3/19.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "LXY_Deep_TableViewCell.h"



@interface LXY_Deep_TableViewCell ()
@property (nonatomic, strong) UIView *buyBackView;
@property (nonatomic, strong) UILabel *buyIndexLabel;
@property (nonatomic, strong) UILabel *buyAmmountLabel;
@property (nonatomic, strong) UILabel *buyPriceLabel;


@property (nonatomic, strong) UIView *sellBackView;
@property (nonatomic, strong) UILabel *sellPriceLabel;
@property (nonatomic, strong) UILabel *sellAmmountLabel;
@property (nonatomic, strong) UILabel *sellIndexLabel;

@property (nonatomic, strong) UIView *lineView;
@end



@implementation LXY_Deep_TableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}


-(void)setUI
{
    [self addSubview:self.buyBackView];
    [self addSubview:self.buyIndexLabel];
    [self addSubview:self.buyAmmountLabel];
    [self addSubview:self.buyPriceLabel];
    
    [self addSubview:self.sellBackView];
    [self addSubview:self.sellPriceLabel];
    [self addSubview:self.sellAmmountLabel];
    [self addSubview:self.sellIndexLabel];
}

-(UIView *)buyBackView
{
    if (nil == _buyBackView) {
        _buyBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth / 2, kCell_Height)];
        _buyBackView.alpha = 0.2;
        _buyBackView.backgroundColor = [UIColor lxy_riseColor];
    }
    return _buyBackView;
}

-(UILabel *)buyIndexLabel
{
    if (nil == _buyIndexLabel) {
        _buyIndexLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(10)) textColor:[UIColor lxy_volumeColor] frame:CGRectMake(ScaleW(15), 0, ScaleW(30), kCell_Height) textAlignment:NSTextAlignmentCenter];

    }
    return _buyIndexLabel;
    
}

-(UILabel *)buyAmmountLabel
{
    if (nil == _buyAmmountLabel) {
        _buyAmmountLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(10)) textColor:kTitleColor frame:CGRectMake(self.buyIndexLabel.right + ScaleW(5), 0, ScaleW(70), kCell_Height) textAlignment:NSTextAlignmentLeft];
    }
    return _buyAmmountLabel;
}

-(UILabel *)buyPriceLabel
{
    if (nil == _buyPriceLabel) {
        _buyPriceLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(10)) textColor:[UIColor lxy_riseColor] frame:CGRectMake(self.buyAmmountLabel.right, 0, ScreenWidth / 2 - self.buyAmmountLabel.right - ScaleW(3), kCell_Height) textAlignment:NSTextAlignmentRight];
    }
    return _buyPriceLabel;
}



-(UIView *)sellBackView
{
    if (nil == _sellBackView) {
        _sellBackView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth / 2, 0, ScreenWidth / 2, kCell_Height)];
        _sellBackView.alpha = 0.2;
        _sellBackView.backgroundColor = [UIColor lxy_fallColor];

    }
    return _sellBackView;
}


-(UILabel *)sellPriceLabel
{
    if (nil == _sellPriceLabel) {
        _sellPriceLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(10)) textColor:[UIColor lxy_fallColor] frame:CGRectMake(ScreenWidth / 2 + ScaleW(3), 0, self.buyPriceLabel.width, kCell_Height) textAlignment:NSTextAlignmentLeft];
    }
    return _sellPriceLabel;
}


-(UILabel *)sellAmmountLabel
{
    if (nil == _sellAmmountLabel) {
        _sellAmmountLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(10)) textColor:kTitleColor frame:CGRectMake(self.sellPriceLabel.right, 0, self.buyAmmountLabel.width, kCell_Height) textAlignment:NSTextAlignmentRight];
    }
    return _sellAmmountLabel;
}


-(UILabel *)sellIndexLabel
{
    if (nil == _sellIndexLabel) {
        _sellIndexLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(10)) textColor:[UIColor lxy_volumeColor] frame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(30), 0, ScaleW(30), kCell_Height) textAlignment:NSTextAlignmentCenter];
    }
    return _sellIndexLabel;
    
}


-(void)setBuyModel:(LXY_DeepModel *)buyModel sellModel:(LXY_DeepModel *)sellModel index:(NSInteger)index maxVolume:(double)maxVolume coinCode:(nonnull NSString *)coinCode
{
    NSArray *nameArray = [coinCode componentsSeparatedByString:@"/"];

    if (buyModel) {
        self.buyIndexLabel.text = [NSString stringWithFormat:@"%ld",index + 1];
        self.buyPriceLabel.text = [WLTools roundingStringWith:buyModel.price.doubleValue afterPointNumber:[SSTool MarketPrice:coinCode]];
        
        
        self.buyAmmountLabel.text = [WLTools roundingStringWith:buyModel.volume.doubleValue afterPointNumber:[SSTool MarketNum:coinCode]];
    } else {
        self.buyIndexLabel.text = @"";
        self.buyPriceLabel.text = @"";
        self.buyAmmountLabel.text = @"";
    }
    if (sellModel) {
        self.sellIndexLabel.text = [NSString stringWithFormat:@"%ld",index + 1];
        
        self.sellPriceLabel.text = [WLTools roundingStringWith:sellModel.price.doubleValue afterPointNumber:[SSTool MarketPrice:coinCode]];
        self.sellAmmountLabel.text = [WLTools roundingStringWith:sellModel.volume.doubleValue afterPointNumber:[SSTool MarketNum:coinCode]];
        
    } else {
        self.sellIndexLabel.text = @"";
        
        self.sellPriceLabel.text = @"";
        self.sellAmmountLabel.text = @"";
    }
    
    
    double buyWidth = buyModel.volume.doubleValue / maxVolume * ScreenWidth / 2;
    double sellWidth = sellModel.volume.doubleValue / maxVolume * ScreenWidth / 2;
    
    self.buyBackView.x = ScreenWidth / 2 - buyWidth;
    self.buyBackView.width = buyWidth;
    
    self.sellBackView.width = sellWidth;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
