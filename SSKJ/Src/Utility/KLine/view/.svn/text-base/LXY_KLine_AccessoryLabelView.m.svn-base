//
//  LXY_KLine_AccessoryLabelView.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/11/9.
//  Copyright © 2018年 James. All rights reserved.
//

#import "LXY_KLine_AccessoryLabelView.h"

@interface LXY_KLine_AccessoryLabelView ()
@property (nonatomic, strong) UILabel *label;

@property(nonatomic)NSInteger coinNum;

@end

@implementation LXY_KLine_AccessoryLabelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.label];
        self.coinNum = LXY_DecimalNumber;
    }
    return self;
}

-(UILabel *)label
{
    if (nil == _label) {
        _label = [WLTools allocLabel:@"" font:systemFont(10) textColor:[UIColor lxy_MACDColor] frame:CGRectMake(0, 0, self.width, self.height) textAlignment:NSTextAlignmentLeft];
    }
    return _label;
}

-(void)showLabelWithModel:(LXY_KLine_DataModel *)model
{
    self.hidden = NO;
    
    if (self.accessoryType == LXY_ACCESSORYTYPEMACD) {
        NSString *macdTitleString = @"MACD(12,26,9)";
        NSString *macdValueString = [@"MACD:" stringByAppendingString:[SSTool disposeZeroPname:@(LXY_DecimalNumber) price:@(model.MACD)]];
        NSString *difValueString = [@"DIF:" stringByAppendingString:[SSTool disposeZeroPname:@(LXY_DecimalNumber) price:@(model.DIF)]];
        NSString *deaValueString = [@"DEA:" stringByAppendingString:[SSTool disposeZeroPname:@(LXY_DecimalNumber) price:@(model.DEA)]];
        
        NSString *totalString = [NSString stringWithFormat:@"%@    %@    %@    %@",macdTitleString,macdValueString,difValueString,deaValueString];
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:totalString];
        
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lxy_MACDColor] range:NSMakeRange(0, macdTitleString.length)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lxy_MACDColor] range:NSMakeRange(macdValueString.length + 4, macdValueString.length)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lxy_DIFColor] range:NSMakeRange(macdTitleString.length + macdValueString.length + 8, difValueString.length)];
        
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lxy_DEAColor] range:NSMakeRange(totalString.length - deaValueString.length, deaValueString.length)];
        self.label.attributedText = attributeString;
    }else if (self.accessoryType == LXY_ACCESSORYTYPEKDJ){
        NSString *kdjTitleString = @"KDJ(14,1,3)";
        NSString *KValueString = [@"K:" stringByAppendingString:[WLTools noroundingStringWith:model.KDJ_K afterPointNumber:self.coinNum]];
        NSString *DValueString = [@"D:" stringByAppendingString:[WLTools noroundingStringWith:model.KDJ_D afterPointNumber:self.coinNum]];
        NSString *JValueString = [@"J:" stringByAppendingString:[WLTools noroundingStringWith:model.KDJ_J afterPointNumber:self.coinNum]];
        
        NSString *totalString = [NSString stringWithFormat:@"%@    %@    %@    %@",kdjTitleString,KValueString,DValueString,JValueString];
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:totalString];
        
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lxy_KDJColor] range:NSMakeRange(0, kdjTitleString.length)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lxy_KDJ_KColor] range:NSMakeRange(kdjTitleString.length + 4, KValueString.length)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lxy_KDJ_DColor] range:NSMakeRange(kdjTitleString.length + KValueString.length + 8, DValueString.length)];
        
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lxy_KDJ_JColor] range:NSMakeRange(totalString.length - JValueString.length, JValueString.length)];
        self.label.attributedText = attributeString;
    }else if (self.accessoryType == LXY_ACCESSORYTYPERSI){
        NSString *RSI6ValueString = [@"RSI(6):" stringByAppendingString:[WLTools noroundingStringWith:model.RSI6 afterPointNumber:self.coinNum]];
        NSString *RSI12ValueString = [@"RSI(12):" stringByAppendingString:[WLTools noroundingStringWith:model.RSI12 afterPointNumber:self.coinNum]];
        NSString *RSI24ValueString = [@"RSI(24):" stringByAppendingString:[WLTools noroundingStringWith:model.RSI24 afterPointNumber:self.coinNum]];
        
        NSString *totalString = [NSString stringWithFormat:@"%@    %@    %@",RSI6ValueString,RSI12ValueString,RSI24ValueString];
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:totalString];
        
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lxy_RSI6Color] range:NSMakeRange(0, RSI6ValueString.length)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lxy_RSI12Color] range:NSMakeRange(RSI6ValueString.length + 4, RSI12ValueString.length)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lxy_RSI24Color] range:NSMakeRange(totalString.length - RSI24ValueString.length, RSI24ValueString.length)];
        
        self.label.attributedText = attributeString;
    }else if (self.accessoryType == LXY_ACCESSORYTYPEWR){
        NSString *WR14ValueString = [@"WR(14):" stringByAppendingString:[WLTools noroundingStringWith:model.WR14 afterPointNumber:self.coinNum]];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:WR14ValueString];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lxy_WR14Color] range:NSMakeRange(0, WR14ValueString.length)];
        self.label.attributedText = attributeString;
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
