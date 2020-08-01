//
//  BuyCoin_TableViewCell.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2020/3/23.
//  Copyright © 2020 Wang. All rights reserved.
//

#import "BuyCoin_TableViewCell.h"

@interface BuyCoin_TableViewCell ()
@property (nonatomic, strong) UILabel *buyNumLabel; // 买币金额
@property (nonatomic, strong) UILabel *statusLabel; // 状态
@property (nonatomic, strong) UILabel *timeLabel;       // 购买时间

@end

@implementation BuyCoin_TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = kBgColor;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    NSArray *titleArray = @[SSKJLocalized(@"购买数量", nil),SSKJLocalized(@"状态", nil),SSKJLocalized(@"购买时间", nil)];
    
    for (int i = 0; i < titleArray.count; i++) {
        
        NSString *language = [[SSKJLocalized sharedInstance]currentLanguage];
        CGFloat width = ScaleW(65);
        if ([language containsString:@"en"]) {
            width = ScaleW(100);
        }
        
        
        UILabel *titleLabel = [WLTools allocLabel:titleArray[i] font:systemFont(ScaleW(15)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(16), ScaleW(20) + (ScaleW(23) * i), width, ScaleW(15)) textAlignment:NSTextAlignmentLeft];
        titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:titleLabel];
        
        UILabel *valueLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kTitleColor frame:CGRectMake(titleLabel.right + ScaleW(15), titleLabel.y, ScreenWidth - ScaleW(30) - titleLabel.right, ScaleW(15)) textAlignment:NSTextAlignmentLeft];
        
        [self addSubview:valueLabel];

        switch (i) {
            case 0:
                self.buyNumLabel = valueLabel;
                break;
            case 1:
                self.statusLabel = valueLabel;
                break;
            case 2:
                self.timeLabel = valueLabel;
                break;
                
            default:
                break;
        }
    }
    
}

-(void)setCellWithModel:(BuyCoinRecord_Model *)model
{
    self.buyNumLabel.text = [NSString stringWithFormat:@"%@ USDT",[WLTools noroundingStringWith:model.usdt.doubleValue afterPointNumber:2]];
    
    if (model.status.integerValue == 1) {
        self.statusLabel.text = SSKJLocalized(@"未支付", nil);
    }else{
        self.statusLabel.text = SSKJLocalized(@"已完成", nil);
    }
    self.timeLabel.text = model.created_at;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
