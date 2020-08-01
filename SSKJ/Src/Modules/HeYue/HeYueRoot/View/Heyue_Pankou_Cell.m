//
//  Heyue_Pankou_Cell.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/29.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_Pankou_Cell.h"

#define Pankouwidth ScreenWidth / 2

@interface Heyue_Pankou_Cell()



@end

@implementation Heyue_Pankou_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.bgView];
        
//        [self.contentView addSubview:self.noLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.numberLabel];
        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self.noLabel.mas_centerY);
            make.centerY.equalTo(self.priceLabel.mas_centerY);
            make.right.equalTo(self.contentView);
            make.width.equalTo(@((ScreenWidth / 2 - ScaleW(15))*0.3 - - ScaleW(5)));
        }];
        
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.and.top.and.bottom.equalTo(self.contentView);
            make.width.equalTo(@0);
        }];
    }
    return self;
}

- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Pankouwidth, ScaleW(25))];
        _bgView.backgroundColor = [kMarketUp colorWithAlphaComponent:0.3];
        
    }
    return _bgView;
}


- (UILabel *)noLabel{
    if (_noLabel == nil) {
        _noLabel = [WLTools allocLabel:@"1" font:systemFont(ScaleW(10)) textColor:kSubTitleColor frame:CGRectMake(0, 0, Pankouwidth * 0.2, ScaleW(25)) textAlignment:NSTextAlignmentCenter];
    }
    return _noLabel;
}

- (UILabel *)priceLabel{
    if (_priceLabel == nil) {
//        _priceLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(10)) textColor:kTitleColor frame:CGRectMake(self.noLabel.right + ScaleW(5), 0, Pankouwidth * 0.5, ScaleW(25)) textAlignment:NSTextAlignmentCenter];
        _priceLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(10)) textColor:kTitleColor frame:CGRectMake(0, 0, Pankouwidth * 0.5, ScaleW(25)) textAlignment:NSTextAlignmentCenter];

    }
    return _priceLabel;
}

- (UILabel *)numberLabel{
    if (_numberLabel == nil) {
        _numberLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(10)) textColor:kSubTitleColor frame:CGRectMake(Pankouwidth - Pankouwidth * 0.3 - ScaleW(5) , 0, Pankouwidth * 0.3 - ScaleW(5), ScaleW(25)) textAlignment:NSTextAlignmentRight];
        _numberLabel.numberOfLines = 1;
        _numberLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _numberLabel;
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
