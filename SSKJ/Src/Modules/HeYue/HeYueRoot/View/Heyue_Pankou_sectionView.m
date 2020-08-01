//
//  Heyue_Pankou_sectionView.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/29.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_Pankou_sectionView.h"

#define Pankouwidth ScreenWidth / 2

@interface Heyue_Pankou_sectionView()

@property (nonatomic,strong) UILabel * noLabel;

@property (nonatomic,strong) UILabel * priceLabel;

@property (nonatomic,strong) UILabel * numberLabel;

@property (nonatomic,strong) UIView * bgView;

@end

@implementation Heyue_Pankou_sectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
//        [self addSubview:self.noLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.numberLabel];
    }
    return self;
}

- (UILabel *)noLabel{
    if (_noLabel == nil) {
        _noLabel = [WLTools allocLabel:SSKJLocalized(@"盘口", nil) font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(0, 0, Pankouwidth * 0.2, self.height) textAlignment:NSTextAlignmentCenter];
    }
    return _noLabel;
}

- (UILabel *)priceLabel{
    if (_priceLabel == nil) {
//        _priceLabel = [WLTools allocLabel:SSKJLocalized(@"价格", nil) font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(self.noLabel.right + ScaleW(5), 0, Pankouwidth * 0.5, self.height) textAlignment:NSTextAlignmentCenter];
        _priceLabel = [WLTools allocLabel:SSKJLocalized(@"价格", nil) font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(0, 0, Pankouwidth * 0.5, self.height) textAlignment:NSTextAlignmentCenter];

    }
    return _priceLabel;
}

- (UILabel *)numberLabel{
    if (_numberLabel == nil) {
        _numberLabel = [WLTools allocLabel:SSKJLocalized(@"数量", nil) font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(Pankouwidth - Pankouwidth * 0.3 - ScaleW(15), 0, Pankouwidth * 0.3 - ScaleW(5), self.height) textAlignment:NSTextAlignmentRight];
    }
    return _numberLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
