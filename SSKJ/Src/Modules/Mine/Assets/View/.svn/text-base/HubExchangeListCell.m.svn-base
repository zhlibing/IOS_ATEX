//
//  HubExchangeListCell.m
//  ZYW_MIT
//
//  Created by 晶雪之恋 on 2018/9/17.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "HubExchangeListCell.h"

@interface HubExchangeListCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *duihuanNumTitle;
@property (weak, nonatomic) IBOutlet UILabel *huodezichanTitle;

@end

@implementation HubExchangeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = kBgColor;
    self.duihuanNumTitle.text = SSKJLocalized(@"兑换数量", nil);
    self.duihuanNumTitle.textColor = kSubTitleColor;
    self.duihuanNumTitle.adjustsFontSizeToFitWidth = YES;
    self.huodezichanTitle.text = SSKJLocalized(@"获得资产", nil);
    self.huodezichanTitle.textColor = kSubTitleColor;
    self.timeLabel.textColor = kSubTitleColor;
    self.huodezichanTitle.adjustsFontSizeToFitWidth = YES;

    // Initialization code
}

- (void)refreshListCellWithParam:(HubExchangeCoinListModel *)model
{
    if (model)
    {
        self.titleLabel.text = model.memo;
        self.timeLabel.text = [WLTools convertTimestamp:model.addtime.doubleValue andFormat:@"yyyy-MM-dd HH:mm"];
        self.priceLabel.text = [NSString stringWithFormat:@"%.4f %@", model.exnum.doubleValue,model.expname];
        self.amountLabel.text = [NSString stringWithFormat:@"%.4f %@", model.num.doubleValue,model.pname];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
