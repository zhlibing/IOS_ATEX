//
//  My_Yuanli_Cell.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/29.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_Yuanli_Cell.h"

@interface My_Yuanli_Cell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, assign) CGFloat width;

@end

@implementation My_Yuanli_Cell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    _width=(ScreenWidth-ScaleW(30))/3.0;

    [self addSubview:self.titleLabel];
    [self addSubview:self.amountLabel];

    [self addSubview:self.timeLabel];
    self.contentView.backgroundColor=[UIColor whiteColor];
    
   

    [self addLineView];
}

-(void)addLineView{
    UIView *style = [[UIView alloc] initWithFrame:CGRectMake(0, ScaleW(60)-0.5, ScreenWidth , 0.5)];
    style.backgroundColor =kLineColor;
    
    [self addSubview:style];
}
-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        
        _titleLabel = [WLTools allocLabel:@"xx" font:systemFont(ScaleW(15)) textColor:RGBCOLOR(18,18,18) frame:CGRectMake(ScaleW(15), ScaleW(11), _width, ScaleW(40)) textAlignment:NSTextAlignmentLeft];
        _titleLabel.adjustsFontSizeToFitWidth=YES;

    }
    return _titleLabel;
}

-(UILabel *)amountLabel
{
    if (nil == _amountLabel) {
        _amountLabel = [WLTools allocLabel:@"xxx" font:systemFont(ScaleW(15)) textColor:RGBCOLOR(18,18,18) frame:CGRectMake(_width+ScaleW(15), _titleLabel.top, _width, ScaleW(40)) textAlignment:NSTextAlignmentCenter];
//        _amountLabel.centerX=self.contentView.centerX;
        
        _amountLabel.adjustsFontSizeToFitWidth=YES;
        
        
    }
    return _amountLabel;
}


-(UILabel *)timeLabel
{
    if (nil == _timeLabel) {
        _timeLabel = [WLTools allocLabel:@"xxx" font:systemFont(ScaleW(13)) textColor:RGBCOLOR(18,18,18) frame:CGRectMake(ScreenWidth-(_width-ScaleW(25))-ScaleW(15), _amountLabel.top, _width-ScaleW(25), ScaleW(40)) textAlignment:NSTextAlignmentRight];
    }
    return _timeLabel;
}



-(void)setCellWithModel:(My_Yuanli_Model *)model
{


    self.titleLabel.text = model.userUid;
    NSInteger num=[WLTools dotNumberOfAssetCoinName:@"USDT"];

        
    self.amountLabel.text = [NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:model.money.doubleValue afterPointNumber:num],@"USDT"];
    NSString *newTime=[[WLTools convertTimestamp:model.createTime.doubleValue / 1000 andFormat:@"yyyy-MM-dd HH:mm"] stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
    self.timeLabel.text = newTime ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
