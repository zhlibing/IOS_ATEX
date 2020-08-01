//
//  Setting_TableViewCell.m
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/17.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "Setting_TableViewCell.h"

@interface Setting_TableViewCell ()

@property (nonatomic, strong) UIImageView *enterImageView;

@end

@implementation Setting_TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kBgColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.enterImageView];
        [self.contentView addSubview:self.subTextLabel];
    }
    return self;
}

-(UILabel *)nameLabel
{
    if (nil == _nameLabel) {
        _nameLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), 0, ScaleW(200), ScaleW(50)) textAlignment:NSTextAlignmentLeft];
    }
    return _nameLabel;
}

-(UIImageView *)enterImageView
{
    if (nil == _enterImageView) {
        _enterImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(5), 0, ScaleW(5), ScaleW(9))];
        _enterImageView.image = [UIImage imageNamed:@"mine_next"];
        _enterImageView.centerY = self.nameLabel.centerY;
    }
    return _enterImageView;
}

-(UILabel *)subTextLabel
{
    if (nil == _subTextLabel) {
        _subTextLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectMake(self.enterImageView.x - ScaleW(200) - ScaleW(5), 0, ScaleW(200), ScaleW(50)) textAlignment:NSTextAlignmentRight];
    }
    return _subTextLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
